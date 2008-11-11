From: James Kimble <jkimble@one.net>
Subject: Seg fault on any FB write (Epson S1D13A04 on
	Coldfire running 2.6.25)
Date: Mon, 10 Nov 2008 20:54:11 -0500
Message-ID: <4918E5C3.2090108@one.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jkimble@one.net>) id 1KziSY-0006qL-Ad
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 01:54:26 +0000
Received: from smtp-out3.atlngahp.sys.nuvox.net ([70.43.63.20]
	helo=smtp03.atlngahp.sys.nuvox.net)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1KziSW-00078X-Lf
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Nov 2008 01:54:26 +0000
Received: from localhost.localdomain (cpe-69-133-20-201.cinci.res.rr.com
	[69.133.20.201]) (authenticated bits=0)
	by smtp03.atlngahp.sys.nuvox.net (8.13.1/8.13.1) with ESMTP id
	mAB1sHAi025891
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 10 Nov 2008 20:54:18 -0500
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


I've been working on porting the s1d13xxxfb driver from the latest 
kernel from Freescale for Coldfire to work with the S1D13A04 chip. I was 
able to get things working to the point that I do get a little TUX logo 
up on the screen at boot up. Seemed like a good start but none of my 
user space applications will work. I can open the /dev/fb0 device and 
the data in the info structure is correct but if I try to write to any 
register or area in the frame buffer (or write to the device at all) I 
get a seg fault.

I had an earlier driver working with the 2.6.10 kernel with the same 
hardware. The same application space program should work ( I would 
think...) but I get the seg fault on the first write to fb0. I tried a 
different memory location (ox4400 0000 to 0x7400 0000) for the CS 
associated with the video  chip, no  difference. Permissions for 
/dev/fb0 are "rw". No other process using fb0. This is really weird.

Any help or suggestions MUCH appreciated.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
