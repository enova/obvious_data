create trigger two_t
after delete on dummy
for each row execute procedure do_dummy();
