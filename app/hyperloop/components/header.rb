require 'opal-jquery'

class Header < Hyperloop::Component
  include Browser

  param :ticket_count, type: Integer
  param :open_ticket_count, type: Integer

  before_mount do
    mutate.user_name_input ''
  end

  def render
    # div.navbar.navbar_inverse.navbar_fixed_top do
    #   div.container do
    #     div.navbar_collapse(id: 'navbar') do     # removed .collapse
    #       show_greeting
    #     end
    #   end
    # end
    show_greeting
  end

  def show_input_box
    form.navbar_form.navbar_left.form_inline(role: :search) do
      P { "hello" }
    end
  end

  def show_greeting
    div.container do
      div.row do
        div.col.middle { "Hello #{User.current.email}" }
        div.col.middle { "There are #{params.open_ticket_count} open issues of #{params.ticket_count} total" }
        div.col.middle.text_right do
          button.btn.btn_default.btn_outline_success(type: :button, href: '#') { "logout" }.on(:click) do
            HTTP.delete("/users/sign_out").then do
              alert "logged out"
              TicketStore.mutate.user_name ''
              mutate.user_name_input ''
              `window.location.href = '/'`
            end
          end
        end
      end
    end
  end

  def valid_new_input?
    state.user_name_input.present?
  end
end
