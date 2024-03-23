# openai-arkts

#### Introduction
OpenAI SDK Hongmeng native version, written in ArkTS, supports ChatCompletiong, Embedding and other interface implementation, the calling method is the same as the python SDK

[Watch the demo video] (https://www.ixigua.com/7347279931354645026 )
## Download and install

```javascript
ohpm install @changwei/openai
```

For more information about the OpenHarmony ohpm environment configuration, please refer to [How to install the OpenHarmony ohpm package] (https://gitee.com/openharmony-tpc/docs/blob/master/OpenHarmony_har_usage.md )



## Interface and attribute list

Can be in platform.openai.com Find the REST API documentation on.
If you use Azure OpenAI service, please visit:https://learn.microsoft.com/en-us/azure/ai-services/openai/chatgpt-quickstart


## How to use

#### 使用openai.com API

```typescript
import { OpenAI } from '@changwei/openai'

openaiClient: OpenAI = new OpenAI(
    "your sk-xxx"
)
openaiClient.chat.completions.create(
    {
        messages: [
            {
                "role": "user",
                "content": "Say this is a test",
            }
        ],
        model: "gpt-3.5-turbo",
    }
)
```
#### Use Azure OpenAI Chat API

```typescript
import { AzureOpenAI } from '@changwei/openai'

openaiClient: AzureOpenAI = new AzureOpenAI(
    // https://learn.microsoft.com/en-us/azure/cognitive-services/openai/how-to/create-resource?pivots=web-portal#create-a-resource
    "your endpoint",
    // https://learn.microsoft.com/en-us/azure/ai-services/openai/reference#rest-api-versioning
    "2023-07-01-preview",
    "your api-key"
)
openaiClient.chat.completions.create(
    {
        messages: [
            {
                "role": "user",
                "content": "Say this is a test",
            }
        ],
        model: "deployment-name"  // e.g. gpt-35-instant
    }
)
```


#### Streaming interface
Because axios currently does not support SSE mode, there is a delay in streaming implementation here.Here is openai.com interface call as an example
```typescript
import { OpenAI,ChatCompletionChunk } from '@changwei/openai'

openaiClient: OpenAI = new OpenAI(
    "your sk-xxx"
)
openaiClient.chat.completions.create(
    {
        messages: [
            {
                "role": "user",
                "content": "Say this is a test",
                stream: true
            }
        ],
        model: "gpt-3.5-turbo",
    }
)
.then((response) => {
    console.log(JSON.stringify((response)));
    let resp = response as ChatCompletionChunk[]
    let output: string = ""
    for (let chunck of resp) {
        if (chunck?.choices[0]?.delta?.content) {
            output += chunck.choices[0].delta.content as string
        }
    }
    console.log(output);
})
.catch((error) => {
    console.log(JSON.stringify((error)));
})

```

#### Embedding interface
```typescript
 import { OpenAI } from '@changwei/openai'

openaiClient: OpenAI = new OpenAI(
    "your sk-xxx"
)
openaiClient.embeddings.create({
                input: "your input text",
                model: "text-embedding-ada-002"
              })
```

#### Access the original response data (such as header)
```typescript
import { OpenAI } from '@changwei/openai'

openaiClient: OpenAI = new OpenAI(
    "your sk-xxx"
)
openaiClient.chat.completions.with_raw_response.create(
    {
        messages: [
            {
                "role": "user",
                "content": "Say this is a test",
            }
        ],
        model: "gpt-3.5-turbo",
    }
)
.then((response)=>{
    console.log(response.headers["content-type"]);
    let completion = response.parse();
    console.log(completion);
        
})

```

#### Completion API Text Completion
```typescript
openaiClient.completions.create({
              model: "gpt-3.5-turbo-instruct",
              prompt: "Say this is a test",
              max_tokens: 7,
              temperature: 0
            })
```

## Constraints and restrictions

Verified in the following version：
DevEco Studio: 4.0.0.600, SDK: API9

## Contribute code

If you find any problems during use, you can mention [Issue] (https://gitee.com/changweizhang/ChatUI/issues ) Give it to me.

## Open source protocol

This project is based on [MIT] (https://gitee.com/openharmony-sig/axios/blob/master/LICENSE ), please enjoy and participate in open source freely.

## Contact me

Station B @[Changwei Classmate] (https://space.bilibili.com/395257724 )

Douyin/Watermelon @梦断code

**Seeking likes, seeking attention, seeking sharing**
