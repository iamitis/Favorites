import { ArticleData } from '../viewModel/ArticleData'
import { CategoryData } from '../viewModel/CategoryData'
import { CityData } from '../viewModel/WeatherModel'
import { UserInfo } from './ProfileModel'

export default class DataModel {
  public static readonly USER_INFO: UserInfo[] = [
    {
      userName: $r('app.string.Default_user_name'),
      userDesc: $r('app.string.Default_user_desc'),
      userAvatar: $r('app.media.default_avatar')
    }
  ];
  public static readonly DOCS_ARTICLE_1: ArticleData = {
    articleName: "HarmonyOS开发文档",
    webUrl: "https://developer.huawei.com/consumer/cn/doc/"
  };
  public static readonly DOCS_ARTICLE_2: ArticleData = {
    articleName: "Git官方文档",
    webUrl: "https://git-scm.com/book/zh/v2"
  };
  public static readonly DOCS_ARTICLES: ArticleData[] = [
    this.DOCS_ARTICLE_1,
    this.DOCS_ARTICLE_2
  ];
  public static readonly BOOKS_ARTICLE_1: ArticleData = {
    articleName: "Operating Systems: Three Easy Pieces",
    webUrl: "https://pages.cs.wisc.edu/~remzi/OSTEP/#book-chapters"
  };
  public static readonly BOOKS_ARTICLE_2: ArticleData = {
    articleName: "Flutter实战",
    webUrl: "https://book.flutterchina.club/"
  };
  public static readonly BOOKS_ARTICLES: ArticleData[] = [
    this.BOOKS_ARTICLE_1,
    this.BOOKS_ARTICLE_2
  ];
  public static readonly DEFAULT_CATEGORIES: CategoryData[] = [
    new CategoryData("文档", this.DOCS_ARTICLES),
    new CategoryData("电子书", this.BOOKS_ARTICLES),
  ];
  public static readonly CITIES: CityData[] = [
    new CityData("北京", "110000"),
    new CityData("南京", "320100"),
    new CityData("上海", "310000"),
    new CityData("广州", "440100"),
  ];
  public static readonly WEATHER_REQUEST_ADDR: string = "https://restapi.amap.com/v3/weather/weatherInfo?";
  public static readonly WEATHER_REQUEST_KEY: string = "645e29644a6f52fad44588f87a03ca79";
}