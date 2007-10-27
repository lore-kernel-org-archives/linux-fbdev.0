From: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH] Free when fb can't be registered in
 video/aty/atyfb_base.c
Date: Sat, 27 Oct 2007 14:31:15 +0200
Message-ID: <47232F93.2020905@tiscali.nl>
References: <47229AAA.9020907@tiscali.nl>
	<20071026202546.53b78732.randy.dunlap@oracle.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ilkp0-0003XD-Av for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 27 Oct 2007 05:31:22 -0700
Received: from smtp-out0.tiscali.nl ([195.241.79.175])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ilkoy-0005oi-TJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 27 Oct 2007 05:31:22 -0700
In-Reply-To: <20071026202546.53b78732.randy.dunlap@oracle.com>
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
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

Randy Dunlap wrote:
> 
> Use tabs for indent above, not spaces.
> 
> Yes, looks needed to me.  Hopefully Tony will correct us if we
> are wrong.
> 

Thanks for reviewing, here is one without the little spaces
--
Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
--
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index d775eb6..669abd3 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2680,10 +2680,13 @@ static int __devinit aty_init(struct fb_info *info)
 #endif /* CONFIG_FB_ATY_CT */
 	info->var = var;
 
-	fb_alloc_cmap(&info->cmap, 256, 0);
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
+		goto aty_init_exit;
 
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info) < 0) {
+		fb_dealloc_cmap(&info->cmap);
 		goto aty_init_exit;
+	}
 
 	fb_list = info;
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
