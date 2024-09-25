Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.


Code Eldave: Shop: Show.html.erb
<!--<div class="header-show" style="background-image: url(<%= @shop.main_image.attached? ? cl_image_path(@shop.main_image.key,
                           crop: :fill,
                           dpr: 2.0,
                           quality: "auto:best",
                           gravity: :face,
                           fetch_format: :auto) : asset_path("IMG_4667.webp") %>);height: 80vh">
  <div class="title-show">
    <h1><%= @shop.name %></h1>
    <p class="mt-3 text-center"><i class="fi fi-rs-marker icon-header"></i></p>
  </div>

</div>


<div style=' margin-top: calc(-45px - 5vw);'>
  <div class="custom-shape">
    <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 915.4 120" preserveAspectRatio="none">
        <path class="cls-2" d="M915.4,119V46.8c-164.7,68.9-279.3,59.8-354.4,37.8C460.2,55,426.4.9,326.5,7.3c-62.5,4-93.4,20.5-211.2,46.9C60.9,66.4,33.2,86.9,0,66.5v52.5h915.4Z"/>
        <path class="cls-3" d="M489.1,46.3c-90.6,0-206.6,25.6-247.6,33.4C184.7,90.5,103.2,101,0,97.5v21.4h915.4v-51.5c-42.8,7.2-107.5,19.2-190.6,15.1-134.7-6.6-122.8-36.4-235.7-36.3Z"/>
        <path class="cls-1" d="M0,4.6v115.4s915.4,0,915.4,0c0-24.4,0,8.2,0-16.2-101,22.7-217.2,17.4-408.2-30.6S142.9,0,0,4.6Z"/>
    </svg>
  </div>

  <div class="pb-5" style="background-color: #fff;">
    <div class="container">
      <div class="content-show">
        <span><%= @shop.class.name %></span>
        <div class="d-lg-flex align-items-end justify-content-between">
          <h1><%= @shop.name %></h1>
          <p><i class="fi fi-rs-marker" style="color: #CFED58"></i> <%= @shop.location.name %></p>
        </div>
        <%# <i class="fi fi-rs-star"></i> <%= @shop.average_rating %>

        <div class="d-flex justify-content-center">
          <div class="text-center mx-3">
            <a href="tel:<%= @shop.phone %>" class="btn btn-outline-primary d-flex flex-column align-items-center" title="Call">
              <i class="fi fi-rs-phone-flip fa-flip-horizontal" style="width: 54px; height: 54px; font-size: 54px;"></i>
            </a>
          </div>
          <div class="text-center mx-3">
            <a href="mailto:<%= @shop.email %>" class="btn btn-outline-primary d-flex flex-column align-items-center" title="Email">
              <i class="fi fi-rs-comment" style="width: 54px; height: 54px; font-size: 54px;"></i>
            </a>
          </div>
          <div class="text-center mx-4">
            <%= link_to do %>
              <i class="fi fi-rs-road-sign-left text-primary" style="width: 60px; height: 60px; font-size: 60px;"></i>
            <% end %>
            <%= link_to "https://www.google.com/maps/search/?api=1&query=#{CGI.escape(@shop.address || 'Le Morne kite lagoon, mauritius')}", target: '_blank' do %>
            <% end %>
          </div>
        </div>

        <h2 class="fs-4 mt-3">Description</h2>
        <p><%= @shop.description %></p>

      </div>
    </div>


    <div data-controller="images-show" data-images-show-target="imageContainer" class="images-show">
      <% count = 0 %>
      <% @shop.images.each do |image| %>
        <%= cl_image_tag(image.key,
                    crop: :fill,
                    quality: "auto:best",
                    fetch_format: :auto,
                    data: (count == 1 ? { images_show_target: "secondImage" } : {})) %>
        <% count += 1 %>

      <% end %>
    </div>

    <div class="container">
      <div class="content-show">
        <!-- Button trigger modal -->
        <div class="d-flex justify-content-end align-items-center mt-3" data-bs-toggle="modal" data-bs-target="#exampleModal">
          <%= link_to 'javascript:void(0);', class: "link link-underline" do %>
            <div class="d-flex justify-content-end align-items-center">
              <p class="mb-0">Add a picture</p>
              <p class="mb-0 mt-2">
                <i class="fi fi-rs-add text-primary ms-2 fs-4"></i>
              </p>
            </div>
          <% end %>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered modal-md">
            <div class="modal-content">
              <div class="modal-header">
                <h3 class="modal-title fs-5" id="exampleModalLabel">Add your best picture for <%= @shop.name %></h3>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>

              <div class="modal-body">
                <div class="modal-content py-4 px-5" style= "border: none;">

                  <%= simple_form_for @shop, html: { multipart: true } do |f| %>
                    <div class="d-flex justify-content-center">
                      <%= f.file_field :images, multiple: true, direct_upload: true, class: "form-control" %>
                      <%= f.submit "Upload", class: "btn btn-primary", style: "border-radius: 0px;" %>
                    </div>
                  <% end %>

                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

<%# Reviews %>

<div class="container">
  <div class="content-show">

  <!-- Button to trigger modal -->

    <div data-bs-toggle="modal" data-bs-target="#reviewModal">
      <p class="mt-5 mb-3">
        <%= link_to 'Add a review', 'javascript:void(0);', class: 'link link-underline' %>
      </p>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-md">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="reviewModalLabel">New Review</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <%= form_with model: [@shop, @review_shop], url: shop_review_shops_path(@shop), method: :post, local: true do |f| %>
              <div class="mb-3">
                <div class="form-group"> <%= f.label :rating, "Rate (1 to 5)" %> <%= f.select :rating, options_for_select([1, 2, 3, 4, 5]), {}, class: "form-control" %> </div>
              </div>
              <div class="mb-3">
                <%= f.label :description, class: 'form-label' %>
                <%= f.text_area :description, class: 'form-control', rows: 3, required: true %>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary text-light" data-bs-dismiss="modal">Close</button>
                <%= f.submit 'Submit Review', class: 'btn btn-primary' %>
              </div>
            <% end %>
          </div>
        </div>
      </div>
    </div>

    </div>


  </div>
</div>
