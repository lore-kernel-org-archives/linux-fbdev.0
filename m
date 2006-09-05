From: Raphael Assenat <raph@8d.com>
Subject: [PATCH 1/5] mbxfb: Fix HSCOEFF3 register address
Date: Tue, 05 Sep 2006 10:55:42 -0400
Message-ID: <44FD8FEE.7080606@8d.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020708090601090907000208"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GKcK2-0004xg-IG for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Sep 2006 07:54:42 -0700
Received: from roc.holo.8d.com ([64.254.227.115])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GKcK5-0000LS-GK
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Sep 2006 07:54:47 -0700
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

This is a multi-part message in MIME format.
--------------020708090601090907000208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch corrects the address for register HSCOEFF3.

Signed-off-by: Raphael Assenat <raph@8d.com>

--------------020708090601090907000208
Content-Type: text/plain;
 name="mbxfb-regs-fixhscoeff3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mbxfb-regs-fixhscoeff3.diff"

This patch corrects the address for register HSCOEFF3.

Signed-off-by: Raphael Assenat <raph@8d.com>

--- linux-2.6.18-rc2-mbx/drivers/video/mbx/regs.h	2006-09-01 16:10:58.000000000 -0400
+++ linux-2.6.18-rc2-8d/drivers/video/mbx/regs.h	2006-08-30 10:32:17.000000000 -0400
@@ -127,7 +127,7 @@
 #define HSCOEFF0	__REG_2700G(0x000021b4)
 #define HSCOEFF1	__REG_2700G(0x000021b8)
 #define HSCOEFF2	__REG_2700G(0x000021bc)
-#define HSCOEFF3	__REG_2700G(0x000021b0)
+#define HSCOEFF3	__REG_2700G(0x000021c0)
 #define HSCOEFF4	__REG_2700G(0x000021c4)
 #define HSCOEFF5	__REG_2700G(0x000021c8)
 #define HSCOEFF6	__REG_2700G(0x000021cc)

--------------020708090601090907000208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------020708090601090907000208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------020708090601090907000208--
