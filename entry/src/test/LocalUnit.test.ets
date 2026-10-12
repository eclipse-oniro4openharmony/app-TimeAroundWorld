import { describe, it, expect } from '@ohos/hypium'
import { City } from '../main/ets/Data/DataSource'
import { restoreCities } from '../main/ets/Data/CityListLogic'

export default function localUnitTest() {
  describe('saved city migration', () => {
    it('keeps first occurrences and saved order while upgrading zones', 0, () => {
      const saved: City[] = [
        { name: 'Warsaw', timezone: 'old-zone', headerWord: 'W' },
        { name: 'London', timezone: 'old-zone', headerWord: 'L' },
        { name: 'Warsaw', timezone: 'old-zone', headerWord: 'W' },
        { name: 'Unknown', timezone: 'invalid', headerWord: 'U' }
      ]
      const catalog: City[] = [
        { name: 'London', timezone: 'Europe/London', headerWord: 'L' },
        { name: 'Warsaw', timezone: 'Europe/Warsaw', headerWord: 'W' }
      ]
      const restored = restoreCities(saved, catalog)
      expect(restored.length).assertEqual(2)
      expect(restored[0].name).assertEqual('Warsaw')
      expect(restored[0].timezone).assertEqual('Europe/Warsaw')
      expect(restored[1].name).assertEqual('London')
    })
  })
}
