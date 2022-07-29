       IDENTIFICATION DIVISION.
       PROGRAM-ID. Color-Bot.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 client USAGE POINTER.
       01 mycolor USAGE PROGRAM-POINTER.
       PROCEDURE DIVISION.
           SET mycolor TO ENTRY "mycolor".
           CALL STATIC "discord_config_init"
               USING "config.json"&x"00"
               RETURNING client.
           CALL STATIC "discord_set_on_command" USING
               BY VALUE client
               BY REFERENCE "mycolor"&x"00"
               BY VALUE mycolor.
           CALL STATIC "discord_run" USING BY VALUE client.
           CALL STATIC "discord_cleanup" USING BY VALUE client.
           CALL STATIC "ccord_global_cleanup".
           STOP RUN.
