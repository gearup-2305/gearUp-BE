# GearUP - Project README
# Back-End

Link to [GearUP Website]()
Link to [Front-End Repo]()

### Table of Contents
1. [Setup](#setup)
2. [Project Description](#project-description)
3. [Usage](#usage)
4. [Database Schema](#database-schema)
5. [GraphQL Endpoint](#graphql-endpoint)
6. [Future Iterations](#future-iterations)
7. [Suggestions for Contribution](#suggestions-for-contribution)
8. [Contributors](#contributors)

### Setup
- Ruby 3.2.2
- Rails 7.0.7.2
- GraphQL
- SimpleCov gem for code coverage tracking
- ShouldaMatchers gem for testing assertions
- VCR / Webmock to stub HTTP requests in tests to simulate API interactions

### Project Description
GearUP is a crowd funding app for artists to request supplies they need.  It is a full stack application that utilizes GraphQL and Amazon S3 bucket to store files uploaded by the artist.  There is an option to create an account to add a new post, or donors can search and select a project to donate to without having to create an account.

### Usage
The backend app exposes a GraphQL API endpoint with data for performing queries and mutations for artists, donors, and their posts.  

### Database Schema
![](2023-10-16-08-29-22.png)

### GraphQL Endpoint

1. `POST /graphql`

Queries:
```
query artists {
    artists {
        city
        createdAt
        email
        id
        medium
        name
        passwordDigest
        profileImage
        state
        updatedAt
        zipcode
      posts {
        id
        title
        details
        imageUrl
        requestedAmount
        currentAmount
        artistId
        donations {
          id
          name
          email
          amount
          postId
        }
      }
    }
}
```

Mutations:
```
mutation {
  createPost(input:{
    title: "Example title",
    details: "Example details",
    imageUrl: "http://wiegand.test/jaye_reinger",
    requestedAmount: Float,
    currentAmount: Float,
    artistId: 1
  }) {
    post {
      id
      title
      details
      imageUrl
      requestedAmount
      currentAmount
    }
    errors
  }
}
```
### Future Iterations
1. Add funcionality for payment processing using services such as PayPal, Venmo, Square, and/or Apple Pay
2. Utilize OAuth to create and login to account

### Suggestions for Contribution
If you would like to contribute to this project, please follow these steps:
1. Fork the repository
2. Create a new branch for your feature, e.g., `git checkout -b <your-feature>`
3. Commit your changes: `git commit -m "Add new feature`
4. Push the branch to your fork: `git push origin your-feature`
5. Create a pull request outlining your changes.

### Contributors 
- Allen Russell -GitHub: @garussell
- Anna Wiley -GitHub: @awiley33
- Andi Lovetto -GitHub: @andilovetto
- Matt Lim -GitHub: @MatthewTLim
