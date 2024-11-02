import CategoryModel from '../model/CategoryModel'
import DataModel from '../model/DataModel'
import { ArticleData } from './ArticleData'

export class CategoryData {
  categoryName: string = "新类别"
  articles: ArticleData[] = []

  constructor(categoryName: string = "新类别", articles: ArticleData[] = []) {
    this.categoryName = categoryName;
    this.articles = articles;
  }
}