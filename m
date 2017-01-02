From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Mon, 02 Jan 2017 14:22:28 +0000
Subject: Re: [PATCH 0/4] video: ARM CLCD: add support of an optional GPIO to enable panel
Message-Id: <20170102142228.GI14217@n2100.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161221032717.13154-1-vz@mleia.com>
 <CACRpkdZE6VgJA27+Wh=Gxd7yOXpLMyT7yCB2PYA36y0gvosHFQ@mail.gmail.com>
In-Reply-To: <CACRpkdZE6VgJA27+Wh=Gxd7yOXpLMyT7yCB2PYA36y0gvosHFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 30, 2016 at 09:23:59AM +0100, Linus Walleij wrote:
> On Wed, Dec 21, 2016 at 4:27 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> 
> > The changeset contains a number of cleanups, changed semantics of
> > init_panel() callback, which allows to simplify getting of panel
> > properties from panel device tree node, and a handling of optional
> > "enable-gpios" panel property, the latter is described in
> > display/panel/panel-dpi.txt device tree binding documentation, but
> > it has been unsupported by the ARM CLCD driver.
> >
> > Vladimir Zapolskiy (4):
> >   video: ARM CLCD: sort included headers out alphabetically
> >   video: ARM CLCD: use panel device node for panel initialization
> >   video: ARM CLCD: use panel device node for getting backlight and mode
> >   video: ARM CLCD: add support of an optional GPIO to enable panel
> 
> As you may have seen Tomi has stepped down as FBDEV maintainer and
> this subsystem is now orphaned.
> 
> I guess Andrew Morton merges patches for it in this case, he usually does.
> 
> But what we should actually do is create a new DRM driver for CLCD
> in drivers/gpu/drm/arm/clcd*
> 
> It's maybe not a small undertaking :(
> 
> But in case you're interested in the job, I will pitch in and test the result
> on all ARM reference designs plus Nomadik.

A DRM driver for it would probably be a good idea, but dealing with all
the weird and wonderful connection arrangements may not be that easy...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
