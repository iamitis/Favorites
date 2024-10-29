import DataModel from '../model/DataModel'
import { ArticleData } from './ArticleData'

export class CategoryData {
  categoryName: Resource = $r('app.string.Default_cate_name')
  articles: ArticleData[] = []
}