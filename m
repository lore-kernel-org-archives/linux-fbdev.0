From: Ben Dooks <ben-fbdev@fluff.org>
Subject: [patch 3/5] S3C2410: Add error print if we
	cannot add attribute
Date: Tue, 20 May 2008 13:49:57 +0100
Message-ID: <20080520125030.375895346@fluff.org.uk>
References: <20080520124954.001898813@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JyRIn-0004T7-VI for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 May 2008 05:50:50 -0700
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JyRIm-0006Hr-Vr
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 May 2008 05:50:49 -0700
Content-Disposition: inline;
	filename=simtec/simtec-drivers-fb-s3c2410-warningfix.patch
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

Fix the following warning by checking the result of
device_create_file and printing an error but not removing
the device (loss of debug registers is not fatal).

drivers/video/s3c2410fb.c:905: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-rc3-quilt1/drivers/video/s3c2410fb.c
===================================================================
--- linux-2.6.26-rc3-quilt1.orig/drivers/video/s3c2410fb.c	2008-05-19 23:38:20.000000000 +0100
+++ linux-2.6.26-rc3-quilt1/drivers/video/s3c2410fb.c	2008-05-19 23:40:51.000000000 +0100
@@ -972,7 +972,10 @@ static int __init s3c24xxfb_probe(struct
 	}
 
 	/* create device files */
-	device_create_file(&pdev->dev, &dev_attr_debug);
+	ret = device_create_file(&pdev->dev, &dev_attr_debug);
+	if (ret) {
+		printk(KERN_ERR "failed to add debug attribute\n");
+	}
 
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
 		fbinfo->node, fbinfo->fix.id);

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
