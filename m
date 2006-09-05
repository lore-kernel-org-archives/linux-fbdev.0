From: Raphael Assenat <raph@8d.com>
Subject: [PATCH 5/5] mbxfb: Document the new ioctl
Date: Tue, 05 Sep 2006 11:02:46 -0400
Message-ID: <44FD9196.7050505@8d.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070809000302070705070106"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GKcQk-0005nP-VU for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Sep 2006 08:01:39 -0700
Received: from roc.holo.8d.com ([64.254.227.115])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GKcQn-0002vn-1X
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Sep 2006 08:01:41 -0700
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
--------------070809000302070705070106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds a new ioctl range for the mbxfb driver.

Signed-off-by: Raphael Assenat <raph@8d.com>


--------------070809000302070705070106
Content-Type: text/plain;
 name="mbxfb-doc-ioctl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mbxfb-doc-ioctl.diff"

This patch adds a new ioctl range for the mbxfb driver.

Signed-off-by: Raphael Assenat <raph@8d.com>

--- linux-2.6.18-rc2-mbx/Documentation/ioctl-number.txt	2006-09-01 16:11:14.000000000 -0400
+++ linux-2.6.18-rc2-8d2/Documentation/ioctl-number.txt	2006-09-05 10:50:59.000000000 -0400
@@ -191,3 +191,5 @@
 					<mailto:aherrman@de.ibm.com>
 0xF3	00-3F	video/sisfb.h		sisfb (in development)
 					<mailto:thomas@winischhofer.net>
+0xF4	00-1F	video/mbxfb.h		mbxfb
+					<mailto:raph@8d.com>

--------------070809000302070705070106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------070809000302070705070106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------070809000302070705070106--
