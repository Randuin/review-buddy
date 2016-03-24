require 'github'
task :create_webhook do
  response = Github.new(User.first.github_access_token).token.post(
    '/repos/xuorig/sandbox-repo/hooks',
    body: JSON.dump({
      name: 'web',
      config: { url: 'https://fbzrovwodk.localtunnel.me', content_type: 'json'},
      events: ['commit_comment'],
    })
  )
end
