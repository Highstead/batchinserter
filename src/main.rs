extern crate clap;

use clap::{App, Arg};

fn main() {
    let matches = App::new("Batch inserter")
        .version("1.0")
        .author("Michael Highstead")
        .about("allows for the bulk inserting of data to a database in a less contentious way")
        .arg(
            Arg::with_name("host")
                .short("h")
                .long("host")
                .value_name("HOST")
                .help("Sets the database host")
                .takes_value(true),
        )
        .arg(
            Arg::with_name("port")
                .short("p")
                .long("port")
                .value_name("PORT")
                .help("Sets the database port")
                .takes_value(true),
        )
        .arg(
            Arg::with_name("username")
                .short("u")
                .long("username")
                .value_name("USERNAME")
                .help("Sets the database username")
                .takes_value(true),
        )
        .arg(
            Arg::with_name("password")
                .short("P")
                .long("password")
                .value_name("PASSWORD")
                .help("Sets the database password")
                .takes_value(true),
        )
        .get_matches();

    // Extract values from command-line arguments or use defaults
    let host = matches.value_of("host").unwrap_or("localhost");
    let port = matches.value_of("port").unwrap_or("5432");
    let username = matches.value_of("username").unwrap_or("user");
    let password = matches.value_of("password").unwrap_or("password");

    println!("Connecting to database:");
    println!("Host: {}", host);
    println!("Port: {}", port);
    println!("Username: {}", username);
    println!("Password: {}", password); //TODO never do this obviously...  We only do this because
                                        //i want this to compile
}
