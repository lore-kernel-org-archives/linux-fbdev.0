From: Ben Dooks <ben@fluff.org.uk>
Subject: [PATCH] s3c2410fb - initialise device_driver .owner
Date: Mon, 10 Oct 2005 02:05:22 +0100
Message-ID: <20051010010522.GA28414@home.fluff.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOm6X-0001ad-2O
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Oct 2005 18:05:25 -0700
Received: from host-84-9-200-7.bulldogdsl.com ([84.9.200.7] helo=aeryn.fluff.org.uk)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EOm6a-00018k-Ns
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Oct 2005 18:05:30 -0700
Received: from ben by aeryn.fluff.org.uk with local (Exim 3.36 #1 (Debian))
	id 1EOm6U-0007Ob-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 10 Oct 2005 02:05:22 +0100
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Initialise the .owner field, so that if the
driver is built as a module, the system has
a link to the owner

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="s3c2410-fb-add-driver-owner.patch"

diff -urN -X ../dontdiff linux-2.6.13-simtec3a/drivers/video/s3c2410fb.c linux-2.6.13-simtec3b/drivers/video/s3c2410fb.c
--- linux-2.6.13-simtec3a/drivers/video/s3c2410fb.c	2005-09-26 18:03:17.000000000 +0100
+++ linux-2.6.13-simtec3b/drivers/video/s3c2410fb.c	2005-10-10 01:46:21.000000000 +0100
@@ -889,6 +889,7 @@
 
 static struct device_driver s3c2410fb_driver = {
 	.name		= "s3c2410-lcd",
+	.owner		= THIS_MODULE,
 	.bus		= &platform_bus_type,
 	.probe		= s3c2410fb_probe,
 	.suspend	= s3c2410fb_suspend,

--huq684BweRXVnRxX--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
