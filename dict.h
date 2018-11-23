typedef struct dict_f *Dict_f;

/* create a new empty dictionary */
Dict_f DictCreate(void);

/* destroy a dictionary */
void DictDestroy(Dict_f);

/* insert a new key-value pair into an existing dictionary */
void DictInsert(Dict_f, const char *key, float value);

/* return the most recently inserted value associated with a key */
/* or 0 if no matching key is present */
float DictSearch(Dict_f, const char *key);

float DictAlter(Dict_f, const char *key, float new_val);

/* delete the most recently inserted record with the given key */
/* if there is no such record, has no effect */
void DictDelete(Dict_f, const char *key);