From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/5] gbefb: IP32 gbefb depth change fix
Date: Thu, 23 Feb 2006 19:56:45 +0800
Message-ID: <43FDA2FD.2070300@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FCiwY-000564-86
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Feb 2006 11:49:34 -0800
Received: from pproxy.gmail.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FCiwW-0008Ev-0J
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Feb 2006 11:49:34 -0800
Received: by pproxy.gmail.com with SMTP id o67so458708pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Feb 2006 11:49:31 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Kaj-Michael Lang <milang@tal.org>

From: Kaj-Michael Lang <milang@tal.org>

The gbefb driver does not update the framebuffer layers visual setting
when depth is changed with fbset, resulting in strange colors (very
dark blue in 16-bit, almost black in 24-bit).

Signed-off-by: Kaj-Michael Lang <milang@tal.org>
Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/gbefb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
index c9a7cdf..5e25b98 100644
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



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
