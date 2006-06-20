From: dmunsie@cecropia.com (Dennis Munsie)
Subject: [PATCH 2.6.17-rc6-mm2 2/8] intelfb: RESEND -
	add preliminary i2c support
Date: Tue, 20 Jun 2006 14:55:55 -0400 (EDT)
Message-ID: <20060620185555.25C7A90CFB1@xenon>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FslL3-0003Bj-92 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 11:52:37 -0700
Received: from mail8.sea5.speakeasy.net ([69.17.117.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FslKz-0001uX-Qa
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 11:52:34 -0700
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
Cc: ehustvedt@cecropia.com, airlied@skynet.ie

From: Dennis Munsie <dmunsie@cecropia.com>

[02/07] intelfb: add GPIO registers.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

 drivers/video/intelfb/intelfbhw.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff -Naurp -X linux-2.6.17-rc6-patched/Documentation/dontdiff linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfbhw.h linux/drivers/video/intelfb/intelfbhw.h
--- linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfbhw.h	2006-06-14 10:09:55.000000000 -0500
+++ linux/drivers/video/intelfb/intelfbhw.h	2006-06-14 10:24:38.000000000 -0500
@@ -126,6 +126,12 @@
 #define FW_DISPC_BL_SHIFT		8
 #define FW_DISPC_BL_MASK		0x7
 
+#define GPIOA             0x5010
+#define GPIOB             0x5014
+#define GPIOC             0x5018 // this may be external DDC on i830
+#define GPIOD             0x501C // this is DVO DDC
+#define GPIOE             0x5020 // this is DVO i2C
+#define GPIOF             0x5024
 
 /* PLL registers */
 #define VGA0_DIVISOR		0x06000
