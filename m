From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 09 Jan 2017 08:17:07 +0000
Subject: Re: OMAP3: DSS questions
Message-Id: <94ec010a-b8e7-0d65-3bb3-ae39fbcee14d@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oG6b4GWVotmakvUtMov3685ebdII0LEdB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAGm1_ktY3djv8yp3e+w-DmtFa_9HmEkXn-d1e4AKsPGnES_Rrw@mail.gmail.com>
In-Reply-To: <CAGm1_ktY3djv8yp3e+w-DmtFa_9HmEkXn-d1e4AKsPGnES_Rrw@mail.gmail.com>
To: linux-fbdev@vger.kernel.org

--oG6b4GWVotmakvUtMov3685ebdII0LEdB
Content-Type: multipart/mixed; boundary="WRkvAaf8QjhOFRJ11daajLTikaFxfsSMM";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Tony Lindgren <tony@atomide.com>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 linux-fbdev@vger.kernel.org
Message-ID: <94ec010a-b8e7-0d65-3bb3-ae39fbcee14d@ti.com>
Subject: Re: OMAP3: DSS questions
References: <CAGm1_ktY3djv8yp3e+w-DmtFa_9HmEkXn-d1e4AKsPGnES_Rrw@mail.gmail.com>
 <20170105164921.GF4310@atomide.com>
In-Reply-To: <20170105164921.GF4310@atomide.com>

--WRkvAaf8QjhOFRJ11daajLTikaFxfsSMM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 05/01/17 18:49, Tony Lindgren wrote:
> * Yegor Yefremov <yegorslists@googlemail.com> [170104 08:27]:
>> I'm trying to get my am3517 board working with 4.10 (porting from
>> 2.6.37). An LCD screen is attached to OMAP DSS using 24 bits. Display
>> config looks like this in [1].
>>
>> What DTS options reflectes ".acb =3D 0x0"?

acb was only for passive matrix panels, which have never even been
supported. So you can just ignore acb.

>> Btw. I just need a frame buffer device and will use it with Embedded
>> Qt. Should I nevertheless use DRM flavor as it already provides frame
>> buffer driver?

Depends. If you somehow rely on the custom ioctls from omapfb, then it
might be easiest to use that. However, it's no longer developed, so I
suggest at least trying to use omapdrm first.

>> drivers/gpu/drm/omapdrm/displays/panel-dpi.c performs either platform
>> or OF initialization. Platform flavor contains data_lines info, OF -
>> not. As I'm using OF flavor, how do I get proper data_lines info?

With the endpoint's data-lines property. See, for example,
am437x-gp-evm.dts.

 Tomi


--WRkvAaf8QjhOFRJ11daajLTikaFxfsSMM--

--oG6b4GWVotmakvUtMov3685ebdII0LEdB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYc0cEAAoJEPo9qoy8lh71/QsQAIp+XTSJ12Go2B6+eT6Y61zD
sf2styBe6jww+AnJeJHPhlumk0Un1wQvf9XVFXjRvNohFDuEImnfGIm/2uFI6g/6
PigDyBeRs1VPWt9rNIUBXTKJH8kZr3Yrxp60+I3uKKu7VI0XKF13atQ9wvtusHs+
7nCEpADoFcWsacu35OGC9vTJJCvPoHSuh/GpqNamjYaSPnI98T8NfYAeEOewoFe+
dMaRLYkUJuGy4n9SDGX8Sw40B+yp3QqB6xvEYP1Yk/oOci1DbkX6oiJkCj9kF/MX
8Omaws16TJMyI5SnwMmB1Hmi0ac6chL4iF7oqKG9fDS0aep/pEOp5QymuU5fWv5r
rTqv5huRzoPnrjL00TrQ1ncAnrO9lFz5e0pgjIVyqSPcHFgU8CQgF3rdCuARB3AF
rnR90UMgSwSpKUUAZd/EYGPuRzezPUOgTM+kUIe7hSKNCtTB8q0L8o8D+5YVIy6x
uH0I6AH32PHuxfjWG7s1AgiKSVBG+grG3DWLJmx+j5yebKMFl2yWvSqE/Qq1Hitg
5ARiTa4EfQ+L3SXykDou5yXbwSpGQA31pp8mNLEfVIGLFLKrsa05F6oCq8oSmn9E
vi60oJFWL/aAhNpPRn/IwZtCZOOu1zHSUoWO7uHXrC3Mze/0KGR5mqO9+yrHXqpH
e0fMNKwuVg5n/2MQirIR
=VlbF
-----END PGP SIGNATURE-----

--oG6b4GWVotmakvUtMov3685ebdII0LEdB--
