From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fb: clean the penguin's dirty feet
Date: Mon, 10 Nov 2008 10:52:58 +0100
Message-ID: <4918047A.5000902@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <clemens@ladisch.de>) id 1KzTjN-0008JM-I4
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Nov 2008 10:10:49 +0000
Received: from out5.smtp.messagingengine.com ([66.111.4.29])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KzTjK-00032r-Sh for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Nov 2008 10:10:49 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 8B0A31ACA38
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 10 Nov 2008 04:52:48 -0500 (EST)
Received: from [10.1.2.10] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DF85627776
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 10 Nov 2008 04:52:47 -0500 (EST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

When booting in a direct color mode, the penguin has dirty feet,
i.e., some pixels have the wrong color.  This is caused by
fb_set_logo_directpalette() which does not initialize the last 32
palette entries.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- linux-2.6.orig/drivers/video/fbmem.c
+++ linux-2.6/drivers/video/fbmem.c
@@ -232,7 +232,7 @@ static void fb_set_logo_directpalette(st
 	greenshift = info->var.green.offset;
 	blueshift = info->var.blue.offset;

-	for (i = 32; i < logo->clutsize; i++)
+	for (i = 32; i < 32 + logo->clutsize; i++)
 		palette[i] = i << redshift | i << greenshift | i << blueshift;
 }


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
