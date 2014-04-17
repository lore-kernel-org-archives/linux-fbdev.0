From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 17 Apr 2014 03:24:31 +0000
Subject: Re: [GIT PULL] fbdev fixes for 3.15
Message-Id: <20140417132431.9df427a03764b8c9ae60f0cd@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Thu__17_Apr_2014_13_24_31_+1000_Zqvi3X5.oW9xi/wN"
List-Id: <linux-fbdev.vger.kernel.org>
References: <534E4775.8010009@ti.com>
	<CA+55aFz7Hgjc9wmiriqGT8VXNF-7b0aUKf96r=TCP+1NOTSVeQ@mail.gmail.com>
In-Reply-To: <CA+55aFz7Hgjc9wmiriqGT8VXNF-7b0aUKf96r=TCP+1NOTSVeQ@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>

--Signature=_Thu__17_Apr_2014_13_24_31_+1000_Zqvi3X5.oW9xi/wN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Apr 2014 16:04:39 -0700 Linus Torvalds <torvalds@linux-foundatio=
n.org> wrote:
>
> On Wed, Apr 16, 2014 at 2:03 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> >
> > The drivers/video/Kconfig change in this pull request will conflict wit=
h the
> > fbdev reorder series, which is not yet in your tree. If that's an issue=
, I can
> > resend this without the Kconfig change.
>=20
> I was actually hoping/expecting you to just resend the renaming
> rebased on top of 3.15-rc1. Or maybe you could do it on top of this.

Yeah, I was kind of hoping that this movement of files would be done with
sooner rather than later ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__17_Apr_2014_13_24_31_+1000_Zqvi3X5.oW9xi/wN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTT0l0AAoJEMDTa8Ir7ZwVP9UP/2VrdEaRf8sFG53wvKk26jwa
EpUGoUlbCmS/d2zOWonrZwhS5wNLG6Fu3mysq3cH0TJo6U05hdW61cSVQck7VrCX
mCKTntkjOAKm/WNfTKIKpaaBnn70uQQQtxmXczCokGlCilwF9dqW3JhyC5NDjPrx
63mReFaXqzoCBHCj4TjC2y/M3QGZ/X5GiGYeR/phFrc8zRA3WfQUH/KL+0CaGlcQ
H1elDdUtqEi35/jgUX5gRoetKprb3CW7mZdch2JNlq3z3ZRhLnlv6JvgZyMOXHHy
driALBlFOUSv/R9f3Y6IzZW8vYiBzMYuEuIKegiIvMww9kt5nfzd5WNtSPx30jpE
xuvt0hE/U4TfUOZqUoDBpMRyGI2R/8F9a7/idxZUdG5rXX4w1qjatfxg6By4kLDf
d0DjP5MIQELmecrm8S9DuN6se3fLqaabboVC5YpCcyLwkNZWXh/LfwLxeC71wAFa
yx3BZS6ktS/Wx/9JisZpcZqiHWmuzVdZ7rxw4AZlGvM2Mw4vRQfowb1L5ST8kSpl
y40w/Ty3KNIjGSY3TPFuP3ky5ueZbKsHHem/2oVyu91pA9ZOE9SFAXP+Aua7cNu9
MKH7PfjZFkg5X9+yAPzZ6Dr2GqbTP1KMHIqfHtwNxuWsAalEQyoqQOf8YMgE3BjS
52faVk0Lo0pi/8JAIst4
=82a+
-----END PGP SIGNATURE-----

--Signature=_Thu__17_Apr_2014_13_24_31_+1000_Zqvi3X5.oW9xi/wN--
