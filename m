From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 17 Oct 2013 11:07:50 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <3592147.9IprvsogX6@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart43190268.VaavcGE6mS"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <525FB368.6020003@ti.com> <20131017104856.GA10993@ulmo.nvidia.com>
In-Reply-To: <20131017104856.GA10993-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--nextPart43190268.VaavcGE6mS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Thursday 17 October 2013 12:48:57 Thierry Reding wrote:
> On Thu, Oct 17, 2013 at 12:52:40PM +0300, Tomi Valkeinen wrote:
> > On 17/10/13 12:16, Thierry Reding wrote:
> > > On Thu, Oct 17, 2013 at 11:49:52AM +0300, Tomi Valkeinen wrote:
> > >> Just my opinion, but yes, DT is that inflexible. DT bindings are like a
> > >> syscall. Once they are there, you need to support them forever. That
> > >> support can, of course, include some kind of DT data converters or
> > >> such, that try to convert old bindings to new bindings at kernel boot.
> > > 
> > > That's not entirely true. DT bindings are allowed to change, the only
> > > restriction being that they don't break backwards compatibility. So if
> > 
> > True, but afaik the same goes for syscalls. But yes, it's probably
> > easier to add, say, new properties to DT bindings than adding new flags
> > to a syscall.
> > 
> > > Am I the only one refusing to accept that we can't provide even the most
> > > basic functionality simply because we haven't been able to come up with
> > > the ultimately "perfect" DT binding yet? By definition it's not very
> > > likely that any binding will ever be perfect.
> > 
> > With "perfect" I meant without any obvious features missing. I agree
> > that DT bindings will never be perfect, but I at least would like them
> > to be good enough to cover all the cases we know of.
> 
> As far as the simple panel device tree binding is concerned, it covers
> all the cases I know of. I can't seriously be expected to do any better
> than that. These panels are dumb. They only come with a power supply
> that needs to be switched on and an additional GPIO to enable it once
> powered up. All three panels just work with that set of properties. So
> anything that doesn't can arguably be covered by some other, not-so-
> simple binding.
> 
> > > I don't think we're doing ourselves any good by letting DT actively
> > > hinder us in merging any of these features. I would personally prefer
> > > having to support several bindings rather than not be able to provide
> > > the functionality at all.
> > 
> > I'd say the driver writer is of course free to create basic bindings for
> > the device in question as long as the bindings are sane, and he agrees
> > to later create any needed converters. I don't see any problem with
> > having a driver supporting several versions of the bindings.
> > 
> > But I don't think it's fair to push a driver with basic bindings,
> > knowing that the bindings won't be enough in the future, and leave all
> > the converter-mess to other people (not saying that's the case here).
> > 
> > As a fbdev maintainer, I'm ok with adding DT bindings to device specific
> > fb drivers, as those can be just left as they are. Even when CDF is
> > merged, the specific fb drivers just work with the old bindings. If the
> > driver maintainer wants to use CDF, it's up to him to create any needed
> > binding-converters.
> > 
> > But a generic driver for panels is more problematic, as that one should
> > be maintained and refreshed to new features like CDF. If such was
> > proposed to be merged to fbdev, I'd be very reluctant to merge it if
> > there were any concerns about it.
> 
> I'm still missing the point here. For one, I don't see any reason that
> this driver would ever need to gain CDF support. At the same time, CDF
> could easily be supported by just adding a few required properties and
> it should be easy to support any non-CDF cases just as well to remain
> backwards-compatible.
> 
> > I guess one option there would be to implement a new driver for the same
> > panel devices, one that supports CDF, and leave the old one as is. Not
> > so nice option, though.
> 
> As I said, anything that really needs a CDF binding to work likely isn't
> "simple" anymore, therefore a separate driver can easily be justified.

The system as a whole would be more complex, but the panel could be the same. 
We can't have two drivers for the same piece of hardware in the DT world, as 
there will be a single compatible string and no way to choose between the 
drivers (unlike the board code world that could set device names to "foo-
encoder-v4l2" or "foo-encoder-drm" and live happily with that ever after).

> > > For crying out loud, we can use the 3D engine to render to a framebuffer
> > > but we can't look at the result because we can't make the bloody panel
> > > light up! Seriously!?
> > 
> > Ah, but do you have DT bindings for the 3D engine yet, which represent
> > how different internal blocks in the 3D engine are connected? If not,
> > better start designing it! Then the problem is solved, you won't even
> > have working 3D engine. ;)
> > 
> > But seriously speaking, I'm with you. I don't get this DT stuff.
> > 
> > And the funny thing is, DT should just represent the hardware, it
> > doesn't matter what kind of SW drivers there are, so in a sense talking
> > about DT problems with a SW framework like CDF is a bit silly. How hard
> > can it be to describe the hardware properly?
> > 
> > Very, obviously =).
> 
> Indeed. The fundamental point here seems to be that we don't represent
> things in DT which we don't need. In the same way that we don't add device
> nodes for enumerable devices, why would we need to explicitly add
> information about connections between devices that cannot be controlled
> anyway. If the board connects an RGB/LVDS output to a panel directly, it is
> only required that the output knows what it is connected to because there is
> no other way besides DT to obtain any information about the panel. Therefore
> a unidirectional connection is more than enough. Using that the output can
> access the panel and query it for information such as the mode timings as
> well as switch it on or off as required.

Please note that the idea of putting the modes in DT in no way implies that 
the device controller should parse the modes from the panel node. It must 
instead query the panel at runtime through whatever API is provided. Going 
directly to the DT data would be a layering violation. The reason why I 
propose to add modes to the panel DT node is to make the geenric panel driver 
more generic and simpler.

-- 
Regards,

Laurent Pinchart

--nextPart43190268.VaavcGE6mS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSX8UGAAoJEIkPb2GL7hl1t2cH/iABGRv2vsyHfq0ZFP6qtc+x
S4p+g6n7KDZjNj/Z5HjB309cOzRcbP7n+GwkzyAkquRuo2YlxWvwvt0EOpO0S2zy
uLBVBXPZnBHlPQsQinbCidVb/qTI8jy4EQcXF9VPiUPCZ/lNzsNqwvkFqd+zkX4V
wA1tk4jJ4nn+vlthRfE+DOJbbV16jh1RBklYdtcbu6NOxmaby0Uj1b4ey9b07QPx
nodRXZU490g0d5w/AMNGfxy34fDYhNJtTm0rvkwic8XU/jbl+Wnm7aSnABV3NEoF
O2CWHUaWzN/jBpj1y4YMr2kJh/IIlXOL6ddXAuZ2VvdTglfethw74ld87DvYeeA=
=PO+l
-----END PGP SIGNATURE-----

--nextPart43190268.VaavcGE6mS--

