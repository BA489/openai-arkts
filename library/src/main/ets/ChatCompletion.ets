export enum FinishReason {
  stop = "stop",
  length = "length",
  tool_calls = "tool_calls",
  content_filter = "content_filter",
  function_call = "function_call"
}

export class CompletionUsage {
  //Number of tokens in the generated completion.
  completion_tokens: number
  //Number of tokens in the prompt.
  prompt_tokens: number
  /*Total number of tokens used in the request (prompt + completion).*/
  total_tokens: number
}

export class Function {
  arguments: string
  name: string
}

export class FunctionCall {
  arguments: string
  name: string
}

export class ChatCompletionMessageToolCall {
  id: string
  function: Function
  type: string = "function"
}

export class ChatCompletionMessage {
  role: string
  name?: string
  content?: string | string[]
  function_call?: FunctionCall
  tool_calls?: ChatCompletionMessageToolCall[]
}

export class TopLogprob {
  token: string
  bytes: number[]
  logprob: number
}

export class ChatCompletionTokenLogprob {
  token: string
  bytes: number[]
  logprob: number
  top_logprobs: TopLogprob[]
}

export class ChoiceLogprobs {
  content?: ChatCompletionTokenLogprob[]
}

export class Choice {
  finish_reason: string[] = ["stop", "length", "tool_calls", "content_filter", "function_call"]
  index: number
  message: ChatCompletionMessage
  logprobs?: ChoiceLogprobs
}


export class ChatCompletion {
  id: string
  choices: Choice[]
  created: number
  model: string
  object: string = "chat.completion"
  system_fingerprint?: string
  usage?: CompletionUsage
}