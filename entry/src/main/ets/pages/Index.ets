import router from '@ohos.router';

@Entry
@Component
struct Index {

  aboutToAppear() {
  }

  build() {
    Row() {
      Column() {
        Button("Chat Completion")
          .width("80%")
          .height(60)
          .onClick((evt)=>{
            router.pushUrl({
              url:"pages/ChatCompletionPage"
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
      }
      .width('100%')
    }
    .height('100%')
  }
}