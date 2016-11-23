From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 23 Nov 2016 09:12:32 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <230111fb-498e-11ef-b452-157a36d7f021@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wJExOlwnHt4QVJSse1PoGUGKpQSqLqI6s"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <20161123085234.GB3122@kroah.com>
In-Reply-To: <20161123085234.GB3122@kroah.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

--wJExOlwnHt4QVJSse1PoGUGKpQSqLqI6s
Content-Type: multipart/mixed; boundary="6Wk9MCDbOHDe7l66bml4VLWoBR9k4evuM";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Teddy Wang <teddy.wang@siliconmotion.com>,
 Arnaud Patard <arnaud.patard@rtp-net.org>, linux-kernel@vger.kernel.org
Message-ID: <230111fb-498e-11ef-b452-157a36d7f021@ti.com>
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <20161123085234.GB3122@kroah.com>
In-Reply-To: <20161123085234.GB3122@kroah.com>

--6Wk9MCDbOHDe7l66bml4VLWoBR9k4evuM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23/11/16 10:52, Greg Kroah-Hartman wrote:
> On Wed, Nov 23, 2016 at 10:03:10AM +0200, Tomi Valkeinen wrote:
>> Hi,
>>
>> Since the fbdev framework is in maintenance mode and all new display d=
rivers
>> should be made with the DRM framework, remove the fbdev drivers from s=
taging.
>>
>> Note: the patches are created with git format-patch -D, so they can't =
be
>> applied. Only for review.
>=20
> I only want to remove these drivers if we have the same functionality i=
n
> mainline for their hardware.  If not, that's a bit rude to those who
> actually use them today, don't you think?

What does it mean for a driver to be in staging? I thought it's
basically the same as the driver being out-of-tree, with the difference
that the code is in a central git repository for easier co-operation.

If that's what staging means, then I would reject the staging fbdev
drivers the same way as I'd reject new fbdev drivers sent as patches to
the list.

Or do you mean that we should keep the drivers in staging until there's
a matching DRM driver, but drop any plans to move the drivers from
staging to drivers/video/? If so, I'm fine with that. This is an RFC,
mostly to raise some discussion and push people to actually write those
DRM drivers =3D).

 Tomi


--6Wk9MCDbOHDe7l66bml4VLWoBR9k4evuM--

--wJExOlwnHt4QVJSse1PoGUGKpQSqLqI6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYNV2AAAoJEPo9qoy8lh71mCkP/3z6+YCPS5oOTw140rZinWAB
CuJIyaQGqBFcUhWzU+3g0pOEUBRDGdRcV5I6M1XdwcDCEo5B+REMq2E71IdDkrJm
ouEf3ppdrGtBBV52//DHLHaPrAxFkvYGyosbO8DBvg2dipPjE7x1P7DidbV29fZ/
9xScLL1C8HB59sPjaddeQGsvghdvO6R0BJV0ifs/etxIjAB3bMOhtVMOdrokW0mz
hM03dM1hJTk/zOyhmAiGhgNs1PD4D83Ae1CVrzUPHu6E/yjtlMx0i+BPW436FhqH
zhQZIIhfZcH1RpvyTXnEkjaRUSjPM+oD4ZUptc7E9NNJ/WWHTYErfc4I8/GyzvjI
dBil5pf8PuWpUVEKnreQP/uj+IOVHrW4/PfWKLa6Cx9rmhz7/g0XIctb1ObafBQp
/JiOceuvMzTDEnCgC58NzjvRfZ0+cr7TzLG2E84DqGMMTcYaW7AyAMbpeMDA7xbF
7rRJknjVZZSOQO8KnWqoFnC+rc25ab9n5yWcx8jyiPsG2XD2goD0YeiW95REcSoC
ttGIkXA8OGSm8C9KqeAZCkQEtm55T7USK+JQNY/84kxMsAz9y3gbZmZlqkhr5Aj7
AK5kbjkLAxhDu7tBRrVJ6ul8mF6FCvVsfqeTTFnm4RIa442Rik7Vl2vXhiBT9hXm
NJbd3treKMF1TUL6LlF/
=h2CK
-----END PGP SIGNATURE-----

--wJExOlwnHt4QVJSse1PoGUGKpQSqLqI6s--
