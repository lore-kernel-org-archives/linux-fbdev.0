From: David Howells <dhowells@redhat.com>
Date: Fri, 03 Jan 2014 16:08:04 +0000
Subject: [PATCH 6/7] Fix a warning pertaining to the aty128fb backlight variable
Message-Id: <20140103160804.8153.94982.stgit@warthog.procyon.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: dhowells@redhat.com, linux-fbdev@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org

Fix the following warning in the aty128fb driver:

	drivers/video/aty/aty128fb.c:363:12: warning: 'backlight' defined but not used [-Wunused-variable]
	 static int backlight = 0;
		    ^

as the variable's value is only read if CONFIG_FB_ATY128_BACKLIGHT=y.  The
variable is also set if MODULE is unset[*].

[*] I wonder if the conditional wrapper around aty128fb_setup() should be
    using CONFIG_MODULE rather than MODULE.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paul Mackerras <paulus@samba.org>
cc: linux-fbdev@vger.kernel.org
---

 drivers/video/aty/aty128fb.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index 12ca031877d4..52108be69e77 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -357,11 +357,13 @@ static int default_lcd_on = 1;
 static bool mtrr = true;
 #endif
 
+#ifdef CONFIG_FB_ATY128_BACKLIGHT
 #ifdef CONFIG_PMAC_BACKLIGHT
 static int backlight = 1;
 #else
 static int backlight = 0;
 #endif
+#endif
 
 /* PLL constants */
 struct aty128_constants {
@@ -1671,7 +1673,9 @@ static int aty128fb_setup(char *options)
 			default_crt_on = simple_strtoul(this_opt+4, NULL, 0);
 			continue;
 		} else if (!strncmp(this_opt, "backlight:", 10)) {
+#ifdef CONFIG_FB_ATY128_BACKLIGHT
 			backlight = simple_strtoul(this_opt+10, NULL, 0);
+#endif
 			continue;
 		}
 #ifdef CONFIG_MTRR

