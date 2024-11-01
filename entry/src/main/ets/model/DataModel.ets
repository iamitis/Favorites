import { ArticleData } from '../viewModel/ArticleData'
import { CategoryData } from '../viewModel/CategoryData'
import { UserInfo } from './ProfileModel'

export default class DataModel {
  public static readonly USER_INFO: UserInfo[] = [
    {
      userName: $r('app.string.Default_user_name'),
      userDesc: $r('app.string.Default_user_desc'),
      userAvatar: $r('app.media.default_avatar')
    }
  ]

  public static readonly DOCS_ARTICLE_1: ArticleData = {
    articleName: "HarmonyOS开发文档",
    webUrl: "https://developer.huawei.com/consumer/cn/doc/"
  }

  public static readonly DOCS_ARTICLE_2: ArticleData = {
    articleName: "Git官方文档",
    webUrl: "https://git-scm.com/book/zh/v2"
  }

  public static readonly DOCS_ARTICLES: ArticleData[] = [
    this.DOCS_ARTICLE_1,
    this.DOCS_ARTICLE_2
  ]

  public static readonly TOOLS_ARTICLE_1: ArticleData = {
    articleName: "github",
    webUrl: "https://github.com/iamitis"
  }

  public static readonly TOOLS_ARTICLE_2: ArticleData = {
    articleName: "飞书",
    webUrl: "https://www.feishu.cn/"
  }

  public static readonly TOOLS_ARTICLES: ArticleData[] = [
    this.TOOLS_ARTICLE_1,
    this.TOOLS_ARTICLE_2
  ]

  public static readonly DEFAULT_CATEGORIES: CategoryData[] = [
    {
      categoryName: "文档",
      articles: this.DOCS_ARTICLES
    },
    {
      categoryName: "实用工具",
      articles: this.TOOLS_ARTICLES
    }
  ]
}