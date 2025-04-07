# Airline-Flight-Database - Prolog Logic Programming
![Prolog](https://img.shields.io/badge/Prolog-Logic%20Progrimg.shields.io/badge/Statle of Contents

Overview

Features

Technologies Used

Installation

Usage Examples

Database Structure

Project Structure

Contributing

License

🌐 Overview
This project implements a Prolog-based system for querying airline flight information between various airports in the United States. The program demonstrates the power of logical programming for solving complex routing and scheduling problems in the travel domain.

✨ Features
Flight Database: Comprehensive information about flights between major US airports

Query Capabilities: Find direct flights, connections, and multi-stop routes

Schedule Analysis: Determine timing relationships between different flights

Route Finding: Discover all possible ways to travel between airports

Logical Rules: Demonstrate the power of declarative programming for travel planning

🛠️ Technologies Used
SWI-Prolog (version 8.0 or higher)

Logic Programming paradigm

📥 Installation
Install SWI-Prolog from https://www.swi-prolog.org/download/stable

Clone this repository:

bash
git clone https://github.com/yourusername/airline-flight-database.git
Navigate to the project directory:

bash
cd airline-flight-database
Load the program in SWI-Prolog:

bash
swipl -s flight_database.pl
Or from within SWI-Prolog:

prolog
?- [flight_database].
🚀 Usage Examples
Finding Destinations from an Airport
prolog
?- destinations_from(phx, Destinations).
Destinations = [dfw].
Checking if a Flight Exists to a Destination
prolog
?- flight_to(phx).
false.
Finding Flight Landing Times
prolog
?- landing_time(bos, ord, FlightNumber, ArrivalTime).
FlightNumber = 6711,
ArrivalTime = 1005.
Checking Flight Timing Relationships
prolog
?- departs_after_lands(ewr, ord, ord, sfo).
true.
Finding All Arrival Times to a Destination
prolog
?- arrival_times(ord, Flights).
Flights = [[6711, bos, 1005], [211, lga, 0830], [92221, ewr, 0920], [7791, lga, 0945]].
Finding All Routes Between Airports
prolog
?- findall(Route, route(lga, lax, Route), AllRoutes).
AllRoutes = [[direct(203, lga, lax)]].
💾 Database Structure
The flight database is structured as facts in the format:

prolog
flight(FlightNumber, Origin, Destination, DepartureTime, ArrivalTime)
Example:

prolog
flight(6711, bos, ord, 0815, 1005).  % Boston to Chicago
flight(211, lga, ord, 0700, 0830).   % New York LaGuardia to Chicago
flight(203, lga, lax, 0730, 1335).   % New York LaGuardia to Los Angeles
Airport codes used:

BOS: Boston

LGA: New York LaGuardia

EWR: Newark

ORD: Chicago O'Hare

SFO: San Francisco

LAX: Los Angeles

PHX: Phoenix

DFW: Dallas/Fort Worth

📁 Project Structure
flight_database.pl: Main Prolog file containing facts and rules

README.md: Project documentation

📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

Created with ❤️ using Prolog | April 2025
