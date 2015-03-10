From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 10 Mar 2015 15:26:22 +0000
Subject: Re: [PATCH] video: treat signal like timeout as failure
Message-Id: <20150310152622.GN8656@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421731430-13207-1-git-send-email-der.herr@hofr.at>
 <54FEE70D.3010307@ti.com> <20150310125116.GA26020@opentech.at>
 <20150310141511.GL8656@n2100.arm.linux.org.uk>
 <20150310143928.GA19501@opentech.at>
 <20150310144640.GM8656@n2100.arm.linux.org.uk>
 <54FF05FC.5030704@ti.com>
In-Reply-To: <54FF05FC.5030704@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Mar 10, 2015 at 04:55:56PM +0200, Tomi Valkeinen wrote:
> On 10/03/15 16:46, Russell King - ARM Linux wrote:
> 
> > In which case, let me propose that the exynos fbdev driver needs to be
> > moved to drivers/staging, and stay there until this stuff gets fixed.
> > drivers/staging is supposed to be for stuff which isn't up to the mark,
> > and which is potentially unstable.  And that's what this driver exactly
> > is.
> 
> There is drivers/gpu/drm/exynos/ which is getting a lot of updates. So...
> 
> I'd propose removing the exynos fbdev driver if the exynos drm driver
> offers the same functionality. I don't know if that's the case. Does the
> drm driver support all the devices the fbdev supports?
> 
> Also, I'm not sure if and how we can remove drivers. If exynos fbdev
> driver is dropped, that would perhaps break boards that have exynos
> fbdev in their .dts file. And if the drm driver doesn't offer the exact
> same /dev/fbX interface, it would break the userspace.
> 
> So I don't know if that's possible. But that's what I'd like to do,
> eventually, for all the fbdev drivers. Implement drm driver, remove the
> fbdev one.

That's why I suggested moving it to drivers/staging - it's a hint that
the driver needs a serious amount of work, and when built as a module,
it also provides users with the hint that the module they're loading is
of questionable quality (which is definitely the case here.)

Others have done that kind of thing before - we've had drivers which
have fallen by the way side, and at some point the decision has been
made to move them to drivers/staging, and if nothing happens to fix
them up (showing that no one cares about them), they've eventually
been dropped.

Of course, us talking about this might be enough to spur some effort
to get the thing properly fixed. :)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
