% Airline Flight Database
% This program models airline flights between various airports in the United States.
% Author: Akash Yadav

% Facts: flight(FlightNumber, Origin, Destination, DepartureTime, ArrivalTime)
flight(6711, bos, ord, 0815, 1005).
flight(211, lga, ord, 0700, 0830).
flight(203, lga, lax, 0730, 1335).
flight(92221, ewr, ord, 0800, 0920).
flight(2134, ord, sfo, 0930, 1345).
flight(954, phx, dfw, 1655, 1800).
flight(1176, sfo, lax, 1430, 1545).
flight(205, lax, lga, 1630, 2210).
flight(7791, lga, ord, 0815, 0945).
flight(321, lax, lga, 1645, 2225).

% Rule: destinations_from(Origin, Destinations)
destinations_from(Origin, Destinations) :-
    findall(Dest, flight(_, Origin, Dest, _, _), Destinations).

% Rule: flight_to(Destination)
flight_to(Destination) :-
    flight(_, _, Destination, _, _).

% Rule: landing_time(Origin, Destination, FlightNumber, ArrivalTime)
landing_time(Origin, Destination, FlightNumber, ArrivalTime) :-
    flight(FlightNumber, Origin, Destination, _, ArrivalTime).

% Rule: departs_after_lands(Flight1Origin, Flight1Dest, Flight2Origin, Flight2Dest)
departs_after_lands(Flight1Origin, Flight1Dest, Flight2Origin, Flight2Dest) :-
    flight(_, Flight1Origin, Flight1Dest, _, ArrivalTime1),
    flight(_, Flight2Origin, Flight2Dest, DepartureTime2, _),
    DepartureTime2 > ArrivalTime1.

% Rule: arrival_times(Destination, Flights)
arrival_times(Destination, Flights) :-
    findall([FlightNumber, Origin, ArrivalTime], 
            flight(FlightNumber, Origin, Destination, _, ArrivalTime), 
            Flights).

% Rule: direct_flight(Origin, Destination, FlightNum, DepartureTime, ArrivalTime)
direct_flight(Origin, Destination, FlightNum, DepartureTime, ArrivalTime) :-
    flight(FlightNum, Origin, Destination, DepartureTime, ArrivalTime).

% Rule: connecting_flight(Origin, Destination, Flight1, Flight2, Connection)
connecting_flight(Origin, Destination, Flight1, Flight2, Connection) :-
    flight(Flight1, Origin, Connection, _, ArriveTime1),
    flight(Flight2, Connection, Destination, DepartTime2, _),
    Connection \= Origin,
    Connection \= Destination,
    DepartTime2 > ArriveTime1.

% Rule: two_stop_flight(Origin, Destination, Flight1, Flight2, Flight3, Stop1, Stop2)
two_stop_flight(Origin, Destination, Flight1, Flight2, Flight3, Stop1, Stop2) :-
    flight(Flight1, Origin, Stop1, _, ArriveTime1),
    flight(Flight2, Stop1, Stop2, DepartTime2, ArriveTime2),
    flight(Flight3, Stop2, Destination, DepartTime3, _),
    Stop1 \= Origin, Stop1 \= Destination, 
    Stop2 \= Origin, Stop2 \= Destination,
    Stop1 \= Stop2,
    DepartTime2 > ArriveTime1,
    DepartTime3 > ArriveTime2.

% Rule: all_routes(Origin, Destination, Routes)
all_routes(Origin, Destination, Routes) :-
    findall(direct(FlightNum), 
            direct_flight(Origin, Destination, FlightNum, _, _), 
            DirectRoutes),
    findall(one_stop(Flight1, Flight2, Connection),
            connecting_flight(Origin, Destination, Flight1, Flight2, Connection),
            OneStopRoutes),
    findall(two_stops(Flight1, Flight2, Flight3, Stop1, Stop2),
            two_stop_flight(Origin, Destination, Flight1, Flight2, Flight3, Stop1, Stop2),
            TwoStopRoutes),
    append(DirectRoutes, OneStopRoutes, TempRoutes),
    append(TempRoutes, TwoStopRoutes, Routes).

% Rule: route(Origin, Destination, Route)
route(Origin, Destination, Route) :-
    direct_flight(Origin, Destination, FlightNum, _, _),
    Route = [direct(FlightNum, Origin, Destination)].
    
route(Origin, Destination, Route) :-
    connecting_flight(Origin, Destination, Flight1, Flight2, Connection),
    Route = [connection(Flight1, Origin, Connection), connection(Flight2, Connection, Destination)].

route(Origin, Destination, Route) :-
    flight(Flight1, Origin, Stop1, _, Arrive1),
    flight(Flight2, Stop1, Stop2, Depart2, Arrive2),
    flight(Flight3, Stop2, Destination, Depart3, _),
    Stop1 \= Origin, Stop1 \= Destination, 
    Stop2 \= Origin, Stop2 \= Destination,
    Stop1 \= Stop2,
    Depart2 > Arrive1,
    Depart3 > Arrive2,
    Route = [connection(Flight1, Origin, Stop1), 
             connection(Flight2, Stop1, Stop2), 
             connection(Flight3, Stop2, Destination)].
