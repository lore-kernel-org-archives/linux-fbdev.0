From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 11/24] pvr2fb: Fix pseudo_palette array
	overrun and typecast
Date: Sat, 02 Jun 2007 18:00:30 +0800
Message-ID: <46613FBE.2000507@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuRX7-0005dM-Rv for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 04:12:34 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQil-00011W-Iu
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:20:31 -0700
Received: by py-out-1112.google.com with SMTP id u77so1508651pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:20:31 -0700 (PDT)
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
Cc: Paul Mundt <lethal@linux-sh.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- the pseudo_palette has only 16 elements. Do not write if regno (the array
  index) is more than 15.
- if using generic drawing libraries, the typecast of pseudo_palette is 
  always u32 *

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pvr2fb.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
index df2909a..0af90e0 100644
--- a/drivers/video/pvr2fb.c
+++ b/drivers/video/pvr2fb.c
@@ -337,24 +337,25 @@ static int pvr2fb_setcolreg(unsigned int
 		      ((blue  & 0xf800) >> 11);
 
 		pvr2fb_set_pal_entry(par, regno, tmp);
-		((u16*)(info->pseudo_palette))[regno] = tmp;
 		break;
 	    case 24: /* RGB 888 */
 		red >>= 8; green >>= 8; blue >>= 8;
-		((u32*)(info->pseudo_palette))[regno] = (red << 16) | (green << 8) | blue;
+		tmp = (red << 16) | (green << 8) | blue;
 		break;
 	    case 32: /* ARGB 8888 */
 		red >>= 8; green >>= 8; blue >>= 8;
 		tmp = (transp << 24) | (red << 16) | (green << 8) | blue;
 
 		pvr2fb_set_pal_entry(par, regno, tmp);
-		((u32*)(info->pseudo_palette))[regno] = tmp;
 		break;
 	    default:
 		pr_debug("Invalid bit depth %d?!?\n", info->var.bits_per_pixel);
 		return 1;
 	}
 
+	if (regno < 16)
+		((u32*)(info->pseudo_palette))[regno] = tmp;
+
 	return 0;
 }
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
