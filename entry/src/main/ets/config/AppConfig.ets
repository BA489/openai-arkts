export class AppConfig {
  // Azure OpenAI https://xxx.openai.azure.com/
  // OpenAI.com
  public static readonly Endpoint: string = "[your openai endpoint]"
  // openai.com key： sk-xxxxxx
  // Azure OpenAI key: xxxxxx
  public static readonly apiKey: string = "[your key]"
  // Azure OpenAI required
  public static readonly apiVersion: string = "2023-05-15"
  //使用Azure OpenAI。提供Deployment Name
  public static readonly deploymentName: string = "[your Azure OpenAI deployment name]"
  //使用OpenAI.com，提供的model name
  public static readonly model: string = "gpt-3.5-turbo" //"[openai.com的模型名]"
}