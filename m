From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: mx3fb: fix regression with uninitalized
	fb_info->mm_lock mutex
Date: Tue, 7 Jul 2009 19:22:09 +0200
Message-ID: <20090707192209.a7974368.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MOEDP-0001d0-T8
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Jul 2009 17:12:23 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOEDK-0005V7-4S for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Jul 2009 17:12:23 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: daniel@caiaq.de

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove redundant call to the mx3fb_set_par before the register_framebuffer().

This fixes a problem with uninitialized the fb_info->mm_lock mutex introduced 
by the commit 537a1bf059f " fbdev: add mutex for fb_mmap locking"

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
Daniel,

Could you test this patch?

The mx3fb_set_par() is called from the register_framebuffer() anyway, so please check what 
to add to correctly unblank console for the first time. Maybe setting 

mx3_fbi->blank = FB_BLANK_UNBLANK;

before the call to register_framebuffer() is enough.

Regards,
Krzysztof

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index 567fb94..f8778cd 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -1365,11 +1365,6 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 	init_completion(&mx3fbi->flip_cmpl);
 	disable_irq(ichan->eof_irq);
 	dev_dbg(mx3fb->dev, "disabling irq %d\n", ichan->eof_irq);
-	ret = mx3fb_set_par(fbi);
-	if (ret < 0)
-		goto esetpar;
-
-	mx3fb_blank(FB_BLANK_UNBLANK, fbi);
 
 	dev_info(dev, "registered, using mode %s\n", fb_mode);
 

----------------------------------------------------------------------
Promocja ubezpieczen komunikacyjnych Ergo Hestia. Sprawdz!
http://link.interia.pl/f222f


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
