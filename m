From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 25 Oct 2013 13:47:21 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <1394972.QJSGNM8CJk@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart3650824.jQdurFOLSj"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <526999DA.7080409@wwwdotorg.org> <20131025081314.GC19622@ulmo.nvidia.com>
In-Reply-To: <20131025081314.GC19622-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--nextPart3650824.jQdurFOLSj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Friday 25 October 2013 10:13:15 Thierry Reding wrote:
> On Thu, Oct 24, 2013 at 11:06:18PM +0100, Stephen Warren wrote:
> > On 10/24/2013 12:20 PM, Laurent Pinchart wrote:
> > > On Sunday 20 October 2013 23:07:36 Stephen Warren wrote:
> > >> On 10/17/2013 12:07 PM, Laurent Pinchart wrote:
> > >> ...
> > >> 
> > >>>> As I said, anything that really needs a CDF binding to work
> > >>>> likely isn't "simple" anymore, therefore a separate driver can
> > >>>> easily be justified.
> > >>> 
> > >>> The system as a whole would be more complex, but the panel could be
> > >>> the same. We can't have two drivers for the same piece of hardware
> > >>> in the DT world, as there will be a single compatible string and no
> > >>> way to choose between the drivers (unlike the board code world that
> > >>> could set device names to "foo- encoder-v4l2" or "foo-encoder-drm"
> > >>> and live happily with that ever after).
> > >> 
> > >> That's not true. We can certainly define two different compatible
> > >> values for a piece of HW if we have to. We can easily control whether
> > >> they are handled by the same or different drivers in the OS.
> > > 
> > > From an implementation point of view, sure. But from a conceptual point
> > > of view, that would make the DT bindings pretty Linux-specific, with a
> > > description of what the operating system should do instead of a
> > > description of what the hardware looks like. My understanding is that
> > > we've tried pretty hard in the past not to open that Pandora's box.
> > > 
> > > The case I'm mostly concerned about would be two different compatibility
> > > strings to select whether the device should be handled by a KMS or V4L
> > > driver. I don't think that's a good idea.
> > 
> > I wouldn't think of the two compatible values as selecting different
> > specific Linux drivers, but rather they simply describe the HW in
> > different levels of detail. The fact that if we know a certain level of
> > detail about the HW means that Linux can and does create a KMS driver
> > rather than a V4L2 driver seems like a detail that's completely hidden
> > inside the OS.
> 
> I've had a somewhat similar idea the other day but couldn't really put
> it into words. Interestingly someone else mentioned a similar concept in
> a different thread which I think describes what I had in mind as well.
> 
> I was wondering if we couldn't use two compatible values to denote two
> interfaces that the device implements. Something along the lines of:
> 
> 	compatible = "vendor,block-name", "encoder";
> 
> So a driver could primarily match on "vendor,block-name", but at the
> same time it could use the additional information of being required to
> implement "encoder" to expose an additonal interface.

Let's take the hardware architecture described in
http://www.ideasonboard.org/media/meetings/20131024-elce.pdf#39 (page 39) as 
an example. The green blocks are part of the capture pipeline and handled by 
the V4L subsystem. The blue blocks are part of the display pipeline and 
handled by the KMS subsystem. One ADV7511 HDMI transmitter instance need to be 
controlled by a KMS driver and the second one by a V4L driver. 

The two instances are identical, so their DT nodes will show no difference if 
we stick to a hardware description only. There would then be no way to bind to 
different drivers.

> I suppose that perhaps something like a device_type property could be
> used for that as well, and that might even be the more correct thing to
> do.
> 
> We already do something similar to make GPIO controllers expose an
> interrupt chip by adding an interrupt-controller property. We also use
> the gpio-controller property to mark a device node as exposing the GPIO
> interface for that matter.
>
> So if a HW block can actually implement two different interfaces, each
> of them being optional, then there should be ways to represent that in
> DT as well. We already do that for "simpler" HW blocks, so there's no
> reason we shouldn't be able to do the same with multimedia components.
> 
> If it's really an encoder, though, the problem might be different,
> though, since the interface (at a hardware or functional level if you
> will) remains the same. But I think in that case it's something that
> needs to be figured out internally by the OS. In my opinion, if we are
> in a situation where we have two different drivers in two subsystems for
> the same device, then we're doing something wrong and it should be fixed
> at that level, not by quirking the DT into making a decision for us.

I tend to agree, and I'd like to be able to share drivers between V4L and KMS. 
This is way down the road though.

-- 
Regards,

Laurent Pinchart

--nextPart3650824.jQdurFOLSj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSanZ5AAoJEIkPb2GL7hl1pDEIAIztPanSCaC24aXGvPlQC3C/
ZfGkflwI8CV2DJCbjVNZqh2/KC1e6HOvttd8U46GjZgonoCjbyhFapjA3REDNYrf
dmkjwVMkPIjRNs0mNNZP1gTUOGCembgOS4hJDNbZFJRaLDkBDvKBe36ovs77nvP/
7k0EIqpjK9iNIQ1JSEN8UEBgcMYJJvKpMRKwJIetqmDvvA0xxKngtCbN6DmkQzVi
KXI9QCNqyDMrN8Vi2fomwoVj0o3i1W9gGsOP+YwU/XsA7Kc9mVlrGG9sshekWomV
7iEkyYeh06yzwqzxzU2zCRY+g+p4GFyFG85pgryK8Zr57wZL9N/d2LZTJmLAYTE=
=Py4/
-----END PGP SIGNATURE-----

--nextPart3650824.jQdurFOLSj--

