import { Chat, ChatRole, ChatMessage } from '@changwei/chatui'
import { AzureOpenAI, ChatCompletionChunk } from '@changwei/openai'
import { AppConfig } from '../config/AppConfig'
import List from '@ohos.util.List'
import {
  ChatCompletionSystemMessageParam,
  ChatCompletionUserMessageParam,
  IChatCompletionMessageParam
} from '@changwei/openai/src/main/ets/ChatCompletionMessageParam'
import { ChatCompletion } from '@changwei/openai/src/main/ets/ChatCompletion'

@Entry
@Component
struct ChatCompletionPage {
  openaiClient: AzureOpenAI = new AzureOpenAI(
    AppConfig.Endpoint,
    AppConfig.apiVersion,
    AppConfig.apiKey,

  )
  messages: IChatCompletionMessageParam[] = [new ChatCompletionSystemMessageParam("You are a helpful assistant.")]

  aboutToAppear() {
  }

  build() {
    Row() {
      Column() {
        Chat({
          title: 'ChatGPT',
          needTitleBar: true,
          welcomeMessage: '我是你的测试bot',
          userMessageBackgroundColor: Color.Green,
          botAvatar: $r('app.media.chatgpticon'),
          messageFontSize: 20,
          useMarkdown:true,
          onSendMessage: (ctl, message) => {
            //发送用户消息
            ctl.postMessage(message)
            //显示回复等待动画
            ctl.setTyping(true)

            this.messages.push(
              new ChatCompletionUserMessageParam(message.content, message.name)
            );
            let streamMode = true;

            this.openaiClient.chat.completions.create(
              {
                messages: this.messages,
                stream: streamMode,
                model:AppConfig.deploymentName
              }
            )
              .then((response) => {
                console.log(JSON.stringify((response)));
                if (streamMode) {
                  let resp = response as ChatCompletionChunk []
                  let output: string = ""
                  for (let chunck of resp) {
                    if(chunck?.choices[0]?.delta?.content){
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
                ctl.setTyping(true)
              })
          }
        })
      }
    }
    .height('100%')
  }
}