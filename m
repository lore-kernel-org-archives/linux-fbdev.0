From: Ben Dooks <ben@fluff.org.uk>
Subject: [PATCH] s3c2410fb: fix un-initialised dev field
Date: Thu, 15 Feb 2007 22:49:23 +0000
Message-ID: <20070215224922.GA7156@fluff.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161622AbXBOWto@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openmoko-kernel@lists.openmoko.org, linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

The current driver is not setting the dev
field in the private data structure, which
can lead to an OOPS if the driver tries to
report an error.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--- linux-2.6.20/drivers/video/s3c2410fb.c	2007-02-04 18:44:54.000000000 +0000
+++ linux-2.6.20-fbfix1/drivers/video/s3c2410fb.c	2007-02-15 22:42:51.000000000 +0000
@@ -791,6 +791,8 @@ static int __init s3c2410fb_probe(struct
 
 	info = fbinfo->par;
 	info->fb = fbinfo;
+	info->dev = &pdev->dev;
+
 	platform_set_drvdata(pdev, fbinfo);
 
 	dprintk("devinit\n");
