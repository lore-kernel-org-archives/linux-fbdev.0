From: =?iso-8859-1?q?Suresh=20Chandra=20Mannava?= <hardsuresh@yahoo.co.in>
Subject: vga framebuffer for new architecture
Date: Mon, 14 Jun 2004 13:31:18 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040614123118.5378.qmail@web8201.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BZqxH-0007XH-Si
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Jun 2004 05:52:51 -0700
Received: from web8201.mail.in.yahoo.com ([203.199.70.114])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BZqxG-0005N5-B2
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Jun 2004 05:52:51 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: geert@linux-m68k.org

Dear ALL,
		We have struck with the following problem. We will
make a summary of it. Please help us in this regard.
We are working with a 2.6 MHZ(mega hz) FPGA processor.
We have successfully ported linux onto the system.Now
we are porting generic frame buffer (vga16fb) onto the
processor. We have ATIRAGE XL graphics card on the pci
slot. Please help us for the following queries.

	1) Is it possible to make the generic VGA16
FrameBuffer  work on a such a slow 2.6MHZ(Mega HZ)
processor?
	2) Are there any Hardware dependencies specific to
new platform for VGA16 Generic Frame buffer?
	3)What is the function of visual_init in
char/console.c?
	4)whether the loop inside take_over_console which
executes 64 times is really needed?
(register_framebuffer passes a value of 63 to
last_console variable). In intel platform we found
that it is ok to execute the loop only once.
	 We found that in our case the loop is executing only
once even though the loop count is 64.It seems to be
hanging somewhere near fbcon_init in video/fbcon.c
called from visual_init.

we request your help in this regard.

Regards,
Suresh

________________________________________________________________________
Yahoo! India Matrimony: Find your partner online. http://yahoo.shaadi.com/india-matrimony/


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
