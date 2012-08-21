From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 21 Aug 2012 09:23:34 +0000
Subject: Re: [RFC 0/5] Generic panel framework
Message-Id: <3648908.jA5PYymWxV@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345164583-18924-1-git-send-email-laurent.pinchart@ideasonboard.com> <3937256.gcqPRVoNWN@avalon> <1345528197.15491.8.camel@lappyti>
In-Reply-To: <1345528197.15491.8.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, linux-media@vger.kernel.org, Bryan Wu <bryan.wu@canonical.com>, Richard Purdie <rpurdie@rpsys.net>, Marcus Lorentzon <marcus.lorentzon@linaro.org>, Sumit Semwal <sumit.semwal@ti.com>, Archit Taneja <archit@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>, Inki Dae <inki.dae@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Tomi,

On Tuesday 21 August 2012 08:49:57 Tomi Valkeinen wrote:
> On Tue, 2012-08-21 at 01:29 +0200, Laurent Pinchart wrote:
> > On Monday 20 August 2012 14:39:30 Tomi Valkeinen wrote:
> > > On Sat, 2012-08-18 at 03:16 +0200, Laurent Pinchart wrote:
> > > > Hi Tomi,
> > > > 
> > > > mipi-dbi-bus might not belong to include/video/panel/ though, as it
> > > > can be used for non-panel devices (at least in theory). The future
> > > > mipi-dsi-bus certainly will.
> > > 
> > > They are both display busses. So while they could be used for anything,
> > > I find it quite unlikely as there are much better alternatives for
> > > generic bus needs.
> > 
> > My point is that they could be used for display devices other than panels.
> > This is especially true for DSI, as there are DSI to HDMI converters.
> > Technically speaking that's also true for DBI, as DBI chips convert from
> > DBI to DPI, but we can group both the DBI-to-DPI chip and the panel in a
> > single panel object.
> 
> Ah, ok. I thought "panels" would include these buffer/converter chips.
> 
> I think we should have one driver for one indivisible hardware entity.
> So if you've got a panel module that contains DBI receiver, buffer
> memory and a DPI panel, let's just have one "DBI panel" driver for it.
> 
> If we get lots of different panel modules containing the same DBI RX IP,
> we could have the DBI IP part as a common library, but still have one
> panel driver per panel module.

Sounds good to me.

> But how do you see the case for separate converter/buffer chips? Are
> they part of the generic panel framework? I guess they kinda have to be.
> On one side they use the "panel" API control the bus they are connected
> to, and on the other they offer an API for the connected panel to use
> the bus they provide.

The DBI/DSI APIs will not be panel-specific (they won't contain any reference 
to "panel") I'm thus thinking of moving them from drivers/video/panel/ to 
drivers/video/.

Furthermore, a DSI-to-HDMI converter chip is not a panel, but needs to expose 
display-related operations in a way similar to panels. I was thus wondering if 
we shouldn't replace the panel structure with some kind of video entity 
structure that would expose operations similar to panels. We could then extend 
that structure with converter-specific operations later. The framework would 
become a bit more generic, while remaining display-specific.

> Did you just mean we should have a separate directory for them, while
> still part of the same framework, or...?

-- 
Regards,

Laurent Pinchart

