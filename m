From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 23 Feb 2016 07:41:32 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdc: Use ARCH_RENESAS
Message-Id: <1523945.ItVeqRtDn1@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456106391-10353-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1456106391-10353-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Simon,

On Tuesday 23 February 2016 09:11:03 Simon Horman wrote:
> On Mon, Feb 22, 2016 at 03:05:58PM +0200, Laurent Pinchart wrote:
> > On Monday 22 February 2016 13:39:37 Geert Uytterhoeven wrote:
> >> On Mon, Feb 22, 2016 at 1:24 PM, Laurent Pinchart wrote:
> >>> On Monday 22 February 2016 10:59:51 Simon Horman wrote:
> >>>> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
> >>>> 
> >>>> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> >>>> ARCH_RENESAS the motivation for which being that RENESAS seems to be
> >>>> a more appropriate name than SHMOBILE for the majority of Renesas ARM
> >>>> based SoCs.
> >>>> 
> >>>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >>> 
> >>> Wouldn't it make sense to drop the driver instead ? We have a DRM
> >>> driver that replaces it.
> >> 
> >> Does the DRM driver work on all hardware supported by the fbdev driver?
> >> It's not only used on r8a7740/armadillo (through staging/board due to
> >> lack of DT support), but also on many SH boards.
> > 
> > It's supposed to be a replacement (lacking support for SYS panels though),
> > but has obviously not been tested on SH boards.
> 
> From my point of view it would be overreach to remove the driver as we
> aren't in a position to test the SH boards.

I'd be surprised if the driver still worked on those boards, but I like good 
surprises :-)

> We could stop using it on the Renesas ARM SoCs and in turn remove
> ARCH_SHMOBILE/ARCH_RENESAS. Am I right in thinking that would only
> effect the r8a7740/armadillo at this time?

That's correct.

-- 
Regards,

Laurent Pinchart

