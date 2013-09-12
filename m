From: Pawel Moll <pawel.moll@arm.com>
Date: Thu, 12 Sep 2013 15:23:45 +0000
Subject: Re: [PATCH 1/2] video: ARM CLCD: Add DT support
Message-Id: <1378999425.13571.54.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378488201-21146-1-git-send-email-pawel.moll@arm.com>
 <522BAED9.4020301@gmail.com> <1378725559.4082.28.camel@hornet>
 <522F91F8.6010207@gmail.com> <1378907036.4082.105.camel@hornet>
 <5230DD1C.6060606@gmail.com>
In-Reply-To: <5230DD1C.6060606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, 2013-09-11 at 22:14 +0100, Sylwester Nawrocki wrote:
> Yes, I wasn't aware then that your "video RAM" is a separate chip attached
> to a distinct bus.
> My idea was to reuse memory node structure, including "reserved-memory"
> compatible value (note there are some fixups pending and those names are
> subject to change). Not sure about the property in CLCD device node
> containing phandle to the memory node (currently 'memory-region').

As I just told Steven, I'll just make it painfully low-level property
defining "address you have to generate to access base of the
framebuffer". Of course one can still go the CMA way, if such need
arises.

> > Ok, I see what you're saying. Yes, this could be done. No, I don't claim
> > to have enough expertise either (micrometers??? :-O ;-) The other thing
> > is that I don't really expect generic CDF bindings to cover such things.
> > They will (hopefully) only describe what's connected with what. And the
> > drivers should know how. Of course they may need the dimensions&  alike
> > in the tree (of course having them standardised would help here), but
> > it's not a CDF job to provide those.
>=20
> Of course it's always easier to define couple of DT properties that would
> cover part of functionality of some specific device. But then such=20
> properties should be prefixed with vendor name AFAIU, since they are
> not approved as common ones and useful for wider set of devices.

This is a policy that changed many times already...

Anyway, I think I've got an idea how to render the problem custom panel
properties invalid. If so, I'll send another version of the patch.

>  From the device tree perspective CDF is just a collection of (display
> related) devices and a complete set of DT properties will be needed to
> describe them. Certainly some share of device-specific properties should
> be expected. Links between (sub)devices can be already described in DT by
> the binding documented in video-interfaces.txt.

Whether to use the v4l scheme or not still seems to be a bone of
contention between the video and the DRM/KMS folk, so I wouldn't draw
any conclusions yet.

Pawe=C5=82


