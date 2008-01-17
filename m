From: Andrey Kovalev <aka@pxe.ru>
Subject: gx1fb problems.
Date: Thu, 17 Jan 2008 16:29:45 +0400
Message-ID: <478F4A39.4070003@pxe.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFTsd-0005w6-UF for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 04:30:00 -0800
Received: from luba.management.ru ([64.246.50.53])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFTsc-0006eM-9Y
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 04:29:59 -0800
Received: from [87.226.216.246] (helo=[10.100.50.2])
	by luba.management.ru with esmtps (TLSv1:AES256-SHA:256) (Exim 4.68)
	(envelope-from <aka@pxe.ru>) id 1JFTsY-0002BH-7y
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 12:29:54 +0000
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

Hi all,

I have a problem with the gx1fb driver. My board is GX1 with CS5530. 
Award bios. Vanilla kernel 2.6.23.1. I use our own test program.

Here is the right image:

http://www.pxe.ru/ban/gx1fb/gx1fb01.JPG

When I move mouse cursor over the "line of corruption", top part of the 
image becomes corrupted (800x600-8bit):

http://www.pxe.ru/ban/gx1fb/gx1fb02.JPG

This is the biggest possible corruption:

http://www.pxe.ru/ban/gx1fb/gx1fb03.JPG

I'm pretty shure demo program doesn't touch top area of framebuffer when 
cursor is over the "line of corruption". And I can "restore" image by 
moving mouse over corrupted area. I.e. image restores when demo program 
writes data to damaged area of framebuffer and corrupted again when demo 
program writes data near the "line of corruption".

Here is the same problem in 16 bit color:

http://www.pxe.ru/ban/gx1fb/gx1fb04.JPG

The "line of corruption" in 16bit mode is higher (red arrow). And there 
is one more damage - look at the text in the line marked with green arrow.


And second problem. Timings seems not working. I tried to pass 
"mode=800x600-8@60" and "mode=800x600-8@75" while loading gx1fb and 
fbset report correct timings for this rates. But monitor always reports 
85Hz.

This board works right (without image corruption and monitor reports 
60Hz when I ask for 60Hz) with 2.4 series kernel and nsc framebuffer driver.

This board works right (without image corruption and monitor reports 
60Hz) with 2.6.23.1 kernel and VESA driver in svgalib.



Thanks for your help.

-- 
Andrey

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
