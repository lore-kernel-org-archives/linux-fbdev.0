From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 29 Apr 2016 15:00:18 +0000
Subject: Re: [PATCH v4 3/7] drm/fb-helper: Add fb_deferred_io support
Message-Id: <57237702.8060305@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dOfRUpRTmERrII3IRSq9rk3JefsjaAjbI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461856717-6476-1-git-send-email-noralf@tronnes.org>
 <1461856717-6476-4-git-send-email-noralf@tronnes.org>
 <572358A0.8010002@ti.com> <20160429145524.GC14148@phenom.ffwll.local>
In-Reply-To: <20160429145524.GC14148@phenom.ffwll.local>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org

--dOfRUpRTmERrII3IRSq9rk3JefsjaAjbI
Content-Type: multipart/mixed; boundary="NuWrecQceAcduRJP6ji7t0oMAGXB3R3m4"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org
Message-ID: <57237702.8060305@ti.com>
Subject: Re: [PATCH v4 3/7] drm/fb-helper: Add fb_deferred_io support
References: <1461856717-6476-1-git-send-email-noralf@tronnes.org>
 <1461856717-6476-4-git-send-email-noralf@tronnes.org>
 <572358A0.8010002@ti.com> <20160429145524.GC14148@phenom.ffwll.local>
In-Reply-To: <20160429145524.GC14148@phenom.ffwll.local>

--NuWrecQceAcduRJP6ji7t0oMAGXB3R3m4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 29/04/16 17:55, Daniel Vetter wrote:

>> Who's calling {write,fillrect,copyarea,imageblit} in an atomic context=
?
>> That sounds like a very bad idea to me...
>>
>> If this is only for accumulating changes, I think it may be better to
>> leave that to the driver as it may have better idea of how to accumula=
te.
>>
>> But, of course, this is a helper, so if all the drivers use this kind =
of
>> accumulation, it makes sense =3D).
>=20
> Apparently panic context and cursor timer and stuff like that. I think
> this started with udl, and just to make sure (it's fbdev after all, no =
one
> wants to read the code itself) we've put those checks onto all entry
> points that draw stuff. It could be overkill, but this is what udl/qxl
> already do, so better to keep imo for now.
>=20
> I guess if it's really not needed we could later on change that, but no=
t
> sure that's worth the effort. And we can't get rid of it entirely.

Yep... Sounds fine to me.

Someone should implement (minimal) fbdev userspace API support to DRM
without using the current fbdev, and implement fbcon on top of that. I
don't like how DRM and fbdev gets mixed...

I offer a beer to anyone who does that =3D).

 Tomi


--NuWrecQceAcduRJP6ji7t0oMAGXB3R3m4--

--dOfRUpRTmERrII3IRSq9rk3JefsjaAjbI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXI3cCAAoJEPo9qoy8lh71MFgP/il1D8fJacA1+K7pqU6UlDnb
kYJ9nKTgzlP1dKBR6faLB5L9TahQulGg08Ta+AstPku60xtC0NoXJdeuHIgGfQSn
EquS21mkHWZ7X6zVUWZDaKvUQTxwMjPH9MCBsQU9Y1WxCV47z+K7Ai5Haix/vZR7
4sMrA/j95gOiVBwGdoqTj3kRCOq6MlMmbkW/c+Zjh7Rwv2+J60R9HUp00yoR6xO8
8wNgawruzz6SIvFv6ZWhMIghC1CCb6ajSFFF/VYVXX4UN0RGxEr5RM08CaaNRgIc
tPzr08pIKYX/DdfpQ7oy9wl5m+rB8kllque4W36mRYywfIVD9D7F6ShH8MsX4qiS
0lZtBXUFTTNi1pB3J5j72L9ai7z/Qkh3N8/L9SsmX3jeBFvkRZu/Xv98MtHLqxOY
VXs6ujS9vDQfgXY50NwGXhU18Jo9wbPqz1uupF4PnOLUaaQ3PlqqFzlIvsfRox2F
8IC5ztuxYeyqHTjm2E9ETEM/iU+flhPqlHGw3BvIGCQovyHAz8MwWiZPXnF9fxxs
0foSgi7YHJ81akJZNNChYGX93++xzQMDXc/u2OiDTcGwtypC0cNlqXiFbgMIaw5L
COVcdvNpH3Jb4gkHz6ZK0Lob0yeIubw0NBrWPq+kAln+lm9ZhZ8BouPjswMTZ+XU
PjaeV3IA1OoPONN5q+66
=fEHF
-----END PGP SIGNATURE-----

--dOfRUpRTmERrII3IRSq9rk3JefsjaAjbI--
