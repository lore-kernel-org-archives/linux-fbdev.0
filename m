From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 26 Aug 2014 13:19:48 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140826131948.GK15297@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dYbRCasfhpyZLUd7"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com> <53FB555E.5040409@suse.de>
In-Reply-To: <53FB555E.5040409@suse.de>
To: linux-arm-kernel@lists.infradead.org


--dYbRCasfhpyZLUd7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 25, 2014 at 05:25:18PM +0200, Andreas F=E4rber wrote:
> Hi,
>=20
> Am 25.08.2014 15:47, schrieb Hans de Goede:
> > On 08/25/2014 03:39 PM, Thierry Reding wrote:
> >> On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
> >>> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
> >>>> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
> >>>>> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
> >>>>>> If not, perhaps the clock driver should force the clock to be
> >>>>>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
> [...]
> > As for the suggestion to simply never disable the plls / ahb gates by b=
locking
> > them from ever being disabled in the sunxi clock driver, that is not re=
ally
> > a solution either, as we want to be able to turn these things off to sa=
fe
> > power on screen blank once control has been turned over to the kms driv=
er.
>=20
> Without wanting to take sides on the simplefb matter, can't you just use
> clk_ignore_unused in bootargs to work around the issue at hand?
> That's what I do on the Spring Chromebook.

Leaving *all* the clocks enabled just to workaround a driver failing
to grab its clocks doesn't look like a solution either.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--dYbRCasfhpyZLUd7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/Il0AAoJEBx+YmzsjxAg1CoP/3UDwlCtLT45Pe997OIgFwva
ecRX5YaGqCOUc6B7MJoTm2GGd2Ij432RKNu2WqMgmEZukfCMUE2x4s3QfhFbZe/f
eRfGYgZrYCA8jaUp+zT6y2qp3LOim2tXXNRi5BNN5oneZNORQkEjFpdks8SSUrb9
dtjLZYtftsGXWmi2lDj2a00O+UbnQD9HOjH2irv3t04m4G1tDiyr09Tn70ZMhrC2
E1qCi/EC7SNTD9AJQUuSFsZvb3k5R97zrQwNnl9mr2Rpsl8mqIF0ognA+Ajszje9
2aINNANUm1aL+tAfziS+PMA2JrLe0hnbqcYNbW4SZgauuBMiRvvQbwsqGkKygxkD
yr9SWtlT/MLwDrTfG9f3BS3NkmsrPzQqYxRlUqX+OVmT2vV+D3KdULmgDlm7W7i0
iHqJ54kNxDezXYE8yyf+pTJ0m7n5iNF2hpAfSTwY/UAVLEpmCANo/YHHJ5e/Bnz9
/+5xaWIllAxIENtv2lXvzY7058jxTRF1+IjZ4+INJAMdDQAsMkpGQHQsI4v62ZUn
RglnQwmcVGrS+Pbc4gfcyGB/tn7mxi3RB12dLsSj7NIWG5PvKzrO0qjU59AvrRTM
Q5pzf0RmQnSRU3/xaa5BXqrS74EXSQuM6WcXq2oU2eILtg1THQ8fWjBg/oGP2jNd
H9LG6RQCTUuFmKTKqSpi
=zAXj
-----END PGP SIGNATURE-----

--dYbRCasfhpyZLUd7--
