From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: fb_defio with a coherent DMA framebuffer
Date: Fri, 26 Dec 2008 04:43:05 +0800
Message-ID: <45a44e480812251243w5f5ece16s9c480fa3499dac4a@mail.gmail.com>
References: <AclcUSrh/ueYJd8VRzSsXAp4dPCmtQ==>
	<8CF9D79FB605004381900048F600598803352F5D72@mucse405.eu.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LFx30-0004dY-HN
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 25 Dec 2008 20:43:10 +0000
Received: from mail-ew0-f21.google.com ([209.85.219.21])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LFx2w-0008Vg-79 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 25 Dec 2008 20:43:10 +0000
Received: by ewy14 with SMTP id 14so3992570ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 25 Dec 2008 12:43:05 -0800 (PST)
In-Reply-To: <8CF9D79FB605004381900048F600598803352F5D72@mucse405.eu.infineon.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Nick.Thompson@infineon.com
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

On Fri, Dec 12, 2008 at 8:00 PM,  <Nick.Thompson@infineon.com> wrote:
> Hi,
>
> We are attempting to get frame buffer functionality working on an LCD device with a memory mapped register interface. The LCD video memory is not directly accessible. We have a dedicated video DMA system to move data from an fb_mem frame buffer to the LCD device. The frame buffer allocated by our driver is in coherent DMA (dma_alloc_coherent) memory and not allocated by vmalloc.


Hi Nick,

Apologies for the delay in responding, still catching up on mail.

>
> To keep bus load to a minimum, we decided to use fb_defio to collate the frame buffer dma copies, but it seems that

For the first part, great, I was hoping someone would start to use it
for dma coalescing. btw, my english is poor, but I assume collate
above means the same thing as coalesce.

> this doesn't work. When an application mmaps the fb, this appears to work, but the application only ever see the zero page mapped in and so writing doesn't occur, defio's mkwrite doesn't get called, etc, etc
>
> Is fb_defio supposed to work with DMA memory? I saw a thread from over a year ago about defio's nopage (we're still using 2.6.24) being written to use driver supplied flags to specify what memory allocation type nopage is dealing with. Was this not implemented or not deemed necessary? I would be very interested to hear any suggestions about how we should tackle making this work.

The current defio code does not work with DMA memory. This has been
recently rectified by Magnus Damm. This effort is still in progress in
some areas but I think it is usable. As for using 2.6.24, my response
to that would be: Why? We're on 2.6.28 and defio has seen a reasonable
amount of change since 24. :-)

Thanks,
jaya

------------------------------------------------------------------------------
