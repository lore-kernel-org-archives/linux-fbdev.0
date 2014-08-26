From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 26 Aug 2014 12:21:16 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140826122112.GC641@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="f+W+jCU1fRNres8c"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825150900.GB21020@skynet.be> <20140826075247.GC17263@ulmo>
 <20140826120258.GA22395@skynet.be>
In-Reply-To: <20140826120258.GA22395@skynet.be>
To: linux-arm-kernel@lists.infradead.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2014 at 02:02:58PM +0200, Luc Verhaegen wrote:
> On Tue, Aug 26, 2014 at 09:52:49AM +0200, Thierry Reding wrote:
> > On Mon, Aug 25, 2014 at 05:09:00PM +0200, Luc Verhaegen wrote:
> > > On Mon, Aug 25, 2014 at 05:05:04PM +0200, Thierry Reding wrote:
> > > >=20
> > > > No. simplefb just wants to write to some memory that hardware has b=
een
> > > > set up to scan out. The platform requires that the clocks be on.
> > >=20
> > > Simplefb also requires that the memory is there and is persistent. Fi=
ne=20
> > > for discrete graphics cards, fine for rpi where most things are hidde=
n=20
> > > from the ARM core anyway, not so fine for anybody else.
> >=20
> > I don't understand. This patch series isn't changing anything about the
> > memory aspects of the driver yet it's working for you on sunxi, isn't
> > it? So it can't be all that broken.
> >=20
> > Thierry
>=20
> Oh, i had to go wrestle with UBoot options and reserve 8MB off the top,=
=20
> which the kernel never gets told about. A nice throwback to x86 IGP=20
> bioses, a past i had thought i had left behind forgood.

Can you not use the reserved memory code (drivers/of/of_reserved_mem.c
in the kernel)? I think that's the generally accepted way to do this
with DT.

Thierry

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/Hu4AAoJEN0jrNd/PrOhhSQP/i+JztSWa6XQgTmC+CBUTDPR
vgaSBbtpHdE+GjZ9wfLv8S9tl+temFIDEfVBBzeo+mqnaqsegoC3zF3BJNYNvesV
bOlorLfp6Q+mYQbWzX1jIbfvL/jQK5FdKSMVBe3Jh6xWKN8AoX0blpCJut5ptjH5
DJh0qVDeghT550NAoo2W+eFPBWKaS6SrHLwr1Z48ul+VUFk1IVld6wGic5j1MKtz
xQx46hTm1HiWWkc49cy+TLpD2IPPLnEKt0mPVX939Vp7/GRo6ARY6E3Y5xAaXI6z
bUBhmyAZmT7txDXv629Ft+l6SRp5YHT27V4sV0LRulNr9JgnqwIdSQt0d89EMBlM
Klt674SH337DaQuo8kQYvISg8a2q6j1p27i61bJ7FaKQ8okiJ8Qp/b0GFV9YvgYs
lfny+OSF3nxceNtfUY3MNXvxeqLfowIs9SxPPTDEzt7iYF60clJcsiVP8uUCnXZg
Ypgbi7d38KGD94K2I0kfM6HBWL4N9SIdULlWsrfitnLMrvIFgmi67p1yNcY1s/xk
IQftfj7lBXsuIs577QW9waSVhbfn9CT/403gsgQH5/laPYsDY8R25mzmQz8i0qmn
k8EWWDMd4CVEOAut+jorN9ouoerEp7wfcH+i/mBBf6wYjI5UldiWGQ25Hp7PSd8O
X1ohJv2K2mSto9TPRjmd
=ZCvJ
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
