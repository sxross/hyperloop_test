
  class Tickettracker < Hyperloop::Component

    # param :my_param
    # param param_with_default: "default value"
    # param :param_with_default2, default: "default value" # alternative syntax
    # param :param_with_type, type: Hash
    # param :array_of_hashes, type: [Hash]
    # collect_other_params_as :attributes  # collects all other params into a hash

    # The following are the most common lifecycle call backs,
    # the following are the most common lifecycle call backs# delete any that you are not using.
    # call backs may also reference an instance method i.e. before_mount :my_method

    before_mount do
      # any initialization particularly of state variables goes here.
      # this will execute on server (prerendering) and client.
      # @tickettrackermodels = Ticket.by_priority.all  ### Uncomment for bug
      @tickettrackermodels = Ticket.by_priority

      TicketStore.mutate.priority 2
    end

    after_mount do
      # any client only post rendering initialization goes here.
      # i.e. start timers, HTTP requests, and low level jquery operations etc.
    end

    before_update do
      # called whenever a component will be re-rerendered
    end

    before_unmount do
      # cleanup any thing (i.e. timers) before component is destroyed
    end

    def render
      DIV do
        Header()
        div.container do
          DIV(class: 'Tickettracker') do
            "Ticket Tracker"
            input_box
            ticket_table
          end
        end
      end
    end

    def input_box
      DIV do
        INPUT(type: :text, value: TicketStore.title, class: 'form-control', placeholder: 'title').on(:change) do |ev|
          TicketStore.mutate.title ev.target.value
        end

        TEXTAREA(rows: 3, value: TicketStore.description, class: 'form-control', placeholder: 'description').on(:change) do |ev|
          TicketStore.mutate.description ev.target.value
        end

        SELECT(class: 'form-control', value: 2) do
          OPTION(value: 1) {"1 - High"}
          OPTION(value: 2) {"2 - Medium"}
          OPTION(value: 3) {"3 - Low"}
        end.on(:change) do |ev|
          TicketStore.mutate.priority ev.target.value
        end

        BUTTON(class: 'btn btn-warning') do
            "Add Ticket"
          end.on(:click) do |ev|
            Ticket.create(
              title: TicketStore.title,
              description: TicketStore.description,
              priority: TicketStore.priority) do |result|
                alert "unable to save" unless result == true
            TicketStore.mutate.title ''
            TicketStore.mutate.description ''
            TicketStore.mutate.priority 2
          end
        end
      end
      BR{}
    end

    def ticket_table
      DIV do
        BR{}
        TABLE(class: 'table table-hover table-condensed table-sm') do
          THEAD do
            TR do
              ["ID", "Pri", "Title/Description", "Created/Closed"].each do |title|
                TD { title }
              end
            end # TR
          end # THEAD
          TBODY do
            @tickettrackermodels.each do |ticket|
              table_row ticket
            end
          end
        end # TABLE
      end # DIV
    end

    def table_row(ticket)
      TR do
        TD { "%06d" % ticket.id }
        TD { ticket.priority.to_s }
        TD do
          B { ticket.title }
          BR {}
          P { ticket.description }
         end
        TD do
          P {
            "Open: #{ticket.created_at.class == String ? '---' : ticket.created_at.strftime("%Y-%m-%d")}"
          }
          P {
            "Close: #{ticket.closed_at.class == String ? '---' : ticket.closed_at.strftime("%Y-%m-%d")}"
          } unless ticket.closed_at.nil?
        end
      end
    end
  end
