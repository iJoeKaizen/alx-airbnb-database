Identified Performance Issues:
1. Full Table Scans:
Sequential scans on large tables due to missing indexes
No index utilization for sorting (ORDER BY)

2. Inefficient Joins:
Nested loops causing O(n²) complexity
All payments joined even when not needed

3. Memory Intensive:
Large result set (all historical bookings)
Heavy sorting operation in memory

4. Redundant Data:
Retrieving all columns including unused ones
No filtering of results
