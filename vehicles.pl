% part1
%inventory
vehicle(toyota, txl, suv, 50000, 2020).
vehicle(toyota, corolla_cross, suv, 25000, 2016).
vehicle(ford, raptor, pickup, 35000, 2015).
vehicle(ford, mustang, sport, 45000, 2020).
vehicle(bmw, x5, suv, 60000, 2020).
vehicle(bmw, z4, sport, 70000, 2021).
vehicle(kia, picanto, sedan, 12000, 2022).
vehicle(honda, civic, sedan, 6000, 2000).
vehicle(suzuki, swift, suv, 16000, 2021).
vehicle(nissan, skyline, sport, 100000, 2022).
vehicle(mazda, cx30, suv, 45000, 2024).

% part2
%filter by type and budget
meet_budget(Reference, BudgetMax) :-
    vehicle(_, Reference, _, Price, _),
    Price =< BudgetMax.
%vehicles by brand
vehicles_by_brand(Brand, Refs) :-
    findall(Ref, vehicle(Brand, Ref, _, _, _), Refs).

%part3
%report generation
generate_report(Brand, Type, Budget, Result) :-
    findall((Reference, Price),
            (vehicle(Brand, Reference, Type, Price, _),
             Price =< Budget),
            FilteredVehicles),
    total_value(FilteredVehicles, Total),
    Total =< 1000000,  
    Result = report{vehicles: FilteredVehicles, total_value: Total}.


total_value([], 0).
total_value([(_, Price)|T], Total) :-
    total_value(T, SubTotal),
    Total is Price + SubTotal.

%part4

test_case1(Result) :-
    findall(Ref, (vehicle(toyota, Ref, suv, Price, _), Price < 30000), Result).

test_case2(Grouped) :-
    bagof((Type, Year, Ref), vehicle(ford, Ref, Type, _, Year), Grouped).

test_case3(Result) :-
    findall((Ref, Price), (vehicle(_, Ref, sedan, Price, _), Price =< 500000), V),
    total_value(V, Total),
    Total =< 500000,
    Result = report{vehicles: V, total_value: Total}.