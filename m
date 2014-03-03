From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 03 Mar 2014 07:23:05 +0000
Subject: Re: [PATCH 4/9] Doc/DT: Add DT binding documentation for HDMI Connector
Message-Id: <53142DD9.4020709@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tX7KBMdIlXs3671UlqlmJWi4Fg0xrbfsd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	<1393590016-9361-5-git-send-email-tomi.valkeinen@ti.com>	<20140228160612.GR21483@n2100.arm.linux.org.uk>	<5310B609.1010105@ti.com>	<20140228163431.GV21483@n2100.arm.linux.org.uk>
 <CAMuHMdVpT2Y-KQO46o=zbRSgqgx2mbBsPjGgoTDDwwfCOxUCmw@mail.gmail.com>
In-Reply-To: <CAMuHMdVpT2Y-KQO46o=zbRSgqgx2mbBsPjGgoTDDwwfCOxUCmw@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, DRI Development <dri-devel@lists.freedesktop.org>, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--tX7KBMdIlXs3671UlqlmJWi4Fg0xrbfsd
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

Right. And then there are the HDMI versions, and things like HDMI
Ethernet Channel. After looking at these a bit, I don't think the HDMI
connector needs any of those (hdmi version, eth) defined.

So...

	compatible =3D "hdmi-connector";
	type =3D "a";

Or

	compatible =3D "hdmi-connector";
	type-a;

I don't right away see any big pro with either one compared to the other.=


 Tomi



--tX7KBMdIlXs3671UlqlmJWi4Fg0xrbfsd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTFC3ZAAoJEPo9qoy8lh71Gi8QAJNA6Hu8ubL7yiO5jzr6kxSc
Yx/d8O/HngrIW4IGCfECdwBIMk3HOW7DGuSu9CkZk5N3LB4DT8INOTc31U5aDzvK
bT7LGhJTWTJODRvvGwIURoe5tnhOW+z+RFxA9AtueNiC3SXQj8JdPBeLL7BTVvnQ
nOsJU2qTQ3qaGjYWqZxdCn+kpaglV57eC/NMhsmewdl0R4nfdHEPYlCrGtA2+XwW
C4lJQOrCkcJDjxcD3HGcaMcTrq9+IflnLYrE1KL7jgQcQlYE1NFfhC+UxD4d/LKB
cnBnlwAHmB03u16wW8z4fzYqpjVDrlop/gXr7cpueh1+FcyUsOBW0x0sGF06mjvI
43TjkP2AQHy+Pognl2Km4djq+FdQgTAy/y5UyqlqhKoT9gZl4eH+PlXVa4JmAua6
HfEYB8/+mVNm/tlE/E3aLRMKVjG+U8OHloCf7tDtdmu+tNdFTlCKrRTkzG5dghEJ
goCDfcgr8GZ69x1Ymv7KCNaxcVOWGe2sEfvCYMti1OlEFTdkNTlPPiKXxTVEg4Zc
h7NR6ZHVGF95IOjBxEjyYNuxFIBT8RZ6NUBsWwybmQGOdnOvL7zquOGaNrqkApSc
Rq22DXn49fWEsJKbrSYdPZgtg0TXfm8DERzGcGZmOLmXgVEEu1jl9k2567fosKEn
FDaIId0er/ojIFE4z1h8
=+D5X
-----END PGP SIGNATURE-----

--tX7KBMdIlXs3671UlqlmJWi4Fg0xrbfsd--
