require 'opal-jquery'

class Header < Hyperloop::Component
  include Browser

  before_mount do
    mutate.user_name_input ''
  end

  def render
    # div.navbar.navbar_expand_lg.navbar_light.bg_light do
    #   a.navbar_brand(href: "#") { "Navbar" }
    #   button.navbar_toggler(type: "button", "data-toggle" => "collapse", "data-target" => "#navbarSupportedContent", "aria-controls" => "navbarSupportedContent", "aria-expanded" => "false",  "aria-label" => "Toggle navigation") do
    #     span.navbar_toggler_icon
    #   end
    #
    #   div.collapse.navbar_collapse(id: "navbarSupportedContent") do
    #     ul.navbar_nav.mr_auto do
    #       li.nav_item.active do
    #         a.nav_link(href: "#") do
    #           "Home"
    #           span.sr_only{"(current)"}
    #          end
    #       end
    #       li.nav_item do
    #         a.nav_link(href: "#") { "Link" }
    #       end
    #       li.nav_item.dropdown do
    #         a.nav_link.dropdown_toggle(href: "#", id: "navbarDropdown", role: "button", "data-toggle" => "dropdown", "aria-haspopup" => "true", "aria-expanded" => "false") do
    #           "Dropdown"
    #         end
    #         div.dropdown_menu({"aria-labelledby" => "navbarDropdown"}) do
    #           a.dropdown_item(href: "#") { "Action" }
    #           a.dropdown_item(href: "#") { "Another action" }
    #           div.dropdown_divider
    #           a.dropdown_item(href: "#") { "Something else here" }
    #         end
    #       end
    #       li.nav_item do
    #         a.nav_link.disabled(href="#") { "Disabled" }
    #       end
    #     end
    #     form.form_inline.my_2.my_lg_0 do
    #       input.form_control.mr_sm_2(type: "search", placeholder: "Search", "aria-label" => "Search")
    #       button.btn.btn_outline_success.my_2.my_sm_0(type: "submit") { "Search" }
    #     end
    #   end
    # end
    div.navbar.navbar_inverse.navbar_fixed_top do
      div.container do
        div.navbar_collapse(id: 'navbar') do     # removed .collapse
          if TicketStore.user_name == ''
            show_input_box
          else
            show_greeting
          end
        end
      end
    end
  end

  def show_input_box
    form.navbar_form.navbar_left.form_inline(role: :search) do
      P { "hello" }
      # div.form_group do
      #   SPAN(class: "spacer") { "Log in: "}
      #   # ).on(:change) do |e|
      #   #   mutate.user_name_input e.target.value
      #   # end
      #   # button.btn.btn_default.btn_outline_success(type: :button) { "login!" }.on(:click) do
      #   #   TicketStore.mutate.user_name state.user_name_input
      #   # end if valid_new_input?
      # end
    end
  end

  def show_greeting
    DIV do
      SPAN(class: "spacer") { "Hello #{TicketStore.user_name}" }
      button.btn.btn_default.btn_outline_success(type: :button, href: '#') { "logout!" }.on(:click) do
        HTTP.delete("/users/sign_out").then do
          alert "logged out"
          TicketStore.mutate.user_name ''
          mutate.user_name_input ''
          `window.location.href = '/'`
          # window.location.href = "/"
        end
        end
    end
  end

  def valid_new_input?
    state.user_name_input.present?
  end
end
