From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 01/11] fbcon: Kill compile warning
Date: Wed, 01 Aug 2007 15:33:09 +0800
Message-ID: <46B03735.9020803@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IG9NI-0003EU-No for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 01:16:09 -0700
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IG9NH-0004jH-Vr
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 01:16:08 -0700
Received: by wa-out-1112.google.com with SMTP id k22so151532waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 01 Aug 2007 01:16:07 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fix compile warning ('map_override unused') if fbcon is compiled as a 
module and CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=n.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/console/fbcon.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index decfdc8..08f4dd0 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -127,8 +127,18 @@ static int last_fb_vc = MAX_NR_CONSOLES 
 static int fbcon_is_default = 1; 
 static int fbcon_has_exited;
 static int primary_device = -1;
+
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
 static int map_override;
 
+static inline void fbcon_map_override(void)
+{
+	map_override = 1;
+}
+#else
+#define fbcon_map_override(...) do { } while (0)
+#endif /* CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY */
+
 /* font data */
 static char fontname[40];
 
@@ -506,7 +516,7 @@ static int __init fb_console_setup(char 
 						(options[j++]-'0') % FB_MAX;
 				}
 
-				map_override = 1;
+				fbcon_map_override();
 			}
 
 			return 1;


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
