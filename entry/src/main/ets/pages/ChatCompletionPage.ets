import { Chat, ChatRole, ChatMessage } from '@changwei/chatui'
import { OpenAIConfig } from '../config/AppConfig'
import {
  ChatCompletionSystemMessageParam,
  ChatCompletionUserMessageParam,
  IChatCompletionMessageParam,
  ChatCompletionChunk,
  OpenAI,
  ChatCompletion
} from '@changwei/openai'

@Entry
@Component
struct ChatCompletionPage {
  openaiClient: OpenAI = new OpenAI(
    OpenAIConfig.apiKey
  )
  messages: IChatCompletionMessageParam[] = [new ChatCompletionSystemMessageParam("You are a helpful assistant.")]

  aboutToAppear() {
  }

  build() {
    Row() {
      Column() {
        Chat({
          title: 'ChatGPT 3.5-turbo',
          needTitleBar: true,
          welcomeMessage: '我是你的测试bot',
          userMessageBackgroundColor: Color.Green,
          userMessageTextColor:Color.Black,
          botAvatar: $r('app.media.chatgpticon'),
          messageFontSize: 20,
          useMarkdown: true,
          needBackButton: true,
          onSendMessage: (ctl, message) => {
            //发送用户消息
            ctl.postMessage(message)
            //显示回复等待动画
            ctl.setTyping(true)

            this.messages.push(
              new ChatCompletionUserMessageParam(message.content, message.name)
            );
            let streamMode = false;

            this.openaiClient.chat.completions.create(
              {
                messages: this.messages,
                stream: streamMode,
                model:OpenAIConfig.model
              }
            )
              .then((response) => {
                console.log(JSON.stringify((response)));
                if (streamMode) {
                  let resp = response as ChatCompletionChunk []
                  let output: string = ""
                  for (let chunck of resp) {
                    if (chunck?.choices[0]?.delta?.content) {
                      output += chunck.choices[0].delta.content as string
                    }
                  }

                  ctl.postMessage(
                    new ChatMessage(
                      ChatRole.Assistant,
                      output
                    )
                  );
                }
                else {
                  let resp: ChatCompletion = response as ChatCompletion
                  ctl.postMessage(
                    new ChatMessage(
                      ChatRole.Assistant,
                      (resp.choices[0].message.content as string)
                    )
                  );
                }

              })
              .catch((error) => {
                console.log(JSON.stringify((error)));
                ctl.setTyping(false)
              })
          }
        })
      }
    }
    .height('100%')
  }
}