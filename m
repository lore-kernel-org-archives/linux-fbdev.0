From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/9] fbdev: Revive global_mode_option
Date: Wed, 22 Dec 2004 05:31:45 +0800
Message-ID: <20041221213641.178C31A019F@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cgrgk-0007WS-L5
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:37:02 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cgrgj-0001H0-RW
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:37:02 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 037D8BA57DF
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Dec 2004 21:36:49 +0000 (UTC)
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The global_mode_option is useful for choosing the initial video mode
without specifying the driver, ie 'video=1024x768@60'.  After the
initialization cleanup, this variable was accidentally removed.  This patch 
brings it back again.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbmem.c  |   29 +++++++++++++++++++++--------
 modedb.c |    4 +---
 2 files changed, 22 insertions(+), 11 deletions(-)

diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2004-12-18 20:38:35 +08:00
+++ b/drivers/video/fbmem.c	2004-12-21 05:44:01 +08:00
@@ -1224,19 +1224,32 @@
  *
  */
 
+extern const char *global_mode_option;
+
 int __init video_setup(char *options)
 {
-	int i;
+	int i, global = 0;
 
 	if (!options || !*options)
-		return 0;
+ 		global = 1;
+ 
+ 	if (!global && !strncmp(options, "ofonly", 6)) {
+ 		ofonly = 1;
+ 		global = 1;
+ 	}
+ 
+ 	if (!global && !strstr(options, "fb:")) {
+ 		global_mode_option = options;
+ 		global = 1;
+ 	}
+  
+ 	if (!global) {
+ 		for (i = 0; i < FB_MAX; i++) {
+ 			if (video_options[i] == NULL) {
+ 				video_options[i] = options;
+ 				break;
+ 			}
 
-	for (i = 0; i < FB_MAX; i++) {
-		if (!strncmp(options, "ofonly", 6))
-			ofonly = 1;
-		if (video_options[i] == NULL) {
-			video_options[i] = options;
-			break;
 		}
 	}
 
diff -Nru a/drivers/video/modedb.c b/drivers/video/modedb.c
--- a/drivers/video/modedb.c	2004-11-17 18:15:20 +08:00
+++ b/drivers/video/modedb.c	2004-11-28 09:18:42 +08:00
@@ -29,9 +29,7 @@
 #define DPRINTK(fmt, args...)
 #endif
 
-
-const char *global_mode_option = NULL;
-
+const char *global_mode_option;
 
     /*
      *  Standard video mode definitions (taken from XFree86)





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
