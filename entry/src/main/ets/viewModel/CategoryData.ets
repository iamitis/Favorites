import CategoryModel from '../model/CategoryModel'
import DataModel from '../model/DataModel'
import { ArticleData } from './ArticleData'

export class CategoryData {
  categoryName: string = "文档"
  articles: ArticleData[] = []
}