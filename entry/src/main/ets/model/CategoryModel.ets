import DataModel from './DataModel'
import PreferenceModel from './PreferenceModel'

export default class CategoryModel {

  public async loadCategories() {
    return await PreferenceModel.getAllCategories();
  }

}