FROM alpine:3.7

# Add community repos.
RUN echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
	echo "http://dl-3.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
	echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
	echo "http://dl-5.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# Install packages.
RUN apk add --no-cache \
	tini \
	unison

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]


CMD [ \
	"unison", "/host", "/volume", \
	"-auto", \
	"-batch", \
	"-repeat", "watch", \
	"-prefer", "newer", \
	"-copyonconflict", \
	"-ignore", "Path {drupal/vendor}", \
	"-ignore", "Name node_modules", \
	"-ignore", "Path {drupal/sites/default/files/php}", \
	"-ignore", "Path {drupal/sites/default/files/js}", \
	"-ignore", "Path {drupal/sites/default/files/css}", \
	"-ignore", "Path {drupal/sites/default/files/styles}", \
	"-ignore", "Path {db_dump/local}", \
	"-ignore", "Path {php}", \
	"-ignore", "Path {apache}", \
	"-ignore", "Path {drupal/sites/default/files/config_*}", \
	"-ignore", "Path {drupal/sites/*/services*.yml}", \
	"-ignore", "Name {.DS_Store}", \
	"-ignore", "Name {.idea}", \
	"-ignore", "Name {.git}" \
]
