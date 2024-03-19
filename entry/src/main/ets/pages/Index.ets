import router from '@ohos.router';

@Entry
@Component
struct Index {

  aboutToAppear() {
  }

  build() {
    Row() {
      Column() {
        Text('OpenAI SDK for HarmonyOS')
          .width('100%')
          .height(100)
          .textAlign(TextAlign.Center)
          .fontWeight(FontWeight.Bolder)
          .fontSize(30)
        Button("OpenAI.com ChatCompletion")
          .width("80%")
          .height(60)
          .onClick((evt)=>{
            router.pushUrl({
              url:"pages/ChatCompletionPage"
            })
          })
          .margin(10)
        Button("Azure OpenAI ChatCompletion")
          .width("80%")
          .height(60)
          .onClick((evt)=>{
            router.pushUrl({
              url:"pages/AzureChatCompletionPage"
            })
          })
          .margin(10)

        Button("Embedding")
          .width("80%")
          .height(60)
          .onClick((evt)=>{
            router.pushUrl({
              url:"pages/EmbeddingPage"
            })
          })
          .margin(10)
        Button("Completion")
          .width("80%")
          .height(60)
          .onClick((evt)=>{
            router.pushUrl({
              url:"pages/CompletionPage"
            })
          })
          .margin(10)
      }
      .width('100%')
    }
    .height('100%')
  }
}