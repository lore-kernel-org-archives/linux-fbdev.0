From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/18] arcfb: Fix uninitialized value
Date: Sat, 11 Mar 2006 09:49:16 +0800
Message-ID: <44122C9C.2050006@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHtmL-000514-Dq
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 18:24:25 -0800
Received: from pproxy.gmail.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHtmK-0000fB-8K
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 18:24:25 -0800
Received: by pproxy.gmail.com with SMTP id z59so421959pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Mar 2006 18:24:21 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jaya Kumar <jayalk@intworks.biz>

Remove insignificant and uninitialized variable "count" from
arcfb_lcd_update_page.

Coverity Bug 894

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/arcfb.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index df8e566..0cf26da 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -253,7 +253,7 @@ static void arcfb_lcd_update_page(struct
 {
 	unsigned char *src;
 	unsigned int xindex, yindex, chipindex, linesize;
-	int i, count;
+	int i;
 	unsigned char val;
 	unsigned char bitmask, rightshift;
 
@@ -282,7 +282,6 @@ static void arcfb_lcd_update_page(struct
 		}
 		ks108_writeb_data(par, chipindex, val);
 		left++;
-		count++;
 		if (bitmask == 0x80) {
 			bitmask = 1;
 			src++;




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
