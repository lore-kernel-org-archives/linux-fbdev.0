From: Ben Dooks <ben-linux@fluff.org>
Subject: FB: Fix platform_lcd match entry.
Date: Tue, 08 Jul 2008 10:37:30 +0100
Message-ID: <20080708093729.970594944@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KG9dk-0007MF-BR for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Jul 2008 02:37:40 -0700
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KG9di-00048Z-Vh
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 Jul 2008 02:37:40 -0700
Content-Disposition: inline;
	filename=simtec/simtec-drivers-fb-platformlcd-fixmatch.patch
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Ben Dooks <ben-linux@fluff.org>

The platform_lcd driver was matching against the
framebuffer device entry, and not the framebuffer's
parent device.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--- linux-2.6.26-rc6-quilt1.orig/drivers/video/backlight/platform_lcd.c	2008-06-15 20:27:56.000000000 +0100
+++ linux-2.6.26-rc6-quilt1/drivers/video/backlight/platform_lcd.c	2008-06-15 21:07:22.000000000 +0100
@@ -62,7 +62,7 @@ static int platform_lcd_match(struct lcd
 	if (pdata->match_fb)
 		return pdata->match_fb(pdata, info);
 
-	return plcd->us->parent == info->dev;
+	return plcd->us->parent == info->device;
 }
 
 static struct lcd_ops platform_lcd_ops = {

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
