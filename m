From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Subject: Default timings in vga16fb driver
Date: Tue, 23 Nov 2004 18:04:37 +0100
Message-ID: <41A36DA5.8090200@fujitsu-siemens.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWe5s-0003EA-VX
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 09:04:44 -0800
Received: from plim.fujitsu-siemens.com ([217.115.66.8])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CWe5r-0003c2-2k
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 09:04:44 -0800
Received: from trulli.pdb.fsc.net ([172.25.96.53])
	by plim.fujitsu-siemens.com (8.11.3/8.11.3) with ESMTP id iANH4dk17670
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Nov 2004 18:04:39 +0100
Received: from biker.psw.pdb.fsc.net (biker.pdb.fsc.net [172.25.253.106])
	by trulli.pdb.fsc.net (8.11.6/8.11.6) with ESMTP id iANH4cu02188
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Nov 2004 18:04:38 +0100
Received: from fujitsu-siemens.com (localhost [127.0.0.1])
	by biker.psw.pdb.fsc.net (Postfix) with ESMTP id 449F3BC85
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Nov 2004 18:04:38 +0100 (CET)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hello,

I am wondering about the standard mode timings for the 640x480@60 mode 
in vga16fb driver (vga16fb_defined):

	.pixclock	= 39721,
	.left_margin	= 48,
	.right_margin	= 16,
	.upper_margin	= 39,
	.lower_margin	= 8,
	.hsync_len 	= 96,
	.vsync_len	= 2,
	.vmode		= FB_VMODE_NONINTERLACED,

IMO this corresponds to a total screen height of 529 which is different 
from the value 525 which is normally used (eg in X Windows). What is the 
reason for this? Is it possible that the value for "upper_margin" should 
be 35 rather than 39?

I am asking because we have encountered a video device that obviously 
has problems displaying the standard mode of the vga16fb driver.

More detail:

Unless I'm  mistaken, the above translates into an XFree86 modeline
   ModeLine "640x480" 25.175 640 656 752 800 480 488 490 529

The standard XFree86 modeline for this mode, however, looks like this:
(same in drivers/video/modedb.c)
   ModeLine "640x480" 25.175 640 664 760 800 480 491 493 525

The description at http://www.epanorama.net/documents/pc/vga_timing.html.
would suggest:
   ModeLine "640x480" 25.175 640 656 752 800 480 490 492 525

I apologize if I'm overlooking something.

Best regards,
Martin

--
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
