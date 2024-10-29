import { Blogs } from './Blogs'
import { Categories } from './Categories'
import { Profile } from './Profile'

@Entry
@Component
struct Index {
  build() {
    Tabs() {
      // TabContent() {
      //   Profile()
      // }.tabBar('Profile')

      TabContent() {
        Categories()
      }.tabBar('Category')

      TabContent() {
        Blogs()
      }.tabBar('Blog')
    }
  }
}