# frozen_string_literal: true

# Transction Model Template
class Transaction < ApplicationRecord
  belongs_to :account
end
