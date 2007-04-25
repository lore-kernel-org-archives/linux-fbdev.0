From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 34/41] fbdev: Save the activate field
	before calling fb_check_var()
Date: Wed, 25 Apr 2007 15:14:18 +0800
Message-ID: <462EFFCA.50900@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcCr-0001g6-Ii for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:46:29 -0700
Received: from wx-out-0506.google.com ([66.249.82.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgcCq-0004jf-9t
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:46:29 -0700
Received: by wx-out-0506.google.com with SMTP id i30so296822wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:46:27 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Some drivers may reset the var->activate field on fb_check_var(). This can
lead to undefined behavior. For example, doing fbset -a <option> with vga16fb
will only modify the active console instead of modifying all.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/fbmem.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index c4ce3e4..cd14079 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -803,6 +803,8 @@ fb_set_var(struct fb_info *info, struct 
 
 	if ((var->activate & FB_ACTIVATE_FORCE) ||
 	    memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
+		u32 activate = var->activate;
+
 		if (!info->fbops->fb_check_var) {
 			*var = info->var;
 			return 0;
@@ -831,7 +833,7 @@ fb_set_var(struct fb_info *info, struct 
 
 			if (!err && (flags & FBINFO_MISC_USEREVENT)) {
 				struct fb_event event;
-				int evnt = (var->activate & FB_ACTIVATE_ALL) ?
+				int evnt = (activate & FB_ACTIVATE_ALL) ?
 					FB_EVENT_MODE_CHANGE_ALL :
 					FB_EVENT_MODE_CHANGE;
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
