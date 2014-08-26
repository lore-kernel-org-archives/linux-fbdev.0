From: Mark Brown <broonie@kernel.org>
Date: Tue, 26 Aug 2014 10:06:12 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140826100612.GH17528@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LBZT7ZSZinXYkKXX"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <53FB46FF.1010208@redhat.com>
 <20140825145303.GC14763@ulmo.nvidia.com>
 <20140825150705.GB15297@lukather> <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk>
 <20140826091853.GI17263@ulmo>
In-Reply-To: <20140826091853.GI17263@ulmo>
To: linux-arm-kernel@lists.infradead.org


--LBZT7ZSZinXYkKXX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 26, 2014 at 11:18:54AM +0200, Thierry Reding wrote:
> On Tue, Aug 26, 2014 at 10:00:35AM +0100, Mark Brown wrote:

> > > I find that rather odd since I always assumed that a regulator marked
> > > boot-on would not be touched by the core at all, assuming that firmware
> > > set it up properly and that it would be required (even if not explicitly
> > > claimed).

> > No, there's a separate always-on property if we don't want to disable.

> But always-on means that it can't ever be disabled. In this case what
> we'd need is a "don't disable automatically because it's needed, but we
> may want to switch it off at a later point to save power."

Such a property wouldn't make much sense, it should also apply to the
driver at which point it's just the same as always-on.

> > We can't assume that the "proper" setup is that the supply should be
> > left on.

> Right, we can't assume it, but if we're given appropriate hints I think
> it's fair to keep resources set up by firmware untouched.

I really can't see any sensible way to do that in an OS neutral thing
like DT.

> > > have run and generic low-level drivers that take over firmware devices
> > > (simplefb in this case) that don't know anything about the resource that
> > > the devices need.

> > I don't understand this use case, sorry - it sounds like a buggy system
> > design and/or integration.  If the firmware is managing the resource
> > then Linux really shouldn't be talking to it at all without coordinating
> > with firmware.  How can such a system work otherwise?

> The firmware isn't really managing resources. It's setting up state that
> the kernel shouldn't be modifying. Currently the kernel assumes that no
> firmware exists and just disables everything that's not being used. That
> is a reasonable default, but it also limits what we can do. I think if
> we provided a good interface to communicate state between firmware and
> kernel then we could easily do this kind of hand-off.

I'm afraid that's confusing me even further.  If the "firmware devices"
don't know anything about the resources as you say then presumably they
need to be always on since they obviously won't be able to control them
and there is going to be no handoff?

--LBZT7ZSZinXYkKXX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/FwRAAoJELSic+t+oim9j9wP/Rw81V+kfRZ5zkfUBYF+19iE
rIqXq9H+7BGgjooU4m2YTTHY5J8vu7Snf8c9f/Fb+tfoIjtNSVB9ihNKIGYVgh/L
JbtpOEwPjinZ6NdSRFytOymzE7yw8KZbe+MgUAbcNjv7g09JachMMMsrZpXoV9rb
47cQCo2mLbKADZDqnQY0I1+Bw4I4WEmCx6wVyiYrKyBGS+Oq7JfeG59XxUp+zXWt
20EgZvQhPU93g5iCM9okRdRnWkutYv34WTO/LpkUZLKoWLK9lX41Cjtq44nnvOh0
X3yRxjaaRDK0smP/UhvsReLpMA2Bgn/CjHAXYmtyvGk/GchVeeXEZIBsqEWyisKR
+PuRqrTE0+fjbDmeoK/wG8kOiMmqJqTnj8ajY2Jj/GxSSBLrqIJHyYls4DdhstIl
uhh40zukcQvOmDnDVehNEPe5Z6ps/uUUHCcMUyxSZsq98AafdLqsMzFTM+ONUzO0
cTSnNr+zUd2SVzaH5w3qxxZ1ZXF4pEu133fV8IfojhWNyWHkrgdk0qT0IR+H86R2
/iG56ESykMhO7oIr9nh7MsFhLZHVUq8L+jKHYp/TLjRFBAN8zbp03nKy7aeKA+VF
vBbe2cqJ3XIHrqQARdf//IrJXP9ZX29ftwq4VE95BvhxwFr7LvCDnple2r1rDJ05
YB2ICrtnOVJd3Bh9c9Cc
=vUs1
-----END PGP SIGNATURE-----

--LBZT7ZSZinXYkKXX--
