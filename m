From: Denis Oliver Kropp <dok@directfb.org>
Subject: Re: [directfb-dev] [directfb-users] DirectFB
 without FBDev
Date: Sat, 31 May 2008 08:29:52 +0200
Message-ID: <4840F060.7090500@directfb.org>
References: <483D7344.6030503@directfb.org>
	<Pine.LNX.4.64.0805281901300.15083@anakin>
	<483D9453.1080700@directfb.org> <483D9C30.8010301@acdstar.com>
	<483D9F4E.4000707@directfb.org>
	<20080529165452.GA7708@powerlinux.fr>
	<4840EB76.6040506@directfb.org>
	<20080531062127.GA5425@powerlinux.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2KbH-0007Hp-Hf for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 23:29:59 -0700
Received: from directfb.org ([212.227.87.76] helo=www.directfb.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K2KbG-0003qJ-3y
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 23:29:59 -0700
In-Reply-To: <20080531062127.GA5425@powerlinux.fr>
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
To: Sven Luther <sven@powerlinux.fr>
Cc: directfb-users@directfb.org, "Brian G. Rhodes" <bgr@acdstar.com>, linux-fbdev-devel@lists.sourceforge.net, directfb-dev@directfb.org, Geert Uytterhoeven <geert@linux-m68k.org>

Sven Luther wrote:
> On Sat, May 31, 2008 at 08:08:54AM +0200, Denis Oliver Kropp wrote:
> 
> <skipped>
> 
>> It depends on what you need in kernel space. Have a look at the SH7722 
>> kernel
>> module. I'm not sure if the benefits of DRI would be that big to compensate 
>> for
>> the overhead or limitations. E.g. this driver manages a self running DMA 
>> queue,
>> where in the ideal case you never have to do any system call, but just 
>> append data
>> to the DMA buffer from user space.
>>
>> http://git.directfb.org/?p=core/DirectFB.git;a=blob;f=gfxdrivers/sh7722/kernel-module/sh7722gfx.c
>>
>> This driver handles different interrupt sources, provides DMA for the 
>> accelerator
>> as mentioned above and implements a minor portion of JPEG encoding and 
>> decoding with
>> the rest done in user space.
> 
> Yes, but given that the kernel already has 2 "graphical" subsystems, fbdev
> an drm, the reticence of Linus to merge in the fbdev back then, and the
> failure of the ggi/kgi project, i wonder if it makes sense to try to add
> yet another system.

I wouldn't try to add another system either, but write small, specialized and
optimized kernel modules suited best for the way the hardware works to take as
most advantage as possible. The example shows that 600 lines of hardware plus
200 lines of Linux code suffice in the SH7722 case.

> In my opinion, what would make sense would be to disucss with the fbdev
> and drm/xorg folk, as well as the vendors out there, to obtain a single
> unified "graphical" driver, on which fbdev and xorg/drm functionality
> can be built, and which allows us to take advantage of the various
> functionality of the graphic chips, and which is designed, not only for
> high end desktop/workstation graphic cards, but also for embedded
> chipsets.

A single unified solution would be nice, but it's always a trade off. For
embedded chipsets there's a unified solution in user space as well as for
desktops, while the former can be used for desktops with limitations and
the latter can be used for embedded with overhead.

-- 
Best regards,
   Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
