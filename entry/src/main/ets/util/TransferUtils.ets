export function resource2Str(context: Context, resource: Resource) {
  return context.resourceManager.getStringSync(resource)
}