From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 10/17] fbdev: Workaround for buggy EDID blocks
Date: Tue, 18 Oct 2005 17:19:53 +0800
Message-ID: <4354BE39.2020800@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERyIw-0000dY-GE
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:43:26 -0700
Received: from zproxy.gmail.com ([64.233.162.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ERyIv-0000v6-5g
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:43:26 -0700
Received: by zproxy.gmail.com with SMTP id s18so1165348nze
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Oct 2005 13:43:21 -0700 (PDT)
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

Some EDID blocks set the flag "prefer first detailed timing" without
providing any detailed timing at all.  Clear this flag if the block
does not provide detailed timings.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 fbmon.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletion(-)


diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -827,7 +827,7 @@ int fb_parse_edid(unsigned char *edid, s
 void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 {
 	unsigned char *block;
-	int i;
+	int i, found = 0;
 
 	if (edid == NULL)
 		return;
@@ -869,6 +869,22 @@ void fb_edid_to_monspecs(unsigned char *
 	get_monspecs(edid, specs);
 
 	specs->modedb = fb_create_modedb(edid, &specs->modedb_len);
+
+	/*
+	 * Workaround for buggy EDIDs that sets that the first
+	 * detailed timing is preferred but has not detailed
+	 * timing specified
+	 */
+	for (i = 0; i < specs->modedb_len; i++) {
+		if (specs->modedb[i].flag & FB_MODE_IS_DETAILED) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (!found)
+		specs->misc &= ~FB_MISC_1ST_DETAIL;
+
 	DPRINTK("========================================\n");
 }
 




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
