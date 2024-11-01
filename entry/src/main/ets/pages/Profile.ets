import { UserInfo } from '../model/ProfileModel'

@Component
export struct Profile {
  @State userInfo: UserInfo = new UserInfo()

  build() {
    Column() {
      this.UserCard(this.userInfo)
    }
  }

  @Builder
  UserCard(userInfo: UserInfo) {
    Column() {
      Image(userInfo.userAvatar)
        .width('200')
        .height('200')
      Text(userInfo.userName)
      Text(userInfo.userDesc)
    }
  }
}