import { ArticleData } from '../viewModel/ArticleData'
import { CategoryData } from '../viewModel/CategoryData'
import { UserInfo } from '../viewModel/ProfileModel'

export default class DataModel {
  public static readonly USER_INFO: UserInfo[] = [
    {
      userName: $r('app.string.Default_user_name'),
      userDesc: $r('app.string.Default_user_desc'),
      userAvatar: $r('app.media.default_avatar')
    }
  ]

  public static readonly DEFAULT_ARTICLE_1: ArticleData = {
    articleName: $r('app.string.Default_article_name_1'),
    articlePage: $r('app.string.Default_article_page_1'),
    webUrl: 'https://iamitis.github.io/my-pages/'
  }

  public static readonly DEFAULT_ARTICLE_2: ArticleData = {
    articleName: $r('app.string.Default_article_name_2'),
    articlePage: $r('app.string.Default_article_page_2'),
    webUrl: 'https://iamitis.github.io/my-pages/'
  }

  public static readonly DEFAULT_ARTICLES: ArticleData[] = [
    this.DEFAULT_ARTICLE_1,
    this.DEFAULT_ARTICLE_2
  ]

  public static readonly DEFAULT_CATEGORY: CategoryData[] = [
    {
      categoryName: $r('app.string.Default_cate_name'),
      articles: this.DEFAULT_ARTICLES
    },
    {
      categoryName: $r('app.string.Category_OS'),
      articles: [
        {
          articleName: $r('app.string.Article_OS_VFS_name'),
          articlePage: $r('app.string.Article_OS_VFS_page'),
          webUrl: 'https://iamitis.github.io/my-pages/'
        },
        {
          articleName: $r('app.string.Article_OS_sem_name'),
          articlePage: $r('app.string.Article_OS_sem_page'),
          webUrl: 'https://iamitis.github.io/my-pages/'
        }
      ]
    }
  ]
}