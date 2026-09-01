# RaceDay – Event Management System - ST10232490

## PROG212 Portfolio of Evidence (POE)

RaceDay is a full-stack web-based event management system designed for the South African road running, walking, and cycling community. The system allows Organisers to manage events, categories, participants, and results, while Participants can browse events, enter events, and track their results.

The project is developed progressively across three parts, with each part building on the previous work.

## User Roles

### Organiser

Organisers can create, edit, and delete events, manage event categories, view event enrolments, capture participant results, and view participant results.

### Participant

Participants can create an account, browse events, enter events by selecting a category, view their enrolments, and track their personal results.

## Admin 

Oversees all race day operations, from scheduling and participant management to live tracking and results. Coordinates with officials, volunteers, and vendors to ensure a smooth, safe, and engaging event. Manages registrations, timing systems, and post-race reports while resolving issues quickly to keep the race running flawlessly.

Role-based access is enforced at the API level in Part 2 and reflected consistently in the MVC application in Part 3.

## Project Parts

### Part 1 – System Planning

* Entity Relationship Diagram (ERD)
* Complete API endpoint plan
* SQL database creation script
* Database design supporting Organiser and Participant roles
* No API code is written in Part 1

### Part 2 – RESTful API

* C# RESTful API
* SQL database connectivity
* Required CRUD functionality
* Authentication and role-based authorisation
* Unit tests
* GitHub Actions CI/CD workflow
* Successful green CI/CD build

### Part 3 – MVC Web Application

* ASP.NET Core MVC application
* REST API integration
* Organiser interface
* Participant interface
* Role-based access
* Azure Blob Storage integration
* Docker containerisation

## Technologies

* C#
* ASP.NET Core RESTful API
* ASP.NET Core MVC
* SQL Server
* Entity Framework Core
* Git
* GitHub
* GitHub Actions
* Azure Blob Storage
* Docker
* HTML5
* CSS3
* JavaScript

## Setup Instructions

### Database

1. Install SQL Server and SQL Server Management Studio.
2. Open the SQL database script from Part 1.
3. Execute the script to create the RaceDay database and tables.
4. Confirm that the database was created successfully.
5. Configure the API connection string.

Example:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost;Database=RaceDayDB;Trusted_Connection=True;TrustServerCertificate=True;"
  }
}
```

### API

```bash
dotnet restore
dotnet build
dotnet test
dotnet run
```

Confirm that the API can connect to the database before starting the MVC application.

### MVC Application

1. Start the API.
2. Configure the MVC application with the API base URL.
3. Configure authentication settings.
4. Configure Azure Blob Storage where required.
5. Build and run the MVC application.
6. Test both Organiser and Participant functionality.

### Azure Blob Storage

Configure the required Azure Storage settings using local configuration, user secrets, environment variables, or GitHub Secrets.

```json
{
  "AzureBlobStorage": {
    "ConnectionString": "YOUR_AZURE_STORAGE_CONNECTION_STRING",
    "ContainerName": "YOUR_CONTAINER_NAME"
  }
}
```

Real credentials and connection strings must not be committed to GitHub.

### Docker

Build the application:

```bash
docker build -t raceday .
```

Run the container:

```bash
docker run -p 8080:8080 raceday
```

## GitHub Actions CI/CD

The workflow is stored in:

```text
.github/workflows/
```

The workflow must restore, build, and test the application successfully.

The final GitHub repository must show a green check mark for the CI/CD workflow before submission.

## GitHub Version Control

A minimum of 20 meaningful commits is required for each part.

Meaningful commits should represent actual development progress.

Examples:

```text
Create event database tables
Add participant registration endpoint
Implement organiser authorisation
Add event category service
Create event enrolment tests
Add GitHub Actions workflow
Implement MVC event listing
Add Azure Blob image upload
Add Docker configuration
```

Commits such as `fixed typo` or `updated file` without a meaningful project change should not be relied upon to meet the requirement.

## Video Presentation

A video presentation is required for each part.

Each video must demonstrate the running application or relevant work and explain the code structure, logic, and design decisions.

AI-generated voices are not permitted.

Videos must be uploaded to YouTube as unlisted videos.

### Part 1

YouTube: `ADD_PART_1_UNLISTED_YOUTUBE_LINK_HERE`

### Part 2

YouTube: `ADD_PART_2_UNLISTED_YOUTUBE_LINK_HERE`

### Part 3

YouTube: `ADD_PART_3_UNLISTED_YOUTUBE_LINK_HERE`

## CI/CD Green Build

Add a screenshot showing the successful GitHub Actions green build.

```markdown
![Successful CI/CD Green Build](docs/images/ci-cd-green-build.png)
```

## Testing

Run the unit tests using:

```bash
dotnet test
```

Tests should cover important API functionality, validation, and role-based access.

## Project Structure

```text
RaceDay/
│
├── Part1/
│   └── docs
│         ├── ERD/
│         ├── API-Plan/
│         └── Database/
│
├── Part2/
│   ├── RaceDay.API/
│   ├── RaceDay.Tests/
│   └── .github/
│       └── workflows/
│
├── Part3/
│   ├── RaceDay.MVC/
│   └── Docker/
│
├── README.md
└── ...
```


## Project Status

| Part   | Description                                               | Status      |
| ------ | --------------------------------------------------------- | ----------- |
| Part 1 | ERD, API endpoint plan and SQL database                   | In Progress |
| Part 2 | C# RESTful API, database connection, unit tests and CI/CD | Pending     |
| Part 3 | MVC application, Azure Blob Storage and Docker            | Pending     |

## Author

**Student:** Lungelwa S'phesihle Mazibuko

**Student Number:**  ST10232490

**Module:** PROG6212

**Project:** RaceDay Event Management System
::: 
