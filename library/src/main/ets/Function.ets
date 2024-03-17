export class Function {
  name: string
  description: string
  parameters: Map<string, object>
}

export class ResponseFormat {
  // ["text", "json_object"]
  type: string
}

export class ChatCompletionNamedToolChoiceParam {
  function: Function
  type: string = "function"
}

export class ChatCompletionToolParam {
  function: FunctionDefinition
}

export class FunctionDefinition {
  name: string
  description: string
  parameters: Map<string, object>
}

export class ChatCompletionFunctionCallOptionParam {
  name: string
}

