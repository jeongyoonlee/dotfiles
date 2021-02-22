# Git Commands

## Troubleshooting

### Error on `git pull`: Unable to update local ref

Reference: [Stackoverflow](https://stackoverflow.com/questions/10068640/git-error-on-git-pull-unable-to-update-local-ref)

```bash
$ git gc --prune=now
$ git remote prune origin
```

