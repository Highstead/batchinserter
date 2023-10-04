use sqlx::PgPool;
use sqlx::Result;

pub struct Database {
    pool: PgPool,
}

impl Database {
    pub fn new(pool: PgPool) -> Self {
        Database { pool }
    }

    //TODO: Change this to something more abstract
    pub async fn get_user_by_id(&self, user_id: i32) -> Result<User> {
        let user = sqlx::query_as::<_, User>("SELECT id, username, email FROM users WHERE id = $1")
            .bind(user_id)
            .fetch_one(&self.pool)
            .await?;

        Ok(user)
    }
}
