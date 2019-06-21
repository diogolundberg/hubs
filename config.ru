# frozen_string_literal: true

require_relative './config/boot'

run(Environment.development? ? Unreloader : Application.freeze.app)
