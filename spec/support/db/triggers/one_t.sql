create trigger one_t
after update on dummy
for each row execute procedure do_dummy();
