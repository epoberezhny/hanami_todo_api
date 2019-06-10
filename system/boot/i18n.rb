Container.boot(:i18n) do
  init do
    I18n.load_path += Dir[Hanami.root.join('config', 'locales', '**', '*.{rb,yml}')]
  end
end
