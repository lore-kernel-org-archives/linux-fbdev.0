From: Manousaridis Angelos <amanous@inaccessnetworks.com>
Subject: Driver development
Date: Thu, 09 Oct 2003 12:55:00 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3F853074.3010604@inaccessnetworks.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A7XVg-0007lz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Oct 2003 02:55:04 -0700
Received: from node3.inaccessnetworks.com ([212.205.200.118] helo=inaccessnetworks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A7XVe-0001ZJ-MM
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Oct 2003 02:55:02 -0700
Received: from inaccessnetworks.com (firewall [212.205.200.117])
	by inaccessnetworks.com (8.12.1/8.12.1) with ESMTP id h999t0v1008576
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 9 Oct 2003 12:55:00 +0300
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hello all,

I have a custom video board for a strongARM embedded platform. Its 
purpose is to decode MPEG video streams and display the video on a TV 
screen.
This board uses the Teralogic 751 chip for graphics blending and 
display. The TL751 is connected to an external SDRAM, for framebuffer 
and video storage. It has 4 overlay planes: two for video, one for 
graphics and one for a hw cursor.

I want to write a driver for some applications that require access to 
the graphics plane. These applications will write bitmaps to the 
framebuffer memory of the TL751. I want to avoid using custom 
interfaces, so I thought that it would be a good idea to implement a 
frame buffer device for that purpose.

While looking at the framebuffer API though, I found a some stuff that 
are not applicable for my case.
All that beam tracking and monitor synchronization fields for instance. 
The chip I am using does all that handling because the output is fixed 
to either PAL or NTSC. I want to be able to set these two modes, but I 
don't need all the details (timings, margins etc).
Another issue is with the console stuff. I am not interested in having a 
framebuffer console. All I want is to give apps an API to the 
framebuffer memory. I see a lot of work has been done towards the 
direction of splitting the fb device stuff and the fb console stuff, but 
can I write a fb driver with no reference to fbcon?

Is it possible to implement such a framebuffer driver?
I want to look at some code to understand how the API works. From the 
drivers included in the kernel tree (drivers/video), which are closest 
to what I am trying to do?

thanks in advance,

Manousaridis Angelos



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
