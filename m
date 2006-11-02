From: akpm@osdl.org
Subject: [patch 16/25] mbxfb: Document the new ioctl
Date: Wed, 01 Nov 2006 21:50:28 -0800
Message-ID: <200611020550.kA25oSxX002336@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfVUV-0007gb-VZ for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:51:52 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfVUV-0007bp-HH
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:51:51 -0800
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

This patch adds a new ioctl range for the mbxfb driver.

Signed-off-by: Raphael Assenat <raph@8d.com>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 Documentation/ioctl-number.txt |    2 ++
 1 file changed, 2 insertions(+)

diff -puN Documentation/ioctl-number.txt~mbxfb-document-the-new-ioctl Documentation/ioctl-number.txt
--- a/Documentation/ioctl-number.txt~mbxfb-document-the-new-ioctl
+++ a/Documentation/ioctl-number.txt
@@ -191,3 +191,5 @@ Code	Seq#	Include File		Comments
 					<mailto:aherrman@de.ibm.com>
 0xF3	00-3F	video/sisfb.h		sisfb (in development)
 					<mailto:thomas@winischhofer.net>
+0xF4	00-1F	video/mbxfb.h		mbxfb
+					<mailto:raph@8d.com>
_

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
