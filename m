From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] video: deferred io cleanup
Date: Wed, 17 Dec 2008 17:37:13 +0900
Message-ID: <20081217083713.30323.29055.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <magnus.damm@gmail.com>) id 1LCrvv-0000TV-9b
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Dec 2008 08:39:07 +0000
Received: from rv-out-0708.google.com ([209.85.198.250])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LCrvs-0000Y5-4s for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Dec 2008 08:39:07 +0000
Received: by rv-out-0708.google.com with SMTP id f25so3401678rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 17 Dec 2008 00:39:02 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@igel.co.jp>

Make sure the mmap callback is set to NULL in the deferred io
cleanup function. This way we can enable and disable deferred
io on the fly.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/video/fb_defio.c |    3 +++
 1 file changed, 3 insertions(+)

--- 0004/drivers/video/fb_defio.c
+++ work/drivers/video/fb_defio.c	2008-12-17 15:32:04.000000000 +0900
@@ -202,6 +202,9 @@ void fb_deferred_io_cleanup(struct fb_in
 		page = vmalloc_to_page(screen_base + i);
 		page->mapping = NULL;
 	}
+
+	info->fbops->fb_mmap = NULL;
+	mutex_destroy(&fbdefio->lock);
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
 

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
