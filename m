From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 26 Aug 2014 13:53:41 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140826135341.GM15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="CvOg3jo0sXL5jEc+"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
In-Reply-To: <20140826080432.GD17263@ulmo>
To: linux-arm-kernel@lists.infradead.org


--CvOg3jo0sXL5jEc+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2014 at 10:04:33AM +0200, Thierry Reding wrote:
> > > No. simplefb just wants to write to some memory that hardware has been
> > > set up to scan out. The platform requires that the clocks be on. Other
> > > platforms may not even allow turning off the clocks.
> >=20
> > Like what? the rpi? Come on. Just because the videocore is some black
> > box we know nothing about doesn't mean we should use it as an example.
>=20
> You make it sound like the Raspberry Pi is somehow less important than
> sunxi.

No. What I mean is that it seems like we are somehow punished, or at
least blamed, for having a better and more complete kernel support.

> > Any decent enough SoC, with a decent support in the kernel will have
> > clocks for this, and I really wonder how simplefb will behave once its
> > clocks will be turned off...
>=20
> There are other devices besides ARM SoCs that may want to use this
> driver and that don't have clock support.

And in this case, with this patch, simplefb will not claim any clock,
nor will fail probing.

> But you're missing my point. What I'm saying is that the simplefb driver
> is meant to serve as a way to take over whatever framebuffer a firmware
> set up. Therefore I think it makes the most sense to assume that nothing
> needs to be controlled in any way since already been set up by firmware.
> Eventually there should be a driver that takes over from simplefb that
> knows how to properly handle the device's specifics, but that's not
> simplefb.

I guess such a hand over if it were to happen in the kernel would
involve the second driver claiming the resources before the first one
release them. How is that different in this case?

> The goal of this patch series is to keep clocks from being turned off.
> But that's not what it does. What it does is turn clocks on to prevent
> them from being turned off. In my opinion that's a workaround for a
> deficiency in the kernel (and the firmware/kernel interface) and I think
> it should be fixed at the root. So a much better solution would be to
> establish a way for firmware to communicate to the kernel that a given
> resource has been enabled by firmware and shouldn't be disabled. Such a
> solution can be implement for all types of resources and can be reused
> by all drivers since they don't have to worry about these details.

Mike Turquette repeatedly said that he was against such a DT property:
https://lkml.org/lkml/2014/5/12/693

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--CvOg3jo0sXL5jEc+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/JFlAAoJEBx+YmzsjxAgfukP/Ro3ntrJCM/RtWnJww8cC7l1
nhleHkJb1BqsTMwSbuJtgLV0zz6Rt4GUF2bdzbt/Bwe7v3pd9ijUeVpTfaTZ5S6w
fHGxhslpWp9R/0LOINtR5DucbiJGrSDT8t4YjusyAQKZ3lWA1EQAMW9ycI3RFOZ6
RWqEK9+RNySDAUjda1rxfz/APDFWZFMmZYSv9VMMEYB9ZYSzp8vHo+uMkSKdqLUK
cMPdHwkHBow8zebBjmriSYHfaLor56hhohbc/P7SA8/13hckQhRn3tvlpE0K040B
oKzVmOddtG7u/ov7xLkdtsWYfJ3uwmIHNIcAzWtmSDZ2gcGRc9ThAcLTouvajChM
qXGIxi2GdixMt3sAKtqHquVXXEfM+ahsWBJR4cMjQ3d/5LzySfcKbfSFgxKr9F1b
cG5qaCyoXlHbNee5XBnvrw1hvKF774Py4U4ssMehkNIAgKWWjlrUbSsM/5LI6VY9
cTSYao+1Wu0iBlmp3LvLcujLLNu53V3QtgK3caBnSxcL2LZvZYfZ2yeA8mbSXFDk
uIXSxled3dNMMk23Vr6J/gTMsvGdvxEEprhGudthbBO8PhSOop6zLGZi8Rvs3dR0
FW0hcMSG45CDeVDZI2MVvR1Uwc5qPKivzX2Hn/F42WndVhYj5jxOWTDg8lm/t/Lf
wjNK68Ktqj2kmLQzDuxy
=D87s
-----END PGP SIGNATURE-----

--CvOg3jo0sXL5jEc+--
