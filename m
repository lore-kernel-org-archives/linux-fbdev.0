From: Ben Dooks <ben-fbdev@fluff.org>
Subject: [patch 5/5] S3C2410: Fix driver MODULE_ALIAS()
Date: Tue, 20 May 2008 13:49:59 +0100
Message-ID: <20080520125030.720359122@fluff.org.uk>
References: <20080520124954.001898813@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JyRIo-0004TI-Nv for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 May 2008 05:50:50 -0700
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JyRIm-0006Hu-W4
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 May 2008 05:50:50 -0700
Content-Disposition: inline;
	filename=simtec/simtec-drivers-fb-s3c2410-modalias.patch
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Ben Dooks <ben-linux@fluff.org>, arnaud.patard@rtp-net.org

Add a correct MODULE_ALIAS() entry for this driver
to enable udev module loading.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-rc3-quilt1/drivers/video/s3c2410fb.c
===================================================================
--- linux-2.6.26-rc3-quilt1.orig/drivers/video/s3c2410fb.c	2008-05-20 10:56:00.000000000 +0100
+++ linux-2.6.26-rc3-quilt1/drivers/video/s3c2410fb.c	2008-05-20 10:56:01.000000000 +0100
@@ -1070,3 +1070,5 @@ MODULE_AUTHOR("Arnaud Patard <arnaud.pat
 	      "Ben Dooks <ben-linux@fluff.org>");
 MODULE_DESCRIPTION("Framebuffer driver for the s3c2410");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:s3c2410-lcd");
+MODULE_ALIAS("platform:s3c2412-lcd");

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
