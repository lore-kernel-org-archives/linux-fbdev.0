From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 22 Feb 2016 13:05:58 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdc: Use ARCH_RENESAS
Message-Id: <8182899.7gHAv4mVJE@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456106391-10353-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1456106391-10353-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Geert,

On Monday 22 February 2016 13:39:37 Geert Uytterhoeven wrote:
> On Mon, Feb 22, 2016 at 1:24 PM, Laurent Pinchart wrote:
> > On Monday 22 February 2016 10:59:51 Simon Horman wrote:
> >> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
> >> 
> >> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> >> ARCH_RENESAS the motivation for which being that RENESAS seems to be a
> >> more appropriate name than SHMOBILE for the majority of Renesas ARM based
> >> SoCs.
> >> 
> >> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > Wouldn't it make sense to drop the driver instead ? We have a DRM driver
> > that replaces it.
> 
> Does the DRM driver work on all hardware supported by the fbdev driver?
> It's not only used on r8a7740/armadillo (through staging/board due to lack
> of DT support), but also on many SH boards.

It's supposed to be a replacement (lacking support for SYS panels though), but 
has obviously not been tested on SH boards.

-- 
Regards,

Laurent Pinchart

