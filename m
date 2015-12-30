From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 30 Dec 2015 10:32:00 +0000
Subject: Re: [RFC PATCH] fbdev: add support for Sigma Designs' smp8xxxfb.ko
Message-Id: <5683B2A0.9090901@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Q6gR7eidhICVfo7NIEkofQ0WMF0sp0kEO"
List-Id: <linux-fbdev.vger.kernel.org>
References: <56828767.4050302@laposte.net>
 <CAH6sp9NrvapSMnPq5aagUFG2upf6-H9QJL1bkhMSscDL21Q-EQ@mail.gmail.com>
 <5682936E.2040904@laposte.net>
 <CAH6sp9OvJB+OPDPMWkEyNADcwO19N2=8U-5q49GrCmQTYObb_A@mail.gmail.com>
 <5682BA0B.9060001@laposte.net> <5683908C.5040001@ti.com>
 <5683A48C.80203@laposte.net>
In-Reply-To: <5683A48C.80203@laposte.net>
To: Sebastian Frias <sf84@laposte.net>
Cc: linux-fbdev@vger.kernel.org, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, mason <slash.tmp@free.fr>, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, laurent.pinchart@ideasonboard.com, Frans Klaver <fransklaver@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

--Q6gR7eidhICVfo7NIEkofQ0WMF0sp0kEO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 30/12/15 11:31, Sebastian Frias wrote:
> Hi,
>=20
> On 12/30/2015 09:06 AM, Tomi Valkeinen wrote:
>>
>> Also note that I don't want new fbdev drivers into the mainline kernel=
=2E
>> You should implement a DRM based driver instead.
>>
>=20
> Thanks, is there a porting guide to go from fbdev to DRM?

I don't think you should "port" the driver from fbdev to DRM, as the
frameworks are just so different. You should implement the driver from
scratch. Of course, the bits of code that actually touch the hardware
can possibly be copied directly.

Kernel docs contain documentation about DRM, but I don't know if there's
really a "how to write a DRM driver" style documentation. There's an
active mailing list and irc channel, though.

> Does DRM provides a "fbdev" backward compatible API? Would that be
> feasible?

DRM provides an fbdev "emulation". I think it's mainly aimed at
providing fb console, but many fbdev applications should work fine on
top of it.

> I did not find much about that.
>=20
> Currently our stack is something like:
>=20
>    Qt -> eglfs -> Mali -> fbdev -> mem -> output
>                   (HW)                     (HW)
>=20
> We don't control the eglfs/Mali (GPU) part.
> From what I could see, Mali uses DRM with X11 which we do not need
> (note: I'm not a Mali expert and just took a quick look at the code so =
I
> may be wrong), which could be a problem.

I'm not familiar with Mali, so I have no idea.

> If "implement a DRM driver" is a lot of work, it would end up as a
> business decision and probably would not happen.

True. It's, of course, up to you. If the fbdev driver works fine for you
and provides all the features, and you're happy with it, and there's no
requirement to get the driver to the mainline Linux, there's not much
point in going for a DRM driver.

> Would you say there are good solid arguments to shake our current stack=

> (other than for dusting it off)?

Fbdev is the legacy framework, hopefully deprecated at some point, and
DRM is the current display framework. So DRM has much more features, is
actively developed, has a community that may help you with your issues, e=
tc.

=46rom purely technical point of view, it depends on the hardware in
question. If the HW supports hardware overlays and multiple outputs, DRM
supports those fully, whereas fbdev does not.

I'm not that familiar with the 3D side, but I think that can be
implemented properly with DRM, whereas on fbdev supporting 3D is always
more or less a hack.

> By the way, does DRM improves 2D acceleration support over fbdev?

I don't know enough about 2D acceleration to answer that.

 Tomi


--Q6gR7eidhICVfo7NIEkofQ0WMF0sp0kEO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWg7KhAAoJEPo9qoy8lh71+lMQAKH4zLSw1hYyH7Ulyx2LcMjM
Emmp0AAbrdrWFg3J46hNuHORvnINJihpwbSiZsTqZAnhdpjY6noKTWbvZ63nybim
UbOyLUgCnjHlboDXtv/o9rjnNOmQQppBhnmjbewp5dC15qrI4um70zubh/+SCBQy
T30CZRfo6tP/eYXt3nxBZ8GuySvNU40YCNHtt+pwal6EtCYv297HO+cm30AG1vrc
TumM5/SaM/i0P/A6WgRyYdDAulAZgAIDSn/3iR5GXUX8jRGMBPTN1eL+REfh2L8K
aF83f6viVNBqio1v4bcjvBfEuABCiOk4/bnI/fFh++KOMC0L2OlIILGAQEyTnvbe
moehgluajeKWIbKJ1dSs0Lox3Ps2Y1kstUjonBeA/21cNTijxjCr4RRH5M9PWtv1
vUN/fYF7b0Te/pQk/HGHq759jX+zWps1iuP+bkVk61YExcaYu4wrVqEMMIW70+yM
BoPd+45fZxZAFQW5LVfvKhh0qjMgtoI3I7nblVk5VzbT4oI085uk/jsFSyjsbzFP
7OeKAxkMZb555+iHNahmbPTO0OSOgARSzT+/DQ1gf4BR+qfR0I6flQhuLkum2G0f
VwhLHEqpQpemWM8fY7Ddgmq3z04eWynK5sJ3dLWNXOEm/aFHQK/LQetLYHQ018t+
p/tIYsJZHMnhTzOaTEaD
=LWmf
-----END PGP SIGNATURE-----

--Q6gR7eidhICVfo7NIEkofQ0WMF0sp0kEO--
