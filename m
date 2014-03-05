From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 05 Mar 2014 08:42:36 +0000
Subject: Re: [PATCH 4/9] Doc/DT: Add DT binding documentation for HDMI Connector
Message-Id: <5316E37C.4070400@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vLLaF8Db20Qlea83A62bialKMF6MLL8d0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	<1393590016-9361-5-git-send-email-tomi.valkeinen@ti.com>	<20140228160612.GR21483@n2100.arm.linux.org.uk>	<5310B609.1010105@ti.com>	<20140228163431.GV21483@n2100.arm.linux.org.uk>
 <CAMuHMdVpT2Y-KQO46o=zbRSgqgx2mbBsPjGgoTDDwwfCOxUCmw@mail.gmail.com>
In-Reply-To: <CAMuHMdVpT2Y-KQO46o=zbRSgqgx2mbBsPjGgoTDDwwfCOxUCmw@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, DRI Development <dri-devel@lists.freedesktop.org>, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--vLLaF8Db20Qlea83A62bialKMF6MLL8d0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/03/14 20:58, Geert Uytterhoeven wrote:
> On Fri, Feb 28, 2014 at 5:34 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> There's actually three HDMI connectors:
>>
>>   All three connectors carry all required HDMI signals, including a TM=
DS
>>   link. The Type B connector is slightly larger and carries a second T=
MDS
>>   link, which is necessary to support very high resolution displays us=
ing
>>   dual link. The Type C connector carries the same signals as the Type=
 A
>>   but is more compact and intended for mobile applications.
>>
>> So, Type C and Type A are electrically the same.
>=20
> There's also D (e.g. on BeagleBone Black) and E:
>=20
> http://en.wikipedia.org/wiki/HDMI#Connectors
>=20
> Electrically they seem to be the same as A/C.

I made the following change compared to the posted version.

 Tomi

@@ -3,6 +3,7 @@ HDMI Connector

 Required properties:
 - compatible: "hdmi-connector"
+- type: the HDMI connector type: "a", "b", "c", "d" or "e"

 Optional properties:
 - label: a symbolic name for the connector
@@ -17,6 +18,8 @@ hdmi0: connector@1 {
        compatible =3D "hdmi-connector";
        label =3D "hdmi";

+       type =3D "a";
+
        hdmi_connector_in: endpoint {
                remote-endpoint =3D <&tpd12s015_out>;
        };



--vLLaF8Db20Qlea83A62bialKMF6MLL8d0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTFuN8AAoJEPo9qoy8lh71VkYP/2PApyt8wxafxXNzKuHOKnt4
NoYDDJVPdDB63JpMBCA59mOT+xp8ghLC34REb7/l0bNV8IMzGE4ht9l8Dj/nm5fe
m/+lSdnXyh9NKFjk4NQCjh0yPkqu0Qb/1/jRHqnjMCj6OhDpt71DmtUSselLWYui
Y6O3jOokPjhi/BFbBVkCG/XYtX/OsuFwT5NeC/Hjefp7l809CQ2nhr/xOxWnO8ab
3qDuDLlQMJlK78AeemhrB7d+Os1QfIufQM/3b2d9MtqkHesS8wdUe5fd42ilCK3U
ycllvmtzfO8ohLpkJejE3KplJzQM6Afilo5ADe3lQjIR7tRb9FzHDLKpt95U2Q6L
kALVCc07lbbBWDmWlxCKxNPOXlZxJ0bToCz1SuSFIqZPwifkj4uFErLliJFHIFYu
O7Vla1AjVAea3PBgvnNVjdhXc9BIW2yjMG0p0FarfT6RTrIuTtrcKXk8E9coGHzX
aja7sPds+XhjZi8vR5WidGtZPYBfFVXbQx17gMAq7a47qBwt1z0MPU0Vp3waoZlN
E1I3+iKEtIwQM1unu3M/J34V0HALCG/B+69B+InCpPNQjuSPWqLgeVmWZEDgeGzG
JJUAC3KoaIQym1kTdAUgcC02sNJusx1qJe0nc71IAyj8+JpO+N5UxOV7PUyyNcrE
fSKFMYbjtW7WxBHOFttc
=w9n6
-----END PGP SIGNATURE-----

--vLLaF8Db20Qlea83A62bialKMF6MLL8d0--
