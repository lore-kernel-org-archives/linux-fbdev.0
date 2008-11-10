From: jkimble@one.net
Subject: Epson S1D13xxxfb.c on 2.6.25 kernel: wierd seg
	faults...
Date: Mon, 10 Nov 2008 17:14:58 -0500 (EST)
Message-ID: <50026.137.237.242.42.1226355298.squirrel@webmail.nuvox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jkimble@one.net>) id 1KzfOU-0001JR-1Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Nov 2008 22:38:02 +0000
Received: from smtp-out2.atlngahp.sys.nuvox.net ([70.43.63.19]
	helo=smtp02.atlngahp.sys.nuvox.net)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1KzfOQ-0005FD-UA
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Nov 2008 22:38:02 +0000
Received: from webmail.nuvox.net (webmail.nuvox.net [64.89.70.59])
	by smtp02.atlngahp.sys.nuvox.net (8.13.1/8.13.1) with ESMTP id
	mAAMEwxm017790 for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 10 Nov 2008 17:14:58 -0500
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


Maybe this is a dumb question but bear with me. I'm running an Epson
S1D13A04 video chip with a Coldfire processor (5484) running the latest
kernel for this chip from Freescale (2.6.25). I had this device working
with the older 2.6.10 kernel and I've been working to port the driver that
came with the 2.6.25 kernel to work with this particular chip (it's a
device "family" driver).

Got things going fairly well, I thought, to the point that I even get a
little Tux logo up when the driver loads. However when I go to use the
frame buffer device, though I can open it and read the data from the info
structure (size, bpp, etc..) any attempt to write the fb0 device causes a
seg fault. I've been looking at this for hours and I cannot get why.

I'm configuring the RAM in exactly the same way I was before (went from
colilo to U-Boot). I'm mapping the CS associated with this device to the
same memory space I was on the 2.6.10 kernel (0x4400 0000). I tried moving
it and it made no difference. I don't get it... Is this a 2.6.25 thing I'm
missing?

Any help/suggestions GREATLY appreciated.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
