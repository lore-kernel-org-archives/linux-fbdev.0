From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] au1200fb: fix oops due to uninitialized
	fb_info.lock mutex
Date: Tue, 07 Jul 2009 10:29:51 +0200
Message-ID: <4A53077F.50307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <manuel.lauss@googlemail.com>) id 1MO7dM-0007pM-4K
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Jul 2009 10:10:44 +0000
Received: from mail-fx0-f228.google.com ([209.85.220.228])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MO7dF-0004tr-Nx for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Jul 2009 10:10:44 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sf.net, Krzysztof Helt <krzysztof.h1@wp.pl>

commit 4148df9b0f38bdd362dd91d52076926c11cbe5a9 breaks au1200fb due to
fb_info.lock now being uninitialized at the time of the
register_frambuffer call:

CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 8038ccd4, ra == 802412d4
Call Trace:
[<8038ccd4>] __mutex_lock_slowpath+0x3c/0xe4
[<802412d4>] lock_fb_info+0x20/0x50
[<80242158>] register_framebuffer+0x264/0x2a4
[<8024f8c4>] au1200fb_drv_probe+0x308/0x444
[<80273ef8>] driver_probe_device+0xbc/0x184
[<8027402c>] __driver_attach+0x6c/0xa4
[<802736bc>] bus_for_each_dev+0x60/0xb0
[<80272e20>] bus_add_driver+0xc8/0x24c
[<802743f4>] driver_register+0xdc/0x190
[<8047d130>] au1200fb_init+0x39c/0x3cc
[<80100460>] _stext+0x60/0x1c8
[<8046f334>] kernel_init+0xc8/0x134
[<80106f64>] kernel_thread_helper+0x10/0x18

This band-aid fixes this oops.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 drivers/video/au1200fb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index 0d96f1d..293aff9 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -1671,6 +1671,8 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 		if ((ret = au1200fb_init_fbinfo(fbdev)) < 0)
 			goto failed;

+		mutex_init(&fbdev->fb_info.lock);
+
 		/* Register new framebuffer */
 		if ((ret = register_framebuffer(&fbdev->fb_info)) < 0) {
 			print_err("cannot register new framebuffer");
--
1.6.3.3


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
