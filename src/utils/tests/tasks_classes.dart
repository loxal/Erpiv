class Task {
                    /** Completion date of the task (as a RFC 3339 timestamp). This field is omitted if the task has not been completed. */
                    String completed;
                                    /** Flag indicating whether the task has been deleted. The default if False. */
                    bool deleted;
                                    /** Due date of the task (as a RFC 3339 timestamp). Optional. */
                    String due;
                                    /** ETag of the resource. */
                    String etag;
                                    /** Flag indicating whether the task is hidden. This is the case if the task had been marked completed when the task list was last cleared. The default is False. This field is read-only. */
                    bool hidden;
                                    /** Task identifier. */
                    String id;
                                    /** Type of the resource. This is always "tasks#task". */
                    String kind;
                // ARRAY
                    /** The description. In HTML speak: Everything between <a> and </a>. */
                    String description;
                                    /** The URL. */
                    String link;
                                    /** Type of the link, e.g. "email". */
                    String type;
                                    /** Notes describing the task. Optional. */
                    String notes;
                                    /** Parent task identifier. This field is omitted if it is a top-level task. This field is read-only. Use the "move" method to move the task under a different parent or to the top level. */
                    String parent;
                                    /** String indicating the position of the task among its sibling tasks under the same parent task or at the top level. If this string is greater than another task's corresponding position string according to lexicographical ordering, the task is positioned after the other task under the same parent task (or at the top level). This field is read-only. Use the "move" method to move the task to another position. */
                    String position;
                                    /** URL pointing to this task. Used to retrieve, update, or delete this task. */
                    String selfLink;
                                    /** Status of the task. This is either "needsAction" or "completed". */
                    String status;
                                    /** Title of the task. */
                    String title;
                                    /** Last modification time of the task (as a RFC 3339 timestamp). */
                    String updated;
                }

class TaskList {
                    /** ETag of the resource. */
                    String etag;
                                    /** Task list identifier. */
                    String id;
                                    /** Type of the resource. This is always "tasks#taskList". */
                    String kind;
                                    /** URL pointing to this task list. Used to retrieve, update, or delete this task list. */
                    String selfLink;
                                    /** Title of the task list. */
                    String title;
                                    /** Last modification time of the task list (as a RFC 3339 timestamp). */
                    String updated;
                }

class TaskLists {
                    /** ETag of the resource. */
                    String etag;
                // ARRAY
TaskList object;                    /** Type of the resource. This is always "tasks#taskLists". */
                    String kind;
                                    /** Token that can be used to request the next page of this result. */
                    String nextPageToken;
                }

class Tasks {
                    /** ETag of the resource. */
                    String etag;
                // ARRAY
Task object;                    /** Type of the resource. This is always "tasks#tasks". */
                    String kind;
                                    /** Token used to access the next page of this result. */
                    String nextPageToken;
                }

