From: Martin Michlmayr <tbm@cyrius.com>
Subject: [PATCH] IP32 gbefb depth change fix
Date: Fri, 17 Feb 2006 03:37:47 +0000
Message-ID: <20060217033747.GA3779@deprecation.cyrius.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F9wRS-0007ku-1p
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Feb 2006 19:37:58 -0800
Received: from sorrow.cyrius.com ([65.19.161.204])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1F9wRQ-0001DI-TR
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Feb 2006 19:37:58 -0800
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Kaj-Michael Lang <milang@tal.org>

From: Kaj-Michael Lang <milang@tal.org>

IP32 gbefb depth change fix

The gbefb driver does not update the framebuffer layers visual setting
when depth is changed with fbset, resulting in strange colors (very
dark blue in 16-bit, almost black in 24-bit).

Signed-off-by: Kaj-Michael Lang <milang@tal.org>
Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---

 gbefb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -656,12 +656,15 @@ static int gbefb_set_par(struct fb_info 
 	switch (bytesPerPixel) {
 	case 1:
 		SET_GBE_FIELD(WID, TYP, val, GBE_CMODE_I8);
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
 		break;
 	case 2:
 		SET_GBE_FIELD(WID, TYP, val, GBE_CMODE_ARGB5);
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
 		break;
 	case 4:
 		SET_GBE_FIELD(WID, TYP, val, GBE_CMODE_RGB8);
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
 		break;
 	}
 	SET_GBE_FIELD(WID, BUF, val, GBE_BMODE_BOTH);

-- 
Martin Michlmayr
http://www.cyrius.com/


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
