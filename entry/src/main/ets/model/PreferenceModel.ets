import { preferences } from '@kit.ArkData'
import Logger from '../util/Logger';
import { promptAction } from '@kit.ArkUI';
import { ColorMode } from '../common/constant/ThemeConstants';

let context = getContext(this);
let preference: preferences.Preferences;

class PreferenceModel {
  private colorMode: ColorMode = ColorMode.LIGHT;

  async getPreferencesModelFromStorage() {
    try {
      preference = await preferences.getPreferences(context, "COLOR_MODE_PREFERENCES");
    } catch (err) {
      Logger.error(`Failed to get preferences from storage, Cause: ${err}`);
    }
  }

  async getPreference() {
    let colorMode = '';

    if (!preference) {
      await this.getPreferencesModelFromStorage();
    }

    try {
      colorMode = (await preference.get("COLOR_MODE", '')).toString();
    } catch (err) {
      Logger.error(`Failed to get color mode from preference, Cause: ${err}`);
    }

    if (colorMode === '') {
      await this.putPreference(ColorMode.LIGHT);
      colorMode = ColorMode.LIGHT.toString();
    }

    return JSON.parse(colorMode);
  }

  async putPreference(newColorMode: ColorMode) {
    if (!preference) {
      await this.getPreferencesModelFromStorage();
    }

    try {
      await preference.put("COLOR_MODE", JSON.stringify(newColorMode));
    } catch (err) {
      Logger.error(`Failed to put new color mode to preference, Cause: ${err}`);
    }

    await preference.flush();
  }

  async getColorMode() {
    this.colorMode = await this.getPreference();
    return this.colorMode;
  }

  async changeColorMode(newColorMode: ColorMode) {
    this.putPreference(newColorMode);
  }

  /**
   * Popup window prompt message.
   *
   * @param message Prompt message.
   */
  showToastMessage(message: Resource) {
    promptAction.showToast({
      message: message,
      duration: 3000
    });
  };
}

export default new PreferenceModel();
