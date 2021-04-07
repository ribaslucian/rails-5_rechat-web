Rails.application.config.session_store  :cookie_store,
                                        :key => "rechat_session",
                                        expire_after: 365.days
