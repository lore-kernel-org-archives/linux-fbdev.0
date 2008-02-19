From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: pm2fb: corrects error values returned from
	probe function
Date: Tue, 19 Feb 2008 21:19:27 +0100
Message-ID: <20080219211927.4549624c.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JRYr6-00029A-UM for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Feb 2008 12:14:20 -0800
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JRYr3-0004pn-Bo
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Feb 2008 12:14:20 -0800
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: adaplas@gmail.com

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes error values returned in some code branches
in the pm2fb_probe() function.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff -urp linux-mm-ref/drivers/video/pm2fb.c linux-mm/drivers/video/pm2fb.c
--- linux-mm-ref/drivers/video/pm2fb.c	2008-02-18 21:12:29.000000000 +0100
+++ linux-mm/drivers/video/pm2fb.c	2008-02-19 21:16:18.145699735 +0100
@@ -1687,10 +1687,12 @@ static int __devinit pm2fb_probe(struct 
 	if (!err || err == 4)
 		info->var = pm2fb_var;
 
-	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
+	retval = fb_alloc_cmap(&info->cmap, 256, 0);
+	if (retval < 0)
 		goto err_exit_both;
 
-	if (register_framebuffer(info) < 0)
+	retval = register_framebuffer(info);
+	if (retval < 0)
 		goto err_exit_all;
 
 	printk(KERN_INFO "fb%d: %s frame buffer device, memory = %dK.\n",


---------------------------------------------------------------------- 	
Sprawdz gdzie lezy snieg, czy dzialaja armatki
i jak przygotowane sa stoki >>> http://link.interia.pl/f1cfc



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
