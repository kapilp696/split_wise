# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# split_wise



    <h3>Add Users</h3>
    <%= form.fields_for :group_membership do |f| %>
      <% @users.each do |user| %>
        <div class="field form-outline mb-4 text-light">
          <%= check_box_tag "user_ids[]", user.id, @users %>
          <%= label_tag user.email %>
        </div>
      <% end %>
    <% end %>


            <div class="nested-fields">
          <div class="field">
            <%= user_builder.label :user_id, 'Select User: ' %>
            <%= user_builder.collection_select :user_id, @users, :id, :email, { include_blank: true} %>
          </div>
        </div>