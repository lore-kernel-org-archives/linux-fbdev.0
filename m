From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] video: fix deferred io fsync()
Date: Wed, 17 Dec 2008 17:35:07 +0900
Message-ID: <20081217083507.30318.63380.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <magnus.damm@gmail.com>) id 1LCrtt-0001d3-M3
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Dec 2008 08:37:01 +0000
Received: from rv-out-0708.google.com ([209.85.198.247])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LCrtp-00052e-NP for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Dec 2008 08:37:00 +0000
Received: by rv-out-0708.google.com with SMTP id f25so3401074rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 17 Dec 2008 00:36:56 -0800 (PST)
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

If CONFIG_FB_DEFERRED_IO is set, but there are framebuffers 
registered that does not make use of deferred io, then fsync()
on those framebuffers will result in a crash. Fix that.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/video/fb_defio.c |    4 ++++
 1 file changed, 4 insertions(+)

--- 0001/drivers/video/fb_defio.c
+++ work/drivers/video/fb_defio.c	2008-12-17 15:27:44.000000000 +0900
@@ -60,6 +60,10 @@ int fb_deferred_io_fsync(struct file *fi
 {
 	struct fb_info *info = file->private_data;
 
+	/* Skip if deferred io is complied-in but disabled on this fbdev */
+	if (!info->fbdefio)
+		return 0;
+
 	/* Kill off the delayed work */
 	cancel_rearming_delayed_work(&info->deferred_work);
 

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
