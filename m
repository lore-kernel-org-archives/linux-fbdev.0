From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 31 Mar 2016 17:11:08 +0000
Subject: Re: [PATCH] omapfb: Fix regulator API abuse in dss.c and hdmi4.c
Message-Id: <56FD5A2C.7090608@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="16bIpr2xSveQMUB9CIQV5mAs4NHFa1JpS"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459355376-28507-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1459355376-28507-1-git-send-email-broonie@kernel.org>
To: linux-fbdev@vger.kernel.org

--16bIpr2xSveQMUB9CIQV5mAs4NHFa1JpS
Content-Type: multipart/mixed; boundary="nHkohoXvserSsq30iS33CBFHeVILVTwDO"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
 linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Message-ID: <56FD5A2C.7090608@ti.com>
Subject: Re: [PATCH] omapfb: Fix regulator API abuse in dss.c and hdmi4.c
References: <1459355376-28507-1-git-send-email-broonie@kernel.org>
 <56FCC3F3.7060907@ti.com> <20160331164953.GD2350@sirena.org.uk>
In-Reply-To: <20160331164953.GD2350@sirena.org.uk>

--nHkohoXvserSsq30iS33CBFHeVILVTwDO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31/03/16 19:49, Mark Brown wrote:
> On Thu, Mar 31, 2016 at 09:30:11AM +0300, Tomi Valkeinen wrote:
>=20
>> This code did fix an issue, see 02b7a32083b9930543663720758de249b4f6a2=
a3.
>=20
> That change isn't sensible, especially the _can_change_voltage() like I=

> said in the commit log.

I may remember wrong, but I think regulator_set_voltage() failed if
regulator_can_change_voltage() returned false. So I ended up having the
'if' there. But I may remember wrong, or maybe it's been changed since.

>> Now, even at the time when I wrote that fix, it did feel a bit odd to
>> me. I have to say I don't remember the discussion that led to the patc=
h,
>> perhaps it was something along "yes, the driver should not need to do
>> that, but for the time being do it".
>=20
> That wasn't a discusion I was involved in, a quick google suggests it
> might've been off-list.

That's possible. With quick googling, this may have longer history than
the patch I sent.

>> So where are these "machine constraints" defined?
>=20
> They're the DT.  Your machine constraints just seem broken and need to
> be fixed, most likely whoever wrote the constraints for the platform
> completely failed to understand the purpose of constraints and filled i=
n
> the maximum range of voltages that the regulator in use on the board ca=
n
> support.

Ok.

Tero, Tony, with a quick look, for example omap5-board-common.dtsi
defines ldo4_reg having range from 1.5 to 1.8. That should be changed to
1.8 only, right? ldo1_reg has a range too, I'm not familiar with that
LDO's use, but it's for camera so my guess is that it should be 1.8 too.

I can have a more thorough look tomorrow, and do a test run on omap5
uevm (with Mark's patch).

I wonder why we have the same code in hdmi4. Again with a quick look,
omap4 boards seem to use vdac for hdmi, and vdac doesn't have any
constraints in twl6030.dtsi, so I presume it's a fixed-voltage.

Anyway, I'm happy to apply this patch (and we need similar for hdmi5,
and also for omapdrm), we just need to do any necessary fixes to the
=2Edts first.

Although strictly speaking, I guess that's breaking backward
compatibility...

 Tomi


--nHkohoXvserSsq30iS33CBFHeVILVTwDO--

--16bIpr2xSveQMUB9CIQV5mAs4NHFa1JpS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW/VosAAoJEPo9qoy8lh71neMP/RzIJsuI3evCfWoMlcWaAYkS
hRcPODnkzr/+CK01X18xU3Ur0BeICluuD2VsJzlBDie2YZKxai+p/m2fNmSq5cgG
V7kjQgtzvfka3Wk4d6/4SvVvSDEMcyKeXTesspj5ZD65G+hdzjoC9NPRZEmT5Xuv
UpPejFXR9JfzGQq+hg0HZJtdzutJ0bK2M4kBoEDUxU/ZYKyo+RNUx6NEkuF4YME6
CAPcWk5TUIDwyig6mF9JHgXDSiJeSFX4rqnpI3q0ath52OwqxCISrhR9WHTgunxf
XKw3J869Iy+I70Tjps2XJfmIZ43Q/egJLEP5iTHoa7kg+VDo2sH4Ve8gRu32PWk2
PJ723ElNK0nUC3cCKYYHXqMYc08JDlKIabGlTbHHcO+IucoEGBiulg11bk5hup7q
7gG8Fane5/I1kkWxa1CtaOtp/8fmYfqsP4w2X55OO1qLTNRVcw1+dfXkh8DkR3WJ
QKiwuCeWNm6uYFL7GPik2od81OJ7wbQuTY9jrdur1OeR4iqx9W6J1Qax6A/ZzFcg
IV+BkiHJ7qvFydEp4HBSdEdlzM1mDLGW/JE5YXYAdb49+jqiYFMbG5C5DL/aIff8
NRkOxRGRVfWeJ6g2HbvhZn6e9YUC99CSc2VQ9ukpxZr2IPXWuFVekGfWcZVaEQ7M
1MJJ21r+UB90DaHsHPKx
=vdxm
-----END PGP SIGNATURE-----

--16bIpr2xSveQMUB9CIQV5mAs4NHFa1JpS--
