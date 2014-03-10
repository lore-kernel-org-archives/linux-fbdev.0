From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Mar 2014 10:32:18 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <531D94B2.4040304@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RkIoJepCQE6ohBv3vaGX65afdsqoIPTM5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>		<1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>		<20140228155937.GQ21483@n2100.arm.linux.org.uk>	<5310B567.7040605@ti.com>		<20140228162327.GT21483@n2100.arm.linux.org.uk>	<5316E31F.9050308@ti.com>	
 <CAMuHMdWVSfKrudBhE7FW-ZWBvMOLWjrQZvn1qZUfRt_H+P7A2w@mail.gmail.com>	
 <53183730.5060205@ti.com>
 <1394201859.16309.14.camel@paszta.hi.pengutronix.de>
In-Reply-To: <1394201859.16309.14.camel@paszta.hi.pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, DRI Development <dri-devel@lists.freedesktop.org>, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel@ffwll.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--RkIoJepCQE6ohBv3vaGX65afdsqoIPTM5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/03/14 16:17, Philipp Zabel wrote:
> Hi,
>=20
> Am Donnerstag, den 06.03.2014, 10:52 +0200 schrieb Tomi Valkeinen:

>> analog;
>> digital-single-link;
>> digital-dual-link;
>>
>> My reasoning to the format I chose was basically that when a connector=

>> supports 'digital', it contains TMDS clock and TMDS data for link 1.
>> Adding dual link to that adds only TMDS data for link 2, so the second=

>> data link is kind of an additional feature, marked with a flag.
>>
>> Not a very big argument, and I'm fine with other format suggestions.
>=20
> I'd prefer the analog / digital / dual-link variant for aesthetic
> reasons. But looking at other connector types, I wonder if this should
> be generalized even more:
>=20
> For HDMI/DVI (digital) single-link means one clock pair and 3 TMDS data=

> pairs, dual-link means one clock pair and 6 data pairs.
>=20
> On LVDS connectors, there usually are one clock pair and three (18-bit)=

> or four (24-bit) LVDS data pairs, in dual channel configuration two
> clock pairs and 6 or 8 data pairs are used.
>=20
> For DisplayPort there is no separate clock pair, but 1 to 4 data pairs,=

> and MIPI DSI again has one clock pair and a one or more data pairs.
>=20
> There are already optional endpoint configuration properties
> 'data-lanes' and 'clock-lanes' for MIPI CSI-2 defined in
> Documentation/devicetree/bindings/media/video-interfaces.txt.
> Could/should this be aligned with the same?

Hmm. Well, at least for HDMI and DP we anyway need the connector type,
which tells the form factor, and it also tells the TMDS details. So, we
could define the lanes in a common way, but we'd still need extra
information.

For MIPI DSI and (I believe) LVDS, we don't need connectors. Connectors,
as described in this binding, are meant for standard hotpluggable
connectors to which you can connect any device that has that same connect=
or.

 Tomi



--RkIoJepCQE6ohBv3vaGX65afdsqoIPTM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTHZSyAAoJEPo9qoy8lh712lQP/Rd9QLxZRb2ZfEebjDG+ViQR
8ylNpWziWniwoDltBFYF70eQ+KmMi5RUoU01/DjargjDCWnlOK7Rc/zCRn3p2L/w
FSE/aKV13p5kASmnQq7V9LvpvXCjzNbwPX7PBSYsRuGbHLVRFXHY+ImYaRzBuVDP
TdFjvtVsTYqyywrAVRYLZH3vSiu+P4ukugMjfbTbs4wn0aqier/2Jvlj3/MqqhL7
2FUkh8qec9Sf1Ii/2jhJAR+fo7qS4JGjlMp6bsR7f3C1S/0MQPhWXhoR9BSaZfuE
E4yJSDGWvcwjbpufw6rSTIKPcV1gk29s3TaWhBHkH1fiUSLV32voa/2o2r7KkSW/
gCcwPSnKJz7VRN41GvmT8q/bIFYY4939S+1KUhB+Vaz5MqnKwVO+39ZVNKB1ulYU
BLXVdEZJeRPLXwstzvVDevOZ+WJR7rKLEFIpvxuDmZwsu/t5ac7fGR2xwmH4ApUZ
Ja4XTBJMR3H0cBqSCWE9HUBeL/FcwKXRwCDhKiM+aa8i34Qa8YRhf2fokHxxB1JB
4p9IeY68HjgfOwqgvF08hKOyEN6fpkIf6NIEdTZRTjbK5A2bvVHmB0Rrexijg+Sv
dErub6AOckHvy9AofyZcgpCYbdHqVuXfkTHftRSHp68UmACLeU0yhD/sq+ccy2et
SN74aQUZUw8sKWwGfQE9
=sJHC
-----END PGP SIGNATURE-----

--RkIoJepCQE6ohBv3vaGX65afdsqoIPTM5--
