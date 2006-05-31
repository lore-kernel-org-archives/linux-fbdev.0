From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: How to use ISRAm as a frame buffer in Linux
Date: Wed, 31 May 2006 19:39:06 +0800
Message-ID: <447D805A.6080805@gmail.com>
References: <dbee5b5a0605300232r15a2c13dr4153bb39a2024411@mail.gmail.com>	 <447C3BAB.70003@gmail.com>	 <dbee5b5a0605302143l7b0b4d24kdf0d77685b7ad4d9@mail.gmail.com>	 <447D204A.60007@gmail.com> <dbee5b5a0605310240q3de9582cwccf9d5ee4a012a46@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlP2j-0001bj-8a
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 May 2006 04:39:17 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FlP2j-0000Hr-0H
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 May 2006 04:39:17 -0700
Received: by py-out-1112.google.com with SMTP id b29so688748pya
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 31 May 2006 04:39:13 -0700 (PDT)
In-Reply-To: <dbee5b5a0605310240q3de9582cwccf9d5ee4a012a46@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
To: Prakhar Vig <prakharv@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Prakhar Vig wrote:
> Hi Antonino,
> thanks for ur help.
>  
> As u have told I am using an application that reads a data from
> framebuffer by opening /dev/fb0. I am attaching the code for ur
> convineance, I would like to ask following questions:
>  
> 1) In this code I am using mmap to allocate memory to frame buffer which
> has one argument
> MAP_SHARED or MAP_PRIVATE.

If you use MAP_PRIVATE, it will create a map using copy-on-write which
is visible only to the process the requested the mmap.  You don't want
this, use MAP_PRIVATE.
 
> Could you please explain for what this meant
> for i.e whether it ie related to allocation in SDRAM or ISRAM.
> MAP_SHARED in SDRAM and MAP_PRIVATE in ISRAM is it so.
>  
> 2) If not, Could you please tell me how to allocate framebuffer to ISRAM
> as is faster to access from ISRAM than SDRAM.

I don't know. Is this memory visible to the CPU? If it is then it
is certainly mappable. If not, then you have to allocate a shadow
buffer using system RAM, then on intervals, transfer the contents of
the shadow buffer to and from this memory region using DMA.

>  
> 3) Also, tell me whether I need to use DMA to access data from ISRAM,
> will it improve the speed of accessing the data from ISRAM. Is it
> mandatory to use DMA if you want to make it work fast.

You cannot use DMA when your method of access is mmap. You can certainly
use DMA to transfer contents to a shadow buffer which is in turn mmapped.

Tony  


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
