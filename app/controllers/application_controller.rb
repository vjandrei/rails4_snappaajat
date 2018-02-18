class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) << :terms_and_conditions
  end
  
  before_action :prepare_meta_tags, if: "request.get?"

  def prepare_meta_tags(options={})

    site        = "Snappaajat.fi"
    title       = "Kaikki suomen snapchattaajat yhdestä paikasta"
    description = "Snappaajat.fi:n avulla löydät vaivattomasti Suomen Snapchattaajat ja voit myös lisätä oman tunnuksesi sivustolle."
    image       = "http://www.snappaajat.fi/images/snappaajat-facebook.jpg"
    current_url = request.url

    # Let's prepare a nice set of defaults

    defaults = {
      site:        site,
      title:       title,
      image:       image,
      description: description,
      keywords:    %w[some snapchat snappaajat sosiaalinenmedia],
      twitter:     {site: site,
                    site: '@snappaajat',
                    card: 'summary',
                    description: description,
                    image: image},
      og:          {url: current_url,
                    site: site,
                    title: title,
                    image: image,
                    description: description,
                    type: 'website'}
    }

    options.reverse_merge!(defaults)

    set_meta_tags options

  end
  
end


