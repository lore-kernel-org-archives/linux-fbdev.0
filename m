From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 1/7 2.6.17-rc6-mm2] add preliminary i2c
	support to intelfb
Date: Wed, 14 Jun 2006 13:52:46 -0400
Message-ID: <EB373D75-DE32-4833-B201-8EFF45533863@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqZVF-0001B5-6f for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 10:50:05 -0700
Received: from mail6.sea5.speakeasy.net ([69.17.117.8])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FqZVE-0000Vq-S6
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 10:50:05 -0700
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
Cc: khali@linux-fr.org, Eric Hustvedt <ehustvedt@cecropia.com>, Dave Airlie <airlied@skynet.ie>

From: Dennis Munsie <dmunsie@cecropia.com>

[01/07] i2c: add intelfb bit algorithm id

Adds the intelfb bit algorithm id to i2c-id.h.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

include/linux/i2c-id.h |    1 +
1 file changed, 1 insertion(+)

diff -Naurp -X linux-2.6.17-rc6-patched/Documentation/dontdiff  
linux-2.6.17-rc6-patched/include/linux/i2c-id.h linux/include/linux/ 
i2c-id.h
--- linux-2.6.17-rc6-patched/include/linux/i2c-id.h	2006-06-13  
14:57:01.000000000 -0500
+++ linux/include/linux/i2c-id.h	2006-06-14 10:04:54.000000000 -0500
@@ -189,6 +189,7 @@
#define I2C_HW_B_RADEON		0x01001e /* radeon framebuffer driver */
#define I2C_HW_B_EM28XX		0x01001f /* em28xx video capture cards */
#define I2C_HW_B_CX2341X	0x010020 /* Conexant CX2341X MPEG encoder  
cards */
+#define I2C_HW_B_INTELFB	0x010021 /* intel framebuffer driver */
/* --- PCF 8584 based algorithms					*/
#define I2C_HW_P_LP		0x020000 /* Parallel port interface */
