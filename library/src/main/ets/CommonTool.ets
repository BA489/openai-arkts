export class CommonTool {
  public static encodeUrlParams(params: {}): string {
    let paramsArry = []
    if (params) {
      for (let key in params) {
        paramsArry.push(`${key}=${params[key]}`)
      }
    }
    if (paramsArry.length > 0)
      return `?${paramsArry.join("&")}`;
    else {
      return "";
    }
  }
}