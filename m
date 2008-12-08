From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [patch v2] fbcon: Fix workqueue shutdown
Date: Mon, 8 Dec 2008 12:58:44 -0800
Message-ID: <493D8A84.1050107@am.sony.com>
References: <4909EB41.40100@am.sony.com> <493722F0.5070707@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geoffrey.Levand@am.sony.com>) id 1L9nBu-0002LL-AY
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 08 Dec 2008 20:58:54 +0000
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]
	helo=WA4EHSOBE002.bigfish.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.69) id 1L9nBr-0001f4-Aa
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 08 Dec 2008 20:58:54 +0000
In-Reply-To: <493722F0.5070707@am.sony.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

Add a call to cancel_work_sync() in fbcon_exit() to cancel
any pending work in the fbcon workqueue.

The current implementation of fbcon_exit() sets the fbcon
workqueue function info->queue.func to NULL, but does not
assure that there is no work pending when it does so.  On
occasion, depending on system timing, there will still be
pending work in the queue when fbcon_exit() is called.
This results in a null pointer deference when
run_workqueue() tries to call the queue's work function.

Fixes errors on shutdown similar to these:

  Console: switching to colour dummy device 80x25
  Unable to handle kernel paging request for data at address 0x00000000

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
v2: Remove use of the fbcon_has_exited variable.

 drivers/video/console/fbcon.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3531,12 +3531,18 @@ static void fbcon_exit(void)
 	softback_buf = 0UL;
 
 	for (i = 0; i < FB_MAX; i++) {
+		int pending;
+
 		mapped = 0;
 		info = registered_fb[i];
 
 		if (info == NULL)
 			continue;
 
+		pending = cancel_work_sync(&info->queue);
+		DPRINTK("fbcon: %s pending work\n", (pending ? "canceled" :
+			"no"));
+
 		for (j = first_fb_vc; j <= last_fb_vc; j++) {
 			if (con2fb_map[j] == i)
 				mapped = 1;


------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
