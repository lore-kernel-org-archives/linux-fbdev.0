From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 26 Aug 2014 08:40:27 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140826084026.GF17263@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0rSojgWGcpz+ezC3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <CAKON4OyjJ+QcBGOzrUDH9J+DxBEKLmXeOcnUyOHHHV_DtCG0zA@mail.gmail.com>
 <53FB47B8.2090104@redhat.com>
 <20140825151255.GA14967@ulmo.nvidia.com>
 <20140825151822.GC21020@skynet.be>
In-Reply-To: <20140825151822.GC21020@skynet.be>
To: linux-arm-kernel@lists.infradead.org


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 05:18:22PM +0200, Luc Verhaegen wrote:
> On Mon, Aug 25, 2014 at 05:12:58PM +0200, Thierry Reding wrote:
> >=20
> > Out of curiosity, how does this work in practice? How does the
> > bootloader create this entry? Does it scan the DT to see which clocks
> > the real hardware device references and then simply copies them to the
> > simplefb node?
> >=20
> > Thierry
>=20
> https://www.mail-archive.com/linux-sunxi@googlegroups.com/msg06619.html

That looks like a royal pain. Again, I think it'd be much simpler (but
not less code, unfortunately) to do this on a per-resource basis. That
way these low-level firmware drivers in the kernel can stay trivial,
keeping the real complexity where they belong: in hardware-specific
drivers such as DRM/KMS.

Thierry

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/Ef6AAoJEN0jrNd/PrOhZHYP/jxQISYhUGgV5YY3hXuLhviq
xthHFApqTB0db+cgc9UmNvl6xCiU2zCU3uABrtK6ebwPeQICFrfyBbyddRPwasLo
gc9qsaUVt+Q74BW875a9W5MXFPEI1vNM3gOJyHV37zBmL4qmxchdr2AIvSsGX458
ptickJse9l6yDmD2jzUV7g0oqATLaqEj4/YaO8H5YXqbDkK9GC9ZnH1gN12SYvCH
8V2YdXt3wKICxTlOT1FujiKfWTzfX3TAyDOPvjqwbUUePjDXprRFeHVK5dO4HpuK
dH4KLkt8Q2AFst2zoj4yjJgd2xixgT8+5JUyUdSHWTRjGi2ORDioNj16aSEcEaz4
Z3U3UUnLvn9sxUeoYgvXCQJSG5RmxyprSTeq6n2AwQieSBPCcZeTSXCnXxmhLdyt
PfYT1w3vQBpwjQ4NNJr3ahmDMPHo/NsKjkub8lIF22r2PNkAGtV0Q7eT63M8CsNQ
U3v310NIymWzkhKIdh0o8mjFG/SS4L3ChClwXabyJVsimLyMznKM8ReWe9EXk4wh
8CRAA6kH1/JjsUiDp9z3uv9IqrTXikRRMzd2cHnnXBTGTq4KCYPP0mo/kn7UXdpG
Ij2t/qfwumLea5IL9cQn0KrwaJQ80I+S58EYJT6flSG1HIzCKM4rXAcRzX53LNaI
LHK5+LUNJG9/Sa/NSShK
=xyRs
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
