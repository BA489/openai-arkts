import { Chat, ChatRole, ChatMessage } from '@changwei/chatui'
import { AzureOpenAI, ChatCompletionChunk } from '@changwei/openai'
import { AzureOpenAIConfig } from '../config/AppConfig'
import List from '@ohos.util.List'
import {
  ChatCompletionSystemMessageParam,
  ChatCompletionUserMessageParam,
  IChatCompletionMessageParam
} from '@changwei/openai/src/main/ets/ChatCompletionMessageParam'
import { ChatCompletion } from '@changwei/openai/src/main/ets/ChatCompletion'

@Entry
@Component
struct AzureChatCompletionPage {
  openaiClient: AzureOpenAI = new AzureOpenAI(
    AzureOpenAIConfig.Endpoint,
    AzureOpenAIConfig.apiVersion,
    AzureOpenAIConfig.apiKey,
  )
  messages: IChatCompletionMessageParam[] = [new ChatCompletionSystemMessageParam("You are a helpful assistant.")]

  aboutToAppear() {
  }

  build() {
    Row() {
      Column() {
        Chat({
          title: 'Azure GPT-4',
          needTitleBar: true,
          welcomeMessage: '我是你的测试bot',
          needBackButton: true,
          userMessageBackgroundColor: Color.Green,
          userMessageTextColor:Color.Black,
          botAvatar: $r('app.media.chatgpticon'),
          messageFontSize: 20,
          useMarkdown: true,
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
                model: AzureOpenAIConfig.deploymentName
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