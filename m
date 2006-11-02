From: akpm@osdl.org
Subject: [patch 12/25] mbxfb: Fix HSCOEFF3 register
	address
Date: Wed, 01 Nov 2006 21:50:25 -0800
Message-ID: <200611020550.kA25oPx3002324@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfVUb-0007h3-U3 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:51:58 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfVUb-0007gu-Hc
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:51:57 -0800
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
Cc: akpm@osdl.org, adaplas@pol.net, raph@8d.com

From: Raphael Assenat <raph@8d.com>

This patch corrects the address for register HSCOEFF3.

Signed-off-by: Raphael Assenat <raph@8d.com>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/mbx/regs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/video/mbx/regs.h~mbxfb-fix-hscoeff3-register-address drivers/video/mbx/regs.h
--- a/drivers/video/mbx/regs.h~mbxfb-fix-hscoeff3-register-address
+++ a/drivers/video/mbx/regs.h
@@ -127,7 +127,7 @@
 #define HSCOEFF0	__REG_2700G(0x000021b4)
 #define HSCOEFF1	__REG_2700G(0x000021b8)
 #define HSCOEFF2	__REG_2700G(0x000021bc)
-#define HSCOEFF3	__REG_2700G(0x000021b0)
+#define HSCOEFF3	__REG_2700G(0x000021c0)
 #define HSCOEFF4	__REG_2700G(0x000021c4)
 #define HSCOEFF5	__REG_2700G(0x000021c8)
 #define HSCOEFF6	__REG_2700G(0x000021cc)
_

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
