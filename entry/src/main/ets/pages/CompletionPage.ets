import { Chat, ChatRole, ChatMessage } from '@changwei/chatui'
import { OpenAIConfig } from '../config/AppConfig'
import { OpenAI, Completion } from '@changwei/openai'

@Entry
@Component
struct CompletionPage {
  openaiClient: OpenAI = new OpenAI(
   OpenAIConfig.apiKey
  )
  @State completionContent: string = ''

  build() {
    Row() {
      Column() {
        Text('Completion API')
          .fontWeight(FontWeight.Bold)
          .margin(15)

        TextInput()
          .width('100%')
          .margin(15)
        Button('提交')
          .width('80%')
          .onClick((evt) => {
            this.openaiClient.completions.create({
              model: "gpt-3.5-turbo-instruct",
              prompt: "Say this is a test",
              max_tokens: 7,
              temperature: 0
            })
              .then((response: Completion) => {
                console.log(JSON.stringify(response));
                this.completionContent = response.choices[0].text;
              })
              .catch((error) => {
                console.log(JSON.stringify(error));
              })
          })
        Text('补全内容：')
          .alignSelf(ItemAlign.Start)
          .margin(15)
        Text(this.completionContent)
          .backgroundColor(Color.Grey)
          .width('100%')
          .padding(15)
          .textAlign(TextAlign.Start)
          .fontColor(Color.White)

      }
      .height('100%')
    }
    .height('100%')
  }
}