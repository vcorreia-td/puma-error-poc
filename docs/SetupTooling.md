# Tooling

This page details how to setup tooling for a new application (in Heroku).

## LogEntries

1. Using Heroku web interface, go to your application.
2. Under the **Resources**, below the Dynos information, search for LogEntries.
3. Add the addon to your application, using the free **TryIt** plan.
4. Repeat for the other environments.

For Production, contact the SRE team when the application is ready for PROD deploy so that they change LogEntries to the unified account.

## NewRelic

**Important:** \
Make sure `newrelic.yml` has different `app_name` properties for each environment. The recommended way is to use `APP_NAME`, but to be sure add a hardcoded fallback:
```
staging:
  <<: *default_settings
  app_name: <%= ENV['APP_NAME'] || "td-s-apps-notifications" %>
```

1. [Login in NewRelic](https://rpm.newrelic.com/accounts/1596347/applications) (contact your team lead or Raoul if you don't have access)
2. Switch to the relevant account (Top Right corner)
   * TalkdeskPRD
   * TalkdeskQA
   * TalkdeskSTG
3. Click **ADD more** at the top of the list
4. Select the web agent to install, in this case, Ruby
5. Reveal NewRelic License Key
6. Set the `NEW_RELIC_LICENSE_KEY` with the provided value
7. Deploy your application

If all goes well, after 5 minutes you should see your application in the list and metrics should be coming in.

## Bugsnag

1. [Login to Bugsnag](https://app.bugsnag.com/talkdesk/overview)
2. Click **Return do Dashboard** on the top left corner
3. Click the name of the application on the top left corner and then click **New Project** at the end of the list
4. Give a name to the project. Do not make this environment dependent, as Bugsnag aggregates all environments.
5. Select an appropriate language/framework.
   * **Sinatra** is available.
   * For a consumer, perhaps "Other" is better.
6. After the project is created, you can change it's setting and setup slack integration
   * Note, filtering by environment (staging, qa, production) is only available after an error has ocurred. Therefore, if you have notifications for different channels, you'll need to have errors in all environments before you can configure more integrations.

## Datadog

If you're building a consumer, the existing alerts in Datadog are independent of the queue, so you don't need to do anything.
If you want a dedicated dashboard, feel free to add it.
