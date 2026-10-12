import { City } from './DataSource'

// Preserve the first saved occurrence and its position while upgrading catalog entries.
export function restoreCities(savedCities: City[], catalog: City[]): City[] {
  const names = new Set<string>()
  const restored: City[] = []
  for (const saved of savedCities) {
    if (names.has(saved.name)) {
      continue
    }
    const current = catalog.find((city: City) => city.name === saved.name)
    const city = current ?? saved
    if (!city.timezone.includes('/')) {
      continue
    }
    names.add(city.name)
    restored.push(city)
  }
  return restored
}
