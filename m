From: krzysztof.h1@poczta.fm
Subject: =?UTF-8?q?Re:_Re:_[Linux-fbdev-devel]_[PATCH_4/4]_cirrusfb:_fix_error_paths_in__cirrusfb=5Fxxx=5Fregister()?=
Date: 25 Feb 2009 10:42:10 +0100
Message-ID: <20090225094210.5DB9D9F34DD@f34.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/plain; charset="iso-8859-1"
To: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foun>

Geert Uytterhoeven napisa=B3(a):
> Hi Krzysztof,
>=20
> On Tue, Feb 24, 2009 at 22:37, Krzysztof Helt >krzysztof.h1@poczta.fm=
>
> wrote:
> > It is not an end to cirrusfb patches unfortunately.
> > I have just got a GD5446 (Picasso4) and it locks up
> > my computer when the cirrusfb module is loaded.
> > Time to fix this model as well...
>=20
> Cool! Which Amiga model do you have?
>=20

I do not have the Amiga computer. I have a PC (x86) PCI card GP-5446.=20
It does not work in the PC.

> The Picasso4 is also not yet supported in Zorro II mode. There are so=
me
> docs
> available (it&#039;s just about using the right offsets), but as I do=
n&#039;t
> have the hardware,
> I never did it myself. Christian Steigies is probably most interested=
=2E..
>=20

I promised to compile Amiga kernel for user who reported problem
with Picasso4 (Amiga computer) card in January. I want to build=20
Amiga kernel for him (and anybody interested in testing=20
with Amiga computer).
I want to fix the chip handling on x86 first (correct register
values for modes, line pitches, offsets, colors etc.) then
try to help Amiga guys.

Regards,
Krzysztof




----------------------------------------------------------------------
Strzelec, Byk, a moze Panna? Wszystkich 12 znakow zodiaku!
Sprawd=BC swoj horoskop na dzis >> http://link.interia.pl/f2051

--
To unsubscribe from this list: send the line "unsubscribe linux-m68k" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
