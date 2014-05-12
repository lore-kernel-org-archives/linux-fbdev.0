From: Tony Lindgren <tony@atomide.com>
Date: Mon, 12 May 2014 14:39:34 +0000
Subject: Re: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and probably 3630
Message-Id: <20140512143934.GC31772@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-2-git-send-email-tony@atomide.com>
 <536C860E.1000501@ti.com> <20140509143703.GA17814@atomide.com>
 <5370B222.7050702@ti.com>
In-Reply-To: <5370B222.7050702@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140512 04:36]:
> On 09/05/14 17:37, Tony Lindgren wrote:
> > 
> > This is just the 3730-evm with the Sharp VGA panel mentioned in
> > this series.
> 
> Hmm, well, those both look fine. The fck is well below the maximum,
> which is somewhere around 170MHz-180MHz. The lck/pck ratio is higher
> with this patch, but that should affect the GFX overlay.
> 
> So you're just booting, and there are no applications that use the
> framebuffer? And there is no rotation or such configured?

Right. The rotation is set to 3 though.

Tony
