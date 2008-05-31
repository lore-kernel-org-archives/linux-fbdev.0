From: Sven Luther <sven@powerlinux.fr>
Subject: Re: [directfb-dev] [directfb-users] DirectFB
	without FBDev
Date: Sat, 31 May 2008 08:21:27 +0200
Message-ID: <20080531062127.GA5425@powerlinux.fr>
References: <483D7344.6030503@directfb.org>
	<Pine.LNX.4.64.0805281901300.15083@anakin>
	<483D9453.1080700@directfb.org> <483D9C30.8010301@acdstar.com>
	<483D9F4E.4000707@directfb.org>
	<20080529165452.GA7708@powerlinux.fr>
	<4840EB76.6040506@directfb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2KTI-0006Vg-9I for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 23:21:44 -0700
Received: from archon.plz.fr ([194.50.78.210])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K2KTG-0001lp-Lr
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 23:21:44 -0700
Content-Disposition: inline
In-Reply-To: <4840EB76.6040506@directfb.org>
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
To: Denis Oliver Kropp <dok@directfb.org>
Cc: directfb-users@directfb.org, "Brian G. Rhodes" <bgr@acdstar.com>, linux-fbdev-devel@lists.sourceforge.net, directfb-dev@directfb.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Sat, May 31, 2008 at 08:08:54AM +0200, Denis Oliver Kropp wrote:

<skipped>

> It depends on what you need in kernel space. Have a look at the SH7722 
> kernel
> module. I'm not sure if the benefits of DRI would be that big to compensate 
> for
> the overhead or limitations. E.g. this driver manages a self running DMA 
> queue,
> where in the ideal case you never have to do any system call, but just 
> append data
> to the DMA buffer from user space.
> 
> http://git.directfb.org/?p=core/DirectFB.git;a=blob;f=gfxdrivers/sh7722/kernel-module/sh7722gfx.c
> 
> This driver handles different interrupt sources, provides DMA for the 
> accelerator
> as mentioned above and implements a minor portion of JPEG encoding and 
> decoding with
> the rest done in user space.

Yes, but given that the kernel already has 2 "graphical" subsystems, fbdev
an drm, the reticence of Linus to merge in the fbdev back then, and the
failure of the ggi/kgi project, i wonder if it makes sense to try to add
yet another system.

In my opinion, what would make sense would be to disucss with the fbdev
and drm/xorg folk, as well as the vendors out there, to obtain a single
unified "graphical" driver, on which fbdev and xorg/drm functionality
can be built, and which allows us to take advantage of the various
functionality of the graphic chips, and which is designed, not only for
high end desktop/workstation graphic cards, but also for embedded
chipsets.

Friendly,

Sven Luther

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
