From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 16 May 2014 05:56:56 +0000
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree support
Message-Id: <5375A8A8.7080306@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MMj86lUMqo3tX5of2bpS3FILk5gpEg1Pi"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CABxcv=mY0a+yJgmCTPN=BhSQD57Pw022zOd5_KxEgvvF_-=O7Q@mail.gmail.com>
 <20140512142646.GA31772@atomide.com> <5370E0C9.8050201@ti.com>
 <20140512155132.GH31772@atomide.com> <5371F923.80000@ti.com>
 <CABxcv==_LCw1kPYm17g=h8VfSN2V_qsgXjTnsy-JOetawSv4pA@mail.gmail.com>
 <20140513152518.GA16837@atomide.com> <53730AFB.2090800@ti.com>
 <20140514160216.GD18463@atomide.com> <537487AE.3060906@ti.com>
 <20140515182133.GC23659@atomide.com>
In-Reply-To: <20140515182133.GC23659@atomide.com>
To: linux-arm-kernel@lists.infradead.org

--MMj86lUMqo3tX5of2bpS3FILk5gpEg1Pi
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 15/05/14 21:21, Tony Lindgren wrote:

>> But you're right, having "sharp,ls037v7dw01-omap-dss" in the .dts is a=
n
>> alternative for the compatible-string conversion we do now. I guess it=
's
>> a matter of taste, but I rather hide it inside the kernel, in an
>> internal omapdss file, than pollute the .dts files with those compatib=
le
>> strings.
>=20
> Well it avoid you parsing through all the nodes during booting
> and leaves out the function to do remapping. And removes the need
> for maintaining a custom display mapping table. I'd say that's a
> pretty good list of advantages right there :)

Yep... I don't know. Maybe I'm being too careful about doing wrong
things with .dts. I just like it more if any hacks are in kernel code,
which I can remove without anyone noticing.

Anyway, we already have board.dts files using the non-omapified
compatible strings in the mainline, so if I would now add the omapified
compatible strings to .dts files, those old board.dts files would break.

So I guess the choice has already been made.

 Tomi



--MMj86lUMqo3tX5of2bpS3FILk5gpEg1Pi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdaioAAoJEPo9qoy8lh711TgP/R5iokLg9Po70K6hdxxyYeyI
urrzDsnvRfm6rQ8MAvKp/rHPRT2YzQ5zaulPXGA17XRV4Z5qRSlPYhYfxV7I6nTZ
UjvLLQCX+WvAuAK8SR9SLidoIMCTZFN+2UyZODlPr/mwFxdrtUZ1ncMBNPyraiCq
0M5VK+Wd/wMsBuCtN6lwl/MQoHuxNlmxyBaLJPPOi+/Zh4cwwGmcyHHdHevpI2e8
7KKhvd1+i0SiXunDdfWGOm7erdLX1L93vpiQKRh83Kb+mTO2cdd/zwmQCvUvJQZO
A3v5q5/fgA931gHYsBspZ24eEnM9zBqB9G0bJt0KpueZzvZTZS7lJlsoOWHKc6un
nwZrdn4GCDIFYlJYO2jt8dgpF54Qkmut6s2oQu0Sx5PC+nQhhNwc3UtEMb+4xFeU
FPO/yorBTxEvanLXhE213VF7ECPSz5T/d/JxiBMHLWKUYtN0ViQpkXZXaL4ekk08
jlNbAtiLdf0TMARXktu+zFIv1YJDV+uArJl0OZGZw48rFJYKff2+82HQ+YPT1k5H
m4FRL/fOyuMz7xVCd9pKXvmLiSKHJQwDzwf7DSYW39QKMWCGsg3SDFoXFI+z9Kev
OUKl9AApywEWBiYRUpM96yHyPQlWDL7MqjqxF4yC2VzMnBbGQmo2oRTiraX0ofOv
jcyLKLG5UzxETYl6EZOS
=6cp9
-----END PGP SIGNATURE-----

--MMj86lUMqo3tX5of2bpS3FILk5gpEg1Pi--
