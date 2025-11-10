# SKOGIX.md

this is the steps taken to create this hello world plugin: 

1. create a new folder called hello-world
2. /skogai-builder:create-command "hello-world" "takes a name as a input and expects claude to return a improvised hello <name>-response"
3. /skogai-builder:create-agent "hello-world-agent" "specializes in making a hello world-version of a input type. if asked to use javascript the agent would create hello world in javascript"
4. /skogai-builder:create-hook "on session start" "every time" "print out a hello world <sessionid>"
5. /skogai-builder:create-output-style "hello-greeter" --project --description "for testing purposes this agent should answer like a stereotypical hello world application"
6. /skogai-builder:create-skill "hello-world-creator" "this skill will be how to create and setup hello world applications in different mediums with the goal of gathering all sorts of hello world starting setups possible on the users local setup"
7. /skogai-builder:create-md "quick"
8. /skogai-builder:create-plugin "."
9. add this to the skogai/.claude-plugin/marketplace.json:
```json
  {
    "name": "skogai-hello-world",
    "source": "./hello-world",
    "description": "A hello world-project created by skogai-builder for demonstration purposes"
  }
```
```
