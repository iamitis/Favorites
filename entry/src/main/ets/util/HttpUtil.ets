import { http } from '@kit.NetworkKit';

export default async function httpGet(url: string) {
  if (!url) {
    return undefined;
  }

  let request = http.createHttp();

  let result = await request.request(
    url,
    {
      method: http.RequestMethod.GET,
      header: {'Content-Type': 'application/json'},
    }
  );

  return result;
}