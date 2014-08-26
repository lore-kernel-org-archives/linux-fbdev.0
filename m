From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 26 Aug 2014 09:18:54 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140826091853.GI17263@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AptwxgnoZDC4KQWS"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <53FB46FF.1010208@redhat.com>
 <20140825145303.GC14763@ulmo.nvidia.com>
 <20140825150705.GB15297@lukather> <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk>
In-Reply-To: <20140826090035.GB17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org


--AptwxgnoZDC4KQWS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2014 at 10:00:35AM +0100, Mark Brown wrote:
> On Tue, Aug 26, 2014 at 10:26:27AM +0200, Thierry Reding wrote:
> > On Mon, Aug 25, 2014 at 05:07:05PM +0200, Maxime Ripard wrote:
>=20
> > > Regulators with regulator-boot-on will still be disabled if there's no
> > > one to claim it. Just like what happens currently for the clocks.
>=20
> > I was somewhat surprised by this, but it can indeed easily be verified.
> > It seems to me somewhat at odds with the definition of such a property.
>=20
> That depends what you think it should do - it's there for handover from
> the bootloader in cases where we can't read the state.

True. The description leaves a lot of room for interpretation, though.

	- regulator-boot-on: bootloader/firmware enabled regulator

> > that. However the implementation will automatically disable a regulator
> > marked boot-on if it hasn't been claimed by any driver after the
> > initcall stage completes.
>=20
> > I find that rather odd since I always assumed that a regulator marked
> > boot-on would not be touched by the core at all, assuming that firmware
> > set it up properly and that it would be required (even if not explicitly
> > claimed).
>=20
> No, there's a separate always-on property if we don't want to disable.

But always-on means that it can't ever be disabled. In this case what
we'd need is a "don't disable automatically because it's needed, but we
may want to switch it off at a later point to save power."

> We can't assume that the "proper" setup is that the supply should be
> left on.

Right, we can't assume it, but if we're given appropriate hints I think
it's fair to keep resources set up by firmware untouched.

> > Two categories of drivers have this issue: drivers built as modules (or
> > that defer probing) and therefore won't be probed until after initcalls
>=20
> We really need a later initcall to manage handover to userspace
> (probably triggered by a combination of userspace saying it's done doing
> initial module enumeration and the deferred probe grinding to a halt).

Yes, perhaps that would be another option.

> > have run and generic low-level drivers that take over firmware devices
> > (simplefb in this case) that don't know anything about the resource that
> > the devices need.
>=20
> I don't understand this use case, sorry - it sounds like a buggy system
> design and/or integration.  If the firmware is managing the resource
> then Linux really shouldn't be talking to it at all without coordinating
> with firmware.  How can such a system work otherwise?

The firmware isn't really managing resources. It's setting up state that
the kernel shouldn't be modifying. Currently the kernel assumes that no
firmware exists and just disables everything that's not being used. That
is a reasonable default, but it also limits what we can do. I think if
we provided a good interface to communicate state between firmware and
kernel then we could easily do this kind of hand-off.

Thierry

--AptwxgnoZDC4KQWS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/FD9AAoJEN0jrNd/PrOhumoQAIh0SXY7A+5cVB9VShWOXYOw
m7psgoZU81Fn2Zr86Z0pIbzx3VXtlq9DlumwOrPYHN0Qdutcho7YWalknO7BRScl
neasSq7Cx+loVY2ZcsiTr7jSoKU8wOwVZd8UXlp1GOoiuBT+9w9K69diVclIGOpZ
aobIWroB/IjZXOCzuqW122Ia64hfFHc6wc64Mind4abY/KmC5JA1utGVlBY8/VcI
45SBdJ7h0wLh/9mgs4TqR1TF6m8oyzAH6G3gupdaxxtXF63WMyJFSwqLnbXOqwKr
cny8OoALNMdikl1TLns+g1HViI1n79PcsVX+TaPf4gQ2EtsnII9XYzmohJot7ULL
jlr8wCwx5kwbI1nTHpeOIVPuez/z0c9euAvYO7aW65e3HfMoTmlJbW/+n+A1IryX
m7eab1GeiQyIZH0Fk30+w0jLpVhaFdN/DT1VhsyntPlP/Yb3pij2vZ/GF0to8QR6
EpchdSdgA6u+DxQO46Ju9ij3FTHy8xpPDEFP6nosJFIBx/NOUn+5FFy477/rQtf9
vkGPFIiZEordEPPAKi5R1jSMuL+4Tpn2t9i5L5ou3Cj+iiuqOIPuTSuTrdb4n+/L
D7uHlT+Q4jrJ+youY23zpb2IyFvpZ5xdmEEQboXoVmhqNNrwbzyh8IlwNqVezQJG
z809n1RgLj0h7rVKbqb+
=Xd0j
-----END PGP SIGNATURE-----

--AptwxgnoZDC4KQWS--
