From: <Nick.Thompson@infineon.com>
Subject: fb_defio with a coherent DMA framebuffer
Date: Fri, 12 Dec 2008 13:00:03 +0100
Message-ID: <8CF9D79FB605004381900048F600598803352F5D72@mucse405.eu.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Nick.Thompson@infineon.com>) id 1LB79M-0008Hg-VW
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Dec 2008 12:29:44 +0000
Received: from smtp1.infineon.com ([217.10.60.22])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.69) id 1LB79G-0005RY-4B
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Dec 2008 12:29:44 +0000
Content-Language: en-US
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

Hi,

We are attempting to get frame buffer functionality working on an LCD device with a memory mapped register interface. The LCD video memory is not directly accessible. We have a dedicated video DMA system to move data from an fb_mem frame buffer to the LCD device. The frame buffer allocated by our driver is in coherent DMA (dma_alloc_coherent) memory and not allocated by vmalloc.

To keep bus load to a minimum, we decided to use fb_defio to collate the frame buffer dma copies, but it seems that this doesn't work. When an application mmaps the fb, this appears to work, but the application only ever see the zero page mapped in and so writing doesn't occur, defio's mkwrite doesn't get called, etc, etc

Is fb_defio supposed to work with DMA memory? I saw a thread from over a year ago about defio's nopage (we're still using 2.6.24) being written to use driver supplied flags to specify what memory allocation type nopage is dealing with. Was this not implemented or not deemed necessary? I would be very interested to hear any suggestions about how we should tackle making this work.

Many thanks,
Nick.

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
