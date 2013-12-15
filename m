From: Olaf Hering <olaf@aepfle.de>
Date: Sun, 15 Dec 2013 20:40:35 +0000
Subject: [PATCH] fbmem: really support wildcard video=options for all fbdev drivers
Message-Id: <1387140035-12234-1-git-send-email-olaf@aepfle.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Olaf Hering <olaf@aepfle.de>

Documentation/fb/modedb.txt states that video=option should be
considered a global option. But video_setup and fb_get_options are not
coded that way. Instead its required to boot with video=driver:option to
set a given option in drvier.  This is cumbersome because it requires to
know in advance which driver will be active for a given board/kernel.

The following patch implements the documented catchall for the fbdev
drivers. It is now possible to boot with video=XxY without the need to
know the active driver in advance. The specific case it tries to fix is
syslinux in the SUSE installer which offers a menu to set a display
resolution. Right now this just appends the vga= option the kernel. But
in addition to vga= it should be possible to pass a generic video=XxY
for all framebuffer/drm drivers. With this change forcing a certain
window size of VM displays is now much easier.

Today the video= option is stored in a global fb_mode_option. But
unfortunately only drm uses it.

Note: this change introduces a small memleak if video=option is actually
used because fb_mode_option is const. Most drivers use strsep to get to
individual options. This could be fixed in a followup patch which always
releases the option string in every caller of fb_get_options.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 drivers/video/fbmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 010d191..cde4619 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1930,6 +1930,9 @@ int fb_get_options(const char *name, char **option)
 				options = opt + name_len + 1;
 		}
 	}
+	/* No match, pass global option */
+	if (!options && option && fb_mode_option)
+		options = kstrdup(fb_mode_option, GFP_KERNEL);
 	if (options && !strncmp(options, "off", 3))
 		retval = 1;
 
