import { preferences } from '@kit.ArkData'
import Logger from '../util/Logger';
import { promptAction } from '@kit.ArkUI';
import { ColorMode } from '../common/constant/ThemeConstants';
import { CategoryData } from '../viewModel/CategoryData';
import DataModel from './DataModel';

let context = getContext(this);
let preference: preferences.Preferences;

class PreferenceModel {
  private colorMode: ColorMode = ColorMode.LIGHT;

  getPreferencesModelFromStorage() {
    try {
      preference = preferences.getPreferencesSync(context, {name: "FAVORITE_PREFERENCE"});
    } catch (err) {
      Logger.error(`Failed to get preferences from storage, Cause: ${err}`);
    }
  }

  getPreference<T>(name: string): T {
    let value = '';

    if (!preference) {
      this.getPreferencesModelFromStorage();
    }

    try {
      value = preference.getSync(name, ColorMode.LIGHT).toString();
    } catch (err) {
      Logger.error(`Failed to get ${name} from preference, Cause: ${err}`);
    }

    return JSON.parse(value);
  }

  async putPreference<T>(name: string, value: T) {
    if (!preference) {
      this.getPreferencesModelFromStorage();
    }

    try {
      preference.putSync(name, JSON.stringify(value));
    } catch (err) {
      Logger.error(`Failed to put ${name} to preference, Cause: ${err}`);
    }

    await preference.flush();
  }

  async deletePreference(name: string) {
    try {
      preference.deleteSync(name);
    } catch (err) {
      Logger.error(`Failed to delete ${name}, Cause: ${err}`);
    }

    await preference.flush();
  }

  getColorMode() {
    this.colorMode = this.getPreference<ColorMode>("COLOR_MODE");
    return this.colorMode;
  }

  changeColorMode(newColorMode: ColorMode) {
    this.putPreference("COLOR_MODE", newColorMode);
  }

  getAllKeys() {
    let pairs = preference.getAllSync();
    return Object.keys(pairs);
  }

  async getAllCategories() {
    let cateNames = this.getAllKeys();
    let count = cateNames.length;

    if (count < 2) {
      let categories = DataModel.DEFAULT_CATEGORIES;
      let defaultCount = categories.length;

      for (let i = 0; i < defaultCount; ++i) {
        await this.addCategory(categories[i]);
      }

      cateNames = this.getAllKeys();
      count = cateNames.length;
    }

    let categories: Array<CategoryData> = [];

    for (let i = 0; i < count; ++i) {
      if (cateNames[i] !== "COLOR_MODE") {
        categories.push(this.getPreference(cateNames[i]));
      }
    }

    return categories;
  }

  getCategoryByName(categoryName: string) {
    return this.getPreference<CategoryData>(categoryName);
  }

  async addCategory(category: CategoryData) {
    this.putPreference(category.categoryName, category);
  }

  async removeCategory(category: CategoryData) {
    await this.deletePreference(category.categoryName);
  }

  /**
   * Popup window prompt message.
   *
   * @param message Prompt message.
   */
  showToastMessage(message: string) {
    promptAction.showToast({
      message: message,
      duration: 3000
    });
  };
}

export default new PreferenceModel();
