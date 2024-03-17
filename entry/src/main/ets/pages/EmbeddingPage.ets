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
struct Embedding {
  @State embeddingOutput: string = ""
  openaiClient: AzureOpenAI = new AzureOpenAI(
    AzureOpenAIConfig.Endpoint,
    AzureOpenAIConfig.apiVersion,
    AzureOpenAIConfig.apiKey
  )
  aboutToAppear() {
  }

  build() {
    Row() {
      Column() {
          Button('Embedding Test')
            .width('80%')
            .height(60)
            .onClick((evt) => {
              this.openaiClient.embeddings.create({
                input: "test message",
                model: "text-embedding-ada-002"
              })
                .then((response) => {
                  this.embeddingOutput = JSON.stringify(response);
                })
                .catch((error) => {
                  console.log(JSON.stringify((error)));
                })

            })
          Text(this.embeddingOutput)
            .width('100%')
            .layoutWeight(10)
            .textOverflow({
              overflow: TextOverflow.None
            })
      }
      .margin(10)
      .width('100%')
    }
    .height('100%')
  }
}