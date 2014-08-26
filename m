From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 26 Aug 2014 14:41:26 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140826144125.GC3027@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="yLVHuoLXiP9kZBkt"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825150900.GB21020@skynet.be> <20140826075247.GC17263@ulmo>
 <20140826120258.GA22395@skynet.be> <20140826122112.GC641@ulmo>
 <20140826123357.GB22395@skynet.be>
In-Reply-To: <20140826123357.GB22395@skynet.be>
To: linux-arm-kernel@lists.infradead.org


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2014 at 02:33:57PM +0200, Luc Verhaegen wrote:
> On Tue, Aug 26, 2014 at 02:21:16PM +0200, Thierry Reding wrote:
> > On Tue, Aug 26, 2014 at 02:02:58PM +0200, Luc Verhaegen wrote:
> > > On Tue, Aug 26, 2014 at 09:52:49AM +0200, Thierry Reding wrote:
> > > > On Mon, Aug 25, 2014 at 05:09:00PM +0200, Luc Verhaegen wrote:
> > > > > On Mon, Aug 25, 2014 at 05:05:04PM +0200, Thierry Reding wrote:
> > > > > >=20
> > > > > > No. simplefb just wants to write to some memory that hardware h=
as been
> > > > > > set up to scan out. The platform requires that the clocks be on.
> > > > >=20
> > > > > Simplefb also requires that the memory is there and is persistent=
=2E Fine=20
> > > > > for discrete graphics cards, fine for rpi where most things are h=
idden=20
> > > > > from the ARM core anyway, not so fine for anybody else.
> > > >=20
> > > > I don't understand. This patch series isn't changing anything about=
 the
> > > > memory aspects of the driver yet it's working for you on sunxi, isn=
't
> > > > it? So it can't be all that broken.
> > > >=20
> > > > Thierry
> > >=20
> > > Oh, i had to go wrestle with UBoot options and reserve 8MB off the to=
p,=20
> > > which the kernel never gets told about. A nice throwback to x86 IGP=
=20
> > > bioses, a past i had thought i had left behind forgood.
> >=20
> > Can you not use the reserved memory code (drivers/of/of_reserved_mem.c
> > in the kernel)? I think that's the generally accepted way to do this
> > with DT.
> >=20
> > Thierry
>=20
> It was mentioned to me, and I probably could do that, but this seemed=20
> even more DT wrangling from within u-boot, and it didn't seem finished=20
> yet. Plus, all of this already was way more wrangling than i bargained=20
> for, especially with the promise of "simple"-fb. Then there is the=20
> really awkward way in which one gets to define clocks outside of a=20
> dts/compiler (you've seen the code, right?), i really did not feel like=
=20
> repeating something like that.

It could most probably be turned into fairly generic and reusable code
so that others can use it. And it would give you a way of recovering
those 8 MiB of memory that you'd otherwise loose.

Thierry

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/JyVAAoJEN0jrNd/PrOhdHMP/0nZKX6NSkZGszIDIiAs5Za3
KJ7OHgWRH55zgSTkft+hfPXFn4+o9WrYBE2fx1x0SYti8Fv845xlskDoOAxH52SD
zOngoB1e7N/N2jD8V/tcySQx0XbcXKLCFkgdap0Zt1Fs6Gu721BmbAzKYretN3S8
+dSe0Iu46pGbbvJwfa+TjnlBhXIORTqyds3XbwSv/icluCiyZP9zn2W37wx2R6Lx
JeS8au7ruh5DXsC1i3CIPOohq4E5H5nbYOJQxCfhSkJAK572qoEWBge0tpZF43uE
aFZiupwbxr6aEgHf+h6eNO6qXZgzJgegPkHtVcV5odb0kDeV3aDLibASVew8RQBl
+K+vH7p/+89tDlzgpRNJSqxpAkWibr9mODrgT6Dd6+/4IBhcz6zhEoTeMjO065jt
WrnK5wl+naitHmZdc0HFaYV8lJlYHM+ZSNEBBqDCm7w8ZoRJxW1trHBLYReJ0pEk
RCo+/sF16ZebJIDt596K8Qml9p7DgzwWh98PDb9bQ1Jwm0dIzH2JcWqsWLco+Ay0
ljNxj8B60MwoMnB5ziWyNaS0eee4OhaPioirJuxtYmjFHe7dOJ+DduvzjxdEpyOp
IWEGYHcuWNLIqZqGV9LgtcaK7h0GkAbQLs8Eh9rb9oSugqmZhbrdGvbDAmfyZcvZ
u5VaBiMVcyyDpslXdVJD
=ICqG
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
