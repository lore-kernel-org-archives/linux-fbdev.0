From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RFC 2.6.26-rc3 2/7] pxafb: add shared
 framebuffer interface
Date: Sat, 7 Jun 2008 10:38:02 +0200
Message-ID: <20080607103802.9e3e5a5c.krzysztof.h1@poczta.fm>
References: <1212814166-10313-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212814166-10313-3-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4ttf-0005xO-9q for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Jun 2008 01:35:35 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K4tte-0000MJ-Rr
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Jun 2008 01:35:35 -0700
In-Reply-To: <1212814166-10313-3-git-send-email-jayakumar.lkml@gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sat,  7 Jun 2008 00:49:21 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> These changes are to make it possible for a secondary driver to share the
> pxafb framebuffer. The changes include:
> - adding clkdev entry in pxafb_mach_info so that a driver can pass in the
>   correct struct device owner for the LCDCLK.
> - adding custom_xfer_div entry so that a driver can have custom sized
>   transfers. For example, the metronome controller uses 16 bit AMLCD
>   transfers but actually has 3 bit pixels in 8 bit containers.
> - adding extra_video_mem entry so that a driver can tell pxafb of its
>   additional needs.
> - adding share_video_mem/unshare_video_mem callbacks to notify the secondary
>   driver of the framebuffer address, to allow refcounting, and to cleanup on
>   completion.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> ---
>  arch/arm/mach-pxa/devices.c      |    2 +
>  drivers/video/pxafb.c            |   45 ++++++++++++++++++++++++++++++++-----
>  include/asm-arm/arch-pxa/pxafb.h |    9 +++++++
>  3 files changed, 50 insertions(+), 6 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---------------------------------------------------------------
Sciagnij obowiazkowy katalog kibica!
Kliknij >> http://link.interia.pl/f1e27


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
