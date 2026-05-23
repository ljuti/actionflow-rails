# Actionflow::Rails

Rails integration for the [Actionflow](https://github.com/ljuti/actionflow) workflow gem.

## Installation

Add to your Gemfile:

```ruby
gem "actionflow-rails"
```

The gem depends on `actionflow` and `railties` — both are pulled in automatically.

## What it provides

### Railtie

Automatically wires `Workflow.configuration.logger` to `Rails.logger` on boot:

```ruby
# In config/application.rb — just having the gem installed is enough.
# No manual configuration needed.
```

### Generators

Generate a workflow action:

```bash
bin/rails generate workflow:action charge_card user amount --promises charge
# => app/actions/charge_card_action.rb
```

Generate an organizer:

```bash
bin/rails generate workflow:organizer checkout validate_cart charge_card send_receipt
# => app/actions/checkout_organizer.rb
```

Generated files follow the conventions from AGENTS.md — actions include
`Workflow::Action` with `expects`/`promises`, organizers include
`Workflow::Organizer` with constructor-injected step composition.

## License

MIT
