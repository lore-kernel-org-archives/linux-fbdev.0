From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 25 Oct 2013 13:49:06 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <2795867.6uf3fOp5x2@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart10022146.y78TQkVgW6"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <1580941.z2CDo8WmRF@avalon> <20131025122925.GA24720@ulmo.nvidia.com>
In-Reply-To: <20131025122925.GA24720-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--nextPart10022146.y78TQkVgW6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Friday 25 October 2013 14:29:26 Thierry Reding wrote:
> On Fri, Oct 25, 2013 at 01:33:11PM +0200, Laurent Pinchart wrote:
> > On Thursday 24 October 2013 23:06:18 Stephen Warren wrote:
> > > On 10/24/2013 12:20 PM, Laurent Pinchart wrote:
> > > > On Sunday 20 October 2013 23:07:36 Stephen Warren wrote:
> > > >> On 10/17/2013 12:07 PM, Laurent Pinchart wrote:
> > > >> ...
> > > >> 
> > > >>>> As I said, anything that really needs a CDF binding to work
> > > >>>> likely isn't "simple" anymore, therefore a separate driver can
> > > >>>> easily be justified.
> > > >>> 
> > > >>> The system as a whole would be more complex, but the panel could be
> > > >>> the same. We can't have two drivers for the same piece of hardware
> > > >>> in the DT world, as there will be a single compatible string and no
> > > >>> way to choose between the drivers (unlike the board code world that
> > > >>> could set device names to "foo- encoder-v4l2" or "foo-encoder-drm"
> > > >>> and live happily with that ever after).
> > > >> 
> > > >> That's not true. We can certainly define two different compatible
> > > >> values for a piece of HW if we have to. We can easily control whether
> > > >> they are handled by the same or different drivers in the OS.
> > > > 
> > > > From an implementation point of view, sure. But from a conceptual
> > > > point of view, that would make the DT bindings pretty Linux-specific,
> > > > with a description of what the operating system should do instead of a
> > > > description of what the hardware looks like. My understanding is that
> > > > we've tried pretty hard in the past not to open that Pandora's box.
> > > > 
> > > > The case I'm mostly concerned about would be two different
> > > > compatibility strings to select whether the device should be handled
> > > > by a KMS or V4L driver. I don't think that's a good idea.
> > > 
> > > I wouldn't think of the two compatible values as selecting different
> > > specific Linux drivers, but rather they simply describe the HW in
> > > different levels of detail. The fact that if we know a certain level of
> > > detail about the HW means that Linux can and does create a KMS driver
> > > rather than a V4L2 driver seems like a detail that's completely hidden
> > > inside the OS.
> > 
> > I expect the same level of details to be needed on both the KMS and V4L
> > sides. Taking the example of the ADV7511 HDMI transmitter, the only
> > change in the DT bindings between KMS and V4L would be the compatible
> > string. "adi,adv7511-v4l" and "adi,adv7511-kms" is an option that I don't
> > really like. Renaming -v4l and -kms to different names wouldn't
> > fundamentally change the problem.
>
> I think that we're doing something fundamentally wrong if we use the
> same device (with the same functionality) in two different subsystems.
> If the device is used to display something, shouldn't we be moving the
> driver to DRM?

Let's discuss this in reply to the e-mail from this thread in which I mention 
the ADV7511 example.

-- 
Regards,

Laurent Pinchart

--nextPart10022146.y78TQkVgW6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSanbSAAoJEIkPb2GL7hl1GUgIAJPkDgGmoNhv/vMbo9nAjmdR
cvqXYB5MlalwU7Fw5VBEOpsJ59QTTL1vYe78GiK0vidLyvGOpBBW63bsDA5TQdYz
b6n2D2GOM26r4HNMBqxH+eSbFgpevvWN1W2TDh2EDxN8pWnz8mSDkt/RtIS9nTW2
XGBoAjv1HOSCKoYIx6mFc0oqph7DQ7P40qYhwj46GxWxQFCT9MBtOFyOlip3ERuw
J6vJjRQeIgag+OqUmmc0Ps16BVKfoiSKLGHwPvROm2JIlAPEv2cOb4LE7ETQMA/I
5mDUJ+rEkvfZl6BVROFD77WkH55lJbbTkXChb/UWIY+17OR2/CfydeN13qw2kOw=
=fUL6
-----END PGP SIGNATURE-----

--nextPart10022146.y78TQkVgW6--

