
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
      @tickettrackermodels = Ticket.all
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
      DIV(class: 'Tickettracker') do
        "Ticket Tracker"
        input_box
        ticket_table
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

        SELECT(value: 1, class: 'form-control') do
          OPTION(value: 1) {"1 - Low"}
          OPTION(value: 2) {"2 - Medium"}
          OPTION(value: 3) {"3 - High"}
        end


        BUTTON(class: 'btn btn-warning') do
            "Add Ticket"
          end.on(:click) do |ev|
            Ticket.create(title: TicketStore.title, description: TicketStore.description) do |result|
              alert "unable to save" unless result == true
            TicketStore.mutate.title ''
            TicketStore.mutate.description ''
          end
        end
      end
      BR{}
    end

    def ticket_table
      DIV do
        BR{}
        TABLE(class: 'table table-hover table-condensed') do
          THEAD do
            TR do
              TD { "ID" }
              TD { "Title" }
              TD { "Description" }
              TD { "Created" }
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
        TD { ticket.title }
        TD { ticket.description }
        TD { ticket.created_at.class == String ? '---' : ticket.created_at.strftime("%Y-%m-%d") }
      end
    end
  end
