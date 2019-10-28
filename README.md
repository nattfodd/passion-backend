# README

The project basically consists of 3 models and 3 controllers - Verticals, Categories & Courses.

### Setup

Add these ENVs in order to configure the DB connection:

```sh
DATABASE_USERNAME=yourusername
DATABASE_PASSWORD=yourpassword
DATABASE_HOST=127.0.0.1
DATABASE_PORT=5432
```

Then run migrations, seed and start the server:

```sh
rails db:create db:migrate db:seed
rails s
```

### Uniqueness constrain validation

The first two have a common uniqueness constrain by name, that has been achieved by code adding a dedicated class that wraps model creation in a transaction with exclusive lock. This approach was chosen as a versatile one, assuming the Vertical and Category models should live in different tables.

Another approach I considered was to create a STI, with a default uniqueness constraint offered by the DB. This sounds reasonable to me, as now Vertical and Category look more of a "parent-child" thingies rather than completely different entities. But due to lack of information I have chosen a more versatile path with exclusive lock. Exclusive lock adds an extra complexity, as we make validation on the backend side instead of DB, but it doesn't restrict further development if the requirements will change or additional info will be given, unlike STI approach.

Doing the same thing by pure Rails-way validation (i.e. custom model validation) is pointless as it makes it possible to insert a few records with the same name due to race condition issues.

### Questions

#### How does your solution perform?

That's just 3 tables and 3 endpoints. There's nothing to say about performance. Due to exclusive lock on Vertical/Cagegory create, this already sounds like a bottleneck in case of many requests to create those. On the other hand, from business perspective these two models doesn't look like ones that are going to be created too often.

####  How does your solution scale?

Again, this is a very simple backend so it can easily scale both vertically (increasing disk space, cpu, etc) and horizontally - adding more nodes of the backend.

#### What would you improve next?

The task has been written in a pretty fast-paced manner, so there's a room for refactoring. I.e. there're many repetitive parts in controllers as they're basically all CRUD endpoints. Same goes for tests. But the need of making these parts DRY fully depends on the next steps. Sometimes it worth it to keep the "copy-pasta" keeping in mind that these controllers will be more different soon.

#### What was one of the biggest coding challenges that you ever had?

I architected & wrote a system from scratch. The codebase is now 1 year old, and 6 months in production. Now there're 2 more people working with the codebase, and luckily there were not so many approaches that have been picked wrong. Also the codebase is still easy to maintain, and it's quite easy for new developers to jump in as the code is written in a "kind of" DDD way so that it's easy to work on the isolated things and the scope is way less than the entire system. Also 95% tests coverage helps a bit.

#### Please show and explain why it was so difficult

The requiremens had been changing a lot during the first phase before going to production. It was a challenge to reflect new requirements in the code so that the code wouldn't become a mess.
