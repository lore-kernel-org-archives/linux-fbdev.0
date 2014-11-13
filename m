From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 13 Nov 2014 10:42:03 +0000
Subject: Re: [PATCH 3/4] simplefb: Change simplefb_init from module_init to fs_initcall
Message-Id: <20141113104203.GF20972@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="yRA+Bmk8aPhU85Qt"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>
 <1415830124-28787-3-git-send-email-hdegoede@redhat.com>
 <20141113085238.GE20972@lukather> <546478B5.2040002@redhat.com>
 <CACxGe6u8B854PEWw8XzwhyX8joMWwOsHOOXtmBmC1TgCGjGtdg@mail.gmail.com>
In-Reply-To: <CACxGe6u8B854PEWw8XzwhyX8joMWwOsHOOXtmBmC1TgCGjGtdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2014 at 10:29:52AM +0000, Grant Likely wrote:
> On Thu, Nov 13, 2014 at 9:24 AM, Hans de Goede <hdegoede@redhat.com> wrot=
e:
> > On 11/13/2014 09:52 AM, Maxime Ripard wrote:
> >>> +/*
> >>> + * While this can be a module, if builtin it's most likely the conso=
le
> >>> + * So let's leave module_exit but move module_init to an earlier pla=
ce
> >>> + */
> >>
> >> Not really related to this patch itself, but do we want to support
> >> simplefb as a module? It seems like it's going to be most of the time
> >> broken.
> >
> > A valid point, my mean reasoning here is that some may see not being ab=
le to
> > use it as a module as a regression, so I just kept things as is, but I =
do
> > agree that it is advisable to just build it in.
>=20
> Like a lot of things, if it is made a modules, and it breaks for the
> user, the user gets to keep the pieces. There are potentially some
> valid scenarios where it is fine to have it as a module. I don't
> recommend changing this unless is actually starts causing problems.

I don't really agree here. If it's broken because the clocks, reset,
memory, or whatever resource has been reclaimed by the kernel before
the module even had a chance to probe, the only thing that the user
will get is that there's no chance it's ever going to work, and that
it's just unreliable.

If we know that it's going to break, and that there's no way it can be
reliable (as in on all the SoCs reliable), keeping it as a module is
just asking for trouble.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZIr7AAoJEBx+YmzsjxAgSccP/RI59EUGactEAMDhskesOqwa
psXnHuoo/zBauzyWFJUXD1Jv9SglUghzjkDj5Hy+iaxt6VTZr1iMVHZTfm3o1gE3
lBH97NFLk5S4MzCOTb7hI2lCXtFLd88Jq8BblL356HFjGC9k9+ofTSXYrGAhayNy
3zKmRA2mfsA1VWo+8W6EFwU7VpQoR64s1T2Cx79GHPGFIvfixZKclDwKPc2Jv4FE
9bE95nQxet/8gaG20e58uttyi7rheXahj76hvd7JANvONrbaFYE/AqLV8VzCd+gP
7HcKtSpF1QB88vCYDvuMZiz1JvZRlf+x/CZdfMV55ev3DbYrClVwQ/YK5cG/9nMr
Wojv5BIIX26c7epl8vLytUrCWnuQblUG9Kit+Ud2TLiiRJuxFG/+GUNCM56avleO
5XtFZ96w0OKhXqAUzbP3/GDmhlTgNYB1JXX/yCZlWrpcZC9ZYu8eXkow5NCQT/E5
NkMhW8wrpchhFrRf+J5qT8+NPgawe684RAM7giVYnoJ7Tg/ITQiSJoDTemEJ9fAz
hUAtAshtYjVN02/UdGCfoIonmSd4drw/5lCHRhB2DAhAQHCryyRFUrg63F+7ZWi6
NXCyvBT5ODlkGk0iktXyB7DkhWc1vX+Qi6ofCj3YTyfLLQZ/X9NethT5FvG9S2cS
yqSMACWqhQuySMRtlxDk
=LOgH
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--
