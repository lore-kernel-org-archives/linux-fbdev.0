From: Felipe W Damasio <felipewd@terra.com.br>
Subject: [PATCH] memory leak in imsttfb video driver
Date: Mon, 06 Oct 2003 18:16:49 -0300
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <3F81DBC1.4010003@terra.com.br>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090906050606070600030002"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
To: lethal@chaoticdreams.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090906050606070600030002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Paul,

	Patch against 2.6.0-test6.

	- Fixes 2 leaks in imsttfb driver: Frees the info struct imstt_par 
and releases the mem region if the device type is unknown.

	Found by smatch.

	Please consider applying,

	Thanks.

Felipe

--------------090906050606070600030002
Content-Type: text/plain;
 name="imsttfb-leak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="imsttfb-leak.patch"

--- linux-2.6.0-test6/drivers/video/imsttfb.c.orig	2003-10-06 18:03:53.000000000 -0300
+++ linux-2.6.0-test6/drivers/video/imsttfb.c	2003-10-06 18:12:30.000000000 -0300
@@ -1495,6 +1495,8 @@
 		default:
 			printk(KERN_INFO "imsttfb: Device 0x%x unknown, "
 					 "contact maintainer.\n", pdev->device);
+			kfree(info);
+			release_mem_region(addr, size);
 			return -ENODEV;
 	}
 

--------------090906050606070600030002--
