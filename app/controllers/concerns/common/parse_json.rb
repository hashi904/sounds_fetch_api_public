module Common
  module ParseJson
    extend ActiveSupport::Concern

    # 引数はSymbolで渡す
    def parse_json_to_hash(key = nil)
      return if key == nil || key.class != Symbol

      params[key] = JSON.parse(params[key], symbolize_names: true)
      params[key]
    end
  end
end
