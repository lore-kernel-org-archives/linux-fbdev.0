From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] i.MX framebuffer fix memory hole
Date: Tue, 15 May 2007 11:23:59 +0200
Message-ID: <20070515092359.GM5967@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HntRU-00041K-7U for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 15 May 2007 02:35:42 -0700
Received: from metis.extern.pengutronix.de ([83.236.181.26])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HntRS-0003Rq-MV
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 15 May 2007 02:35:40 -0700
Received: from leda.ptxnet.pengutronix.de ([10.1.0.71])
	by metis.extern.pengutronix.de with esmtp (Exim 3.36 #1 (Debian))
	id 1HntRR-0001ru-00 for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 15 May 2007 11:35:37 +0200
Received: from sha by leda.ptxnet.pengutronix.de with local (Exim 4.63)
	(envelope-from <sha@localhost.localdomain>) id 1HntRR-0007Kn-Ii
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 15 May 2007 11:35:37 +0200
Resent-Message-ID: <20070515093537.GO5967@localhost.localdomain>
Resent-To: linux-fbdev-devel@lists.sourceforge.net
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

Another small fix for the i.MX framebuffer driver (should be applied
after the previously sent one):

info->pseudo_palette was previously kmalloced. Do not overwrite
it afterwards

signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

---
 drivers/video/imxfb.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6/drivers/video/imxfb.c
===================================================================
--- linux-2.6.orig/drivers/video/imxfb.c
+++ linux-2.6/drivers/video/imxfb.c
@@ -468,7 +468,6 @@ static int __init imxfb_init_fbinfo(stru
 
 	info->fbops			= &imxfb_ops;
 	info->flags			= FBINFO_FLAG_DEFAULT;
-	info->pseudo_palette		= (fbi + 1);
 
 	fbi->rgb[RGB_16]		= &def_rgb_16;
 	fbi->rgb[RGB_8]			= &def_rgb_8;

-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
