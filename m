From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/video/console/fbcon.c: fix a check after use
Date: Sun, 27 Mar 2005 22:41:19 +0200
Message-ID: <20050327204119.GY4285@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DFeZa-00048t-H8
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 27 Mar 2005 12:41:26 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5] helo=mailout.stusta.mhn.de)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DFeZZ-0000OV-Lp
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 27 Mar 2005 12:41:26 -0800
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch fixes a check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.12-rc1-mm1-full/drivers/video/console/fbcon.c.old	2005-03-23 04:53:20.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/video/console/fbcon.c	2005-03-23 04:53:44.000000000 +0100
@@ -906,10 +906,13 @@ static void fbcon_init(struct vc_data *v
 	struct vc_data *svc = *default_mode;
 	struct display *t, *p = &fb_display[vc->vc_num];
 	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
-	int cap = info->flags;
+	int cap;
 
 	if (info_idx == -1 || info == NULL)
 	    return;
+
+	cap = info->flags;
+
 	if (vc != svc || logo_shown == FBCON_LOGO_DONTSHOW ||
 	    (info->fix.type == FB_TYPE_TEXT))
 		logo = 0;



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
