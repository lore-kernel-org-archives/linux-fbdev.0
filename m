From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: [PATCH] matroxfb dies when you try to use secondary head in 2.5.x
Date: Sat, 8 Jun 2002 02:12:56 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <adrifq$tc7$2@main.gmane.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from vana.vc.cvut.cz ([147.32.240.58])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17GTqo-00017o-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Jun 2002 17:13:03 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Hi Linus,
   please apply this to 2.5.20. James introduced bad bug which
causes NULL pointer dereference as soon as you'll try to use
secondary head because of screen_base is not initialized
(it is initialized on wrong head).
				Thanks,
					Petr Vandrovec
					vandrove@vc.cvut.cz


diff -urdN linux/drivers/video/matrox/matroxfb_crtc2.c linux/drivers/video/matrox/matroxfb_crtc2.c
--- linux/drivers/video/matrox/matroxfb_crtc2.c	Mon Jun  3 01:44:45 2002
+++ linux/drivers/video/matrox/matroxfb_crtc2.c	Fri Jun  7 23:03:07 2002
@@ -383,7 +383,7 @@
 		chgvar = 0;
 	p->var = *var;
 	/* cmap */
-	ACCESS_FBINFO(fbcon.screen_base) = vaddr_va(m2info->video.vbase);
+	m2info->fbcon.screen_base = vaddr_va(m2info->video.vbase);
 	p->visual = visual;
 	p->ypanstep = 1;
 	p->ywrapstep = 0;

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
