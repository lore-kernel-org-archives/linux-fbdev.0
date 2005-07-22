From: "Buttchereit, Axel (XL)" <xl@xlsigned.net>
Subject: Re: intelfb does not work with i915
Date: Fri, 22 Jul 2005 05:01:40 +0200
Message-ID: <42E06194.9030100@xlsigned.net>
References: <6d86e88105072010252790b42d@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DvnnM-000455-6X
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Jul 2005 20:01:52 -0700
Received: from www20.your-server.de ([213.133.104.20] ident=mail)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1DvnnK-0005nZ-M4
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 21 Jul 2005 20:01:52 -0700
Received: from [84.59.141.93] (helo=[192.168.242.2])
	by www20.your-server.de with esmtpa (Exim 4.50)
	id 1DvnnB-0006aP-A6
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Jul 2005 05:01:41 +0200
In-Reply-To: <6d86e88105072010252790b42d@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

this weekend I'm going to switch the kernel version on the computer
that I used to develop the patch from 2.6.10 (+ original patch)
to 2.6.12(-gentoo-r4) and give (you) a feedback.

ByTheWay:
  16 Bits per Pixel does not work on my computer, too.
  Have you tried a 32 Bit mode, e. g. 1024x768-32@70?
  (This should be the default mode.)

Cheers,
Axel


Dave Kavanagh wrote:
> I have been having no luck getting the intelfb driver working
> with an i915 chipset. I've been searching and reading message
> boards and mail lists for days and haven't found anything.
> It seems that the driver is not setting the proper video timings.
> 
> I have tried using the vesafb driver and my hardware works fine.
> 
> If I try to use the intelfb driver my monitor either complains
> and shuts off or I get text and graphics that is horizontally
> squiggly (if that makes sense).
> 
> I tried initializing the driver in several modes with parameters
> such as:
> 
>       video=intelfb
>       video=intelfb:640x480-16@60
> 
> 
> fbset -i reports the following:
> 
> mode "1024x768-70"
>     # D: 75.002 MHz, H: 56.477 kHz, V: 70.071 Hz
>     geometry 1024 768 1024 768 32
>     timings 13333 144 24 29 3 136 6
>     accel true
>     rgba 8/16,8/8,8/0,0/0
> endmode
> 
> Frame buffer device information:
>     Name        : Intel(R) 915G
>     Address     : 0xd0000000
>     Size        : 8253440
>     Type        : PACKED PIXELS
>     Visual      : TRUECOLOR
>     XPanStep    : 8
>     YPanStep    : 1
>     YWrapStep   : 0
>     LineLength  : 4096
>     MMIO Address: 0xcfd80000
>     MMIO Size   : 524288
>     Accelerator : Unknown (42)
> 
> 
> I am using kernel 2.6.12. Any help or ideas would be appreciated.
> 
> Thanks,
> Dave Kavanagh
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id492&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
