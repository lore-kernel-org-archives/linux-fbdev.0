From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 24 Jan 2012 10:09:04 +0000
Subject: Re: [PATCH] fbdev: sh_mipi_dsi: add extra settings method for platform
Message-Id: <201201241109.05518.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <874nvnhupd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nvnhupd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tuesday 24 January 2012 01:48:55 Kuninori Morimoto wrote:
> Hi Laurent
> Cc Magnus, Guennadi
> 
> Thank you for checking patch

You're welcome.

> > > +	void (*set_dcs)(int handle,
> > > +			int (*mipi_dcs)(int handle, u8 cmd),
> > > +			int (*mipi_dcs_param)(int handle, u8 cmd, u8 param));
> > 
> > I don't think this is a good idea. First of all, we should reduce the
> > number of board code callbacks to make transition to the device tree
> > easier. Then, passing two functions to board code to read and write any
> > device register without the driver having any knowledge about that is a
> > clear violation of the device model, and will result in problems sooner
> > or later.
> > 
> > What MIPI settings do platforms need to modify ? Can those settings be
> > expressed as data in the sh_mipi_dsi_info structure instead ?
> 
> Hmm... now I'm in dilemma.
> Actually this is v2 patch for mipi display.
> (v1 patch was dropped since merge window issue)
> 
> The v1 patch was data-table style for mipi display initialization.
> (if platform had init data-table, driver used it)
> 
> But someone reviewed it and teach me that it is not-good idea.
> So, I created this style in v2.
> 
> Now platform needs "backlight ON" and "memory write ON" command,
> but I could not find these command on include/video/mipi_display.h.
> So, I thought it is platform specific command.

Why does the platform need that ? Please correct me if I'm wrong, but it seems 
to me that what you're trying to do is configure and control the display 
panel. I don't think that's platform-specific, it should be panel-specific 
instead. It looks to me like the right solution would be to write a display 
panel driver, similar to what is done for the OMAP2+ platform 
(drivers/video/omap2/displays).

-- 
Regards,

Laurent Pinchart
