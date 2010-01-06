From: James Simmons <jsimmons@infradead.org>
Date: Wed, 06 Jan 2010 17:48:18 +0000
Subject: Re: 2.6.33-rc3 -- Intel 945GME (inteldrmfb) -- Two Tux images
Message-Id: <alpine.LFD.2.00.1001061747250.5372@casper.infradead.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1985284609-1967267537-1262800098=:5372"
List-Id: <linux-fbdev.vger.kernel.org>
References: <a44ae5cd1001060916s4db1d94fsb7e012ab80ce6add@mail.gmail.com>  <alpine.LFD.2.00.1001061736080.5372@casper.infradead.org> <a44ae5cd1001060942p7672768yec3b1f5ea2426682@mail.gmail.com>
In-Reply-To: <a44ae5cd1001060942p7672768yec3b1f5ea2426682@mail.gmail.com>
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, linux-fbdev@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1985284609-1967267537-1262800098=:5372
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> On Wed, Jan 6, 2010 at 12:37 PM, James Simmons <jsimmons@infradead.org> w=
rote:
> >
> >> For a long time I have gotten two pictures of Tux showing up when I
> >> include the Tux display option in my custom kernel builds. =A0I don't
> >> know how many kernel revisions ago it was when I started noticing
> >> this. =A0It seems like it might have been early in the 2.6 series
> >> kernels.
> >>
> [...]
> >> # Frame buffer hardware drivers
> >> #
> >> CONFIG_FB_VESA=3Dy
> >> CONFIG_FB_EFI=3Dy
> >
> > Try disabling these two above options.
>=20
> Well, that means that I don't get Tux at all.  The point is that only
> one copy should be displayed.

I thought you had KMS enabled?? That provides a fbdev emulation layer.

--1985284609-1967267537-1262800098=:5372--
