From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 26 Aug 2014 13:43:14 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140826134312.GB2980@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9zSXsLTf0vkW971A"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <CAKON4OyjJ+QcBGOzrUDH9J+DxBEKLmXeOcnUyOHHHV_DtCG0zA@mail.gmail.com>
 <53FB47B8.2090104@redhat.com>
 <20140825151255.GA14967@ulmo.nvidia.com>
 <20140825151822.GC21020@skynet.be> <20140826084026.GF17263@ulmo>
 <20140826132207.GL15297@lukather>
In-Reply-To: <20140826132207.GL15297@lukather>
To: linux-arm-kernel@lists.infradead.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2014 at 03:22:07PM +0200, Maxime Ripard wrote:
> On Tue, Aug 26, 2014 at 10:40:27AM +0200, Thierry Reding wrote:
> > On Mon, Aug 25, 2014 at 05:18:22PM +0200, Luc Verhaegen wrote:
> > > On Mon, Aug 25, 2014 at 05:12:58PM +0200, Thierry Reding wrote:
> > > >=20
> > > > Out of curiosity, how does this work in practice? How does the
> > > > bootloader create this entry? Does it scan the DT to see which cloc=
ks
> > > > the real hardware device references and then simply copies them to =
the
> > > > simplefb node?
> > > >=20
> > > > Thierry
> > >=20
> > > https://www.mail-archive.com/linux-sunxi@googlegroups.com/msg06619.ht=
ml
> >=20
> > That looks like a royal pain. Again, I think it'd be much simpler (but
> > not less code, unfortunately) to do this on a per-resource basis. That
> > way these low-level firmware drivers in the kernel can stay trivial,
> > keeping the real complexity where they belong: in hardware-specific
> > drivers such as DRM/KMS.
>=20
> So we have to write a DRM/KMS driver in order to have display working
> while waiting for a DRM/KMS driver to be worked on? Come on...

Perhaps you should go and read this thread again. That's not at all what
I've been saying.

Thierry

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/I7wAAoJEN0jrNd/PrOh4c8P/0PojPZpyCN84clnaRLPurD8
MEOtDiBINUOsCB4FPoBrEzmg+g+8zgGzXnOm3ASTJjjTnbIsGMjgKJzfYUrfGy9c
nuFB9d+xoW0Qhsc17ynYQFCK/VDtXDDi0my9N0Kr5HVLIhVAQJfPBqRqf6uRpaC5
3bZdRBqW2VXmuqY1yN0bmSnPMRkhrSS8n8shom0UkvxMZorWVrWuddXKAFewddCa
Tke4q/GXcupco0sYDUlh/6Qom6NwNnio/M/NdO1VocjzTu0hChh2lpMeWrsHhAS+
ICwARAg9whYVusLM+zOYgsDZKx8BMRiwlWaK4VeCVrU5lsT9K4kbSQOKax1aso+N
vVeFT76B7g/r9tD6NJ0rFAKXT1zR2koQhK28Z5liPoE/lk6R8jvRGvMPaY2btBna
uyAkJXwoHzrWodDQgkWrXGpTS8S9e9t3vnOroDHfKqEzti7zlgc+jrWY2rr+F2zh
T9MbE+tmohN6coIrNrjnPWx3QefhVuVoJllrDtLpiCHfOlDrZ3SB7y7T/PYLhl4S
EIMU2hH2kPJNa/GrPF5IdnHZtEg35cmZ9g2wtFytV02igIhgxSwq8xXXx5ld0wvu
1kHn85OIxcpbM1WvxvJLbhzYVn1d95suFCj9U/9pTr85UagEjmVyq8yX1ixFcko3
2P2DGLOCo4XC3qa9Cz3x
=JbLN
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
