       IDENTIFICATION DIVISION.
       PROGRAM-ID. cmds.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           CALL-CONVENTION 32 IS STDCALL
           CALL-CONVENTION 0 IS STANDARDC.
       REPOSITORY.
           FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 dev-urandom-fd USAGE BINARY-INT.
       01 discord-user BASED.
           05 dusr-id USAGE BINARY-DOUBLE UNSIGNED SYNC.
           05 dusr-username USAGE POINTER SYNC.
           05 dusr-discriminator USAGE POINTER SYNC.
           05 dusr-avatar USAGE POINTER SYNC.
           05 dusr-bot USAGE BINARY-CHAR UNSIGNED SYNC.
           05 dusr-System USAGE BINARY-CHAR UNSIGNED SYNC.
           05 dusr-mfa-enabled USAGE BINARY-CHAR UNSIGNED SYNC.
           05 dusr-banner USAGE POINTER SYNC.
           05 dusr-accent-color USAGE BINARY-INT SYNC.
           05 dusr-locale USAGE POINTER SYNC.
           05 dusr-verified USAGE BINARY-CHAR UNSIGNED SYNC.
           05 dusr-email USAGE POINTER SYNC.
           05 dusr-flags USAGE BINARY-DOUBLE UNSIGNED SYNC.
           05 dusr-premium-type USAGE BINARY-INT UNSIGNED SYNC.
           05 dusr-public-flags USAGE BINARY-DOUBLE UNSIGNED SYNC.
       01 discord-embed.
           05 demb-title USAGE POINTER SYNC.
           05 demb-type USAGE POINTER SYNC.
           05 demb-description USAGE POINTER SYNC.
           05 demb-url USAGE POINTER SYNC.
           05 demb-timestamp USAGE BINARY-DOUBLE UNSIGNED SYNC.
           05 demb-color USAGE BINARY-INT SYNC.
           05 demb-footer USAGE POINTER SYNC.
           05 demb-image USAGE POINTER SYNC.
           05 demb-thumbnail USAGE POINTER SYNC.
           05 demb-video USAGE POINTER SYNC.
           05 demb-provider USAGE POINTER SYNC.
           05 demb-author USAGE POINTER SYNC.
           05 demb-fields USAGE POINTER SYNC.
       01 discord-create-message.
           05 dcmsg-content USAGE POINTER SYNC.
           05 dcmsg-tts USAGE BINARY-CHAR UNSIGNED SYNC.
           05 dcmsg-embeds USAGE POINTER SYNC.
           05 dcmsg-allowed-mentions USAGE POINTER SYNC.
           05 dcmsg-message-reference USAGE POINTER SYNC.
           05 dcmsg-components USAGE POINTER SYNC.
           05 dcmsg-sticker-ids USAGE POINTER SYNC.
           05 dcmsg-attachments USAGE POINTER SYNC.
           05 dcmsg-flags USAGE BINARY-DOUBLE UNSIGNED SYNC.
       01 discord-embeds.
           05 dembs-size USAGE BINARY-INT SYNC.
           05 dembs-array USAGE POINTER SYNC.
           05 dembs-realsize USAGE BINARY-INT SYNC.
       01 discord-message-reference.
           05 dmsgr-message-id USAGE BINARY-DOUBLE UNSIGNED SYNC.
           05 dmsgr-channel-id USAGE BINARY-DOUBLE UNSIGNED SYNC.
           05 dmsgr-guild-id USAGE BINARY-DOUBLE UNSIGNED SYNC.
           05 dmsgr-fail-if-not-exists USAGE BINARY-CHAR UNSIGNED SYNC.
       LINKAGE SECTION.
       01 client USAGE POINTER.
       01 discord-message.
           05 dmsg-id USAGE BINARY-DOUBLE UNSIGNED SYNC.
           05 dmsg-channel-id USAGE BINARY-DOUBLE UNSIGNED SYNC.
           05 dmsg-channel-id-ptr REDEFINES dmsg-channel-id
               USAGE POINTER.
           05 dmsg-guild-id USAGE BINARY-DOUBLE UNSIGNED SYNC.
           05 dmsg-author USAGE POINTER SYNC.
           05 dmsg-member USAGE POINTER SYNC.
           05 dmsg-content USAGE POINTER SYNC.
           05 dmsg-timestamp USAGE BINARY-DOUBLE UNSIGNED SYNC.
           05 dmsg-edited-timestamp USAGE BINARY-DOUBLE UNSIGNED SYNC.
           05 dmsg-tts USAGE BINARY-CHAR UNSIGNED SYNC.
           05 dmsg-mention-everyone USAGE BINARY-CHAR UNSIGNED SYNC.
           05 dmsg-mentions USAGE POINTER SYNC.
           05 dmsg-mention-roles USAGE POINTER SYNC.
           05 dmsg-mention-channels USAGE POINTER SYNC.
           05 dmsg-attachments USAGE POINTER SYNC.
           05 dmsg-embeds USAGE POINTER SYNC.
           05 dmsg-reactions USAGE POINTER SYNC.
           05 dmsg-nonce USAGE POINTER SYNC.
           05 dmsg-pinned USAGE BINARY-CHAR UNSIGNED SYNC.
           05 dmsg-webhook-id USAGE BINARY-DOUBLE UNSIGNED SYNC.
           05 dmsg-type USAGE BINARY-INT UNSIGNED SYNC.
           05 dmsg-activity USAGE POINTER SYNC.
           05 dmsg-application USAGE POINTER SYNC.
           05 dmsg-application-id USAGE BINARY-DOUBLE UNSIGNED SYNC.
           05 dmsg-message-reference USAGE POINTER SYNC.
           05 dmsg-flags USAGE BINARY-DOUBLE UNSIGNED SYNC.
           05 dmsg-referenced-message USAGE POINTER SYNC.
           05 dmsg-interaction USAGE POINTER SYNC.
           05 dmsg-thread USAGE POINTER SYNC.
           05 dmsg-components USAGE POINTER SYNC.
           05 dmsg-sticker-items USAGE POINTER SYNC.
       PROCEDURE DIVISION.
       ENTRY STDCALL "mycolor" USING
           BY VALUE client
           BY REFERENCE discord-message.
           INITIALIZE discord-embed discord-create-message
               discord-embeds discord-message-reference.
           SET ADDRESS OF discord-user TO dmsg-author.
           IF dusr-bot <> 0 THEN EXIT PROGRAM.
           CALL STATIC "open" USING
               "/dev/urandom"&x"00"
               BY VALUE 0
               RETURNING dev-urandom-fd.
           CALL STATIC "read" USING
               BY VALUE dev-urandom-fd
               BY REFERENCE demb-color
               BY VALUE BYTE-LENGTH(demb-color).
           CALL STATIC "close" USING BY VALUE dev-urandom-fd.
           CALL STATIC "CBL_AND" USING
               H'FFFFFF' demb-color
               BY VALUE BYTE-LENGTH(demb-color).
           CALL STATIC "discord_embed_set_title" USING
               BY REFERENCE discord-embed
               "Your color"&x"00".
           CALL STATIC "discord_embed_set_description" USING
               BY REFERENCE discord-embed
               "I think your color is `#%06x`."&x"00"
               BY VALUE demb-color.
           MOVE 1 TO dembs-size.
           MOVE ADDRESS OF discord-embed TO dembs-array.
           MOVE ADDRESS OF discord-embeds TO dcmsg-embeds.
           MOVE dmsg-id TO dmsgr-message-id.
           MOVE dmsg-channel-id TO dmsgr-channel-id.
           MOVE dmsg-guild-id TO dmsgr-guild-id.
           MOVE 0 TO dmsgr-fail-if-not-exists.
           MOVE ADDRESS OF discord-message-reference
               TO dcmsg-message-reference.
           CALL STATIC "discord_create_message" USING
               BY VALUE client
               BY VALUE dmsg-channel-id-ptr
               BY REFERENCE discord-create-message
               NULL.
           CALL STATIC "discord_embed_cleanup" USING
               BY REFERENCE discord-embed.
           EXIT PROGRAM.
