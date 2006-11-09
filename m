From: vwool@ru.mvista.com (Vitaly Wool)
Subject: [PATCH] pnx4008:fix NULL dereference in rgbfb
Date: Thu, 9 Nov 2006 19:42:44 +0300
Message-ID: <20061109164244.GB13505@ru.mvista.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GiD0D-0005yM-SV for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 09 Nov 2006 08:43:46 -0800
Received: from [85.21.88.2] (helo=localhost.localdomain)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GiD04-0003w8-DM
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 09 Nov 2006 08:43:42 -0800
Content-Disposition: inline
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

Hello folks,

the patch inlined fixes possible NULL dereference in pnxrgbfb.

 drivers/video/pnx4008/pnxrgbfb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>

Index: linux-2.6.18/drivers/video/pnx4008/pnxrgbfb.c
===================================================================
--- linux-2.6.18.orig/drivers/video/pnx4008/pnxrgbfb.c
+++ linux-2.6.18/drivers/video/pnx4008/pnxrgbfb.c
@@ -154,7 +154,8 @@ static int __devinit rgbfb_probe(struct 
 			goto err1;
 	}
 
-	if (!fb_get_options("pnxrgbfb", &option) && !strcmp(option, "nocursor"))
+	if (!fb_get_options("pnxrgbfb", &option) && option &&
+			!strcmp(option, "nocursor"))
 		rgbfb_ops.fb_cursor = no_cursor;
 
 	info->node = -1;

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
