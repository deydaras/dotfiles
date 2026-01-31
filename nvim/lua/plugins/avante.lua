return {
  "yetone/avante.nvim",                        -- 1: plugin repo
  event   = "VeryLazy",                        -- 2: defer load until VeryLazy
  version = false,                             -- 3: no version pinning
  opts    = {                                  -- 4: start opts table
    provider  = "ollama",                      -- 5: set default provider
    providers = {                              -- 6: begin providers table
      ollama = {                               -- 7: ollama-specific config
        endpoint    = "http://localhost:11434",-- 8: Ollama server URL
        model       = "hf.co/unsloth/DeepSeek-R1-0528-Qwen3-8B-GGUF:Q8_K_XL", -- 9: default model
        temperature = 0.65,                    -- 10: sampling temp
        top_p       = 0.95,
        max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      --reasoning_effort = "medium"-- 11: nucleus sampling
      },                                        -- 12: end ollama

      -- 13: each vendor below inherits endpoint, temp, and top_p from ollama:
      ["unsloth-deepseek-qwen3:8b"] = {         -- 14: name must match selector key
        __inherited_from = "ollama",            -- 15: inherit from ollama
        model            = "hf.co/unsloth/DeepSeek-R1-0528-Qwen3-8B-GGUF:Q8_0", -- 16: override model ID
      },

      ["unsloth-deepseek-qwen3:16b"] = {        -- 17: 16-bit variant
        __inherited_from = "ollama",            -- 18: inherit from ollama
        model            = "hf.co/unsloth/DeepSeek-R1-0528-Qwen3-8B-GGUF:BF16", -- 19: override model ID
      },

      ["qwen3-0.6G"] = {                   -- 20: 32-bit base
        __inherited_from = "ollama",            -- 21: inherit from ollama
        model            = "hf.co/Qwen/Qwen3-Embedding-0.6B-GGUF:Q8_0",   -- 22: local model alias
      },
      ["unsloth-qwen-deep-4.7G"] = {                   -- 20: 32-bit base
        __inherited_from = "ollama",            -- 21: inherit from ollama
        model            = "hf.co/unsloth/DeepSeek-R1-0528-Qwen3-8B-GGUF:Q4_0",   -- 22: local model alias
      },
       ["deepseek-r1:32b"] = {                   -- 20: 32-bit base
        __inherited_from = "ollama",            -- 21: inherit from ollama
        model            = "deepseek-r1:32b",   -- 22: local model alias
      },
      ["gemma3"] = {                            -- 23: gemma3 variant
        __inherited_from = "ollama",            -- 24: inherit from ollama
        model            = "gemma3:27b-it-qat", -- 25: override model ID
      },

      ["deepseek-qwen3"] = {                    -- 26: distilled Qwen-3
        __inherited_from = "ollama",            -- 27: inherit from ollama
        model            = "deepseek-r1:32b-qwen-distill-q4_K_M", -- 28: override model ID
      },
    },                                          -- 29: end providers
  },                                            -- 30: end opts
  build = "make",                              -- 31: build from source
  dependencies = {                             -- 32: plugin dependencies
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "echasnovski/mini.pick",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
    "stevearc/dressing.nvim",
    "folke/snacks.nvim",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false, -- avoid bloating your config
          prompt_for_file_name  = false, -- skip filename prompt
          drag_and_drop = { insert_mode = true }, -- allow drag/drop
          use_absolute_path = true,  -- Windows requirement
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft   = { "markdown", "Avante" }, -- autoload for .md & Avante files
      opts = { file_types = { "markdown", "Avante" } },
    },
  },
}
