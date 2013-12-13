From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 13 Dec 2013 03:27:12 +0000
Subject: Re: [PATCH 13/26] ARM: omap3.dtsi: add omapdss information
Message-Id: <1933495.zHe4JMYZyB@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <52A9760A.3000801@ti.com> <20131212215913.GB29072@muru.com>
In-Reply-To: <20131212215913.GB29072@muru.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>

Hi Tony,

On Thursday 12 December 2013 21:59:13 Tony Lindgren wrote:
> On Thu, Dec 12, 2013 at 10:38:34AM +0200, Tomi Valkeinen wrote:
> > On 2013-12-12 01:44, Laurent Pinchart wrote:
> > 
> > So, are they independent? I don't know =). I think they lean on the
> > independent side. dss_core is always needed for the submodules to work,
> > but for example DSI could be used without DISPC, using system DMA to
> > transfer data from memory to DSI. Not a very useful thing to do, but
> > still, there are dedicated DMA channels for that.
> 
> If they have separate hwmod entries, they should be considered separate
> independent devices for sure.
> 
> To summarize, here are few reasons why they need to be treated as
> separate devices:

Are you talking generally here, or about the DSS modules in particular ?

> 1. The modules maybe clocked/powered/idled separately and can have their
>    own idle configuration so they can do the hardware based idling
>    separately.

I don't think this applies to the DSS modules.

> 2. Doing a readback after a write to one module will not flush the write
>    to the other modules on the (bus depending on the SoC version AFAIK).
>    That can lead to nasty bugs caused by the ordering.

How does separate devices solve this ?

> 3. If the devices are described in a different way in the .dts files
>    from the hwmod data, we will not have 1-to-1 mapping and will never
>    be able to replace ti,hwmods with just the compatible string.

-- 
Regards,

Laurent Pinchart

