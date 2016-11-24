From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Nov 2016 08:36:01 +0000
Subject: Re: [RFC PATCH 3/3] staging: remove fbtft
Message-Id: <5e7ab2b5-b2bd-bf6f-c42b-33bbe00a024b@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JGHemVitIIeT8MM4qTj07aJO99CnUB52W"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <1479888193-23908-4-git-send-email-tomi.valkeinen@ti.com>
 <60245ffa-0a64-cae0-7930-e05d92b35c09@tronnes.org>
In-Reply-To: <60245ffa-0a64-cae0-7930-e05d92b35c09@tronnes.org>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-kernel@vger.kernel.org

--JGHemVitIIeT8MM4qTj07aJO99CnUB52W
Content-Type: multipart/mixed; boundary="uQv9nc8sr3kiOQGjRHjwx5b11AAEqswCX";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Teddy Wang <teddy.wang@siliconmotion.com>,
 Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <5e7ab2b5-b2bd-bf6f-c42b-33bbe00a024b@ti.com>
Subject: Re: [RFC PATCH 3/3] staging: remove fbtft
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <1479888193-23908-4-git-send-email-tomi.valkeinen@ti.com>
 <60245ffa-0a64-cae0-7930-e05d92b35c09@tronnes.org>
In-Reply-To: <60245ffa-0a64-cae0-7930-e05d92b35c09@tronnes.org>

--uQv9nc8sr3kiOQGjRHjwx5b11AAEqswCX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23/11/16 19:26, Noralf Tr=C3=B8nnes wrote:
>=20
> Den 23.11.2016 09:03, skrev Tomi Valkeinen:
>> Since the fbdev framework is in maintenance mode and all new display
>> drivers should be made with the DRM framework, remove fbtft from
>> staging.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>=20
> FYI:
> I'm working on a drm version of fbtft: https://github.com/notro/tinydrm=

> I have just picked it up after a 4 month break.
>=20
> It is ready for a new review, except that I want to test how it would
> perform as a drm userspace driver first (for spi that would mean adding=

> dma-buf support to spidev). If this performs well, then all the fbtft
> drivers could move to userspace. If it doesn't, then at least (very slo=
w)
> i2c and e-ink displays could be userspace drivers.

Alright, sounds good to me.

So let's keep the staging fbdev drivers there until we have replacements.=


 Tomi


--uQv9nc8sr3kiOQGjRHjwx5b11AAEqswCX--

--JGHemVitIIeT8MM4qTj07aJO99CnUB52W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYNqZxAAoJEPo9qoy8lh71cqYQAKs0VXCtQBt36mTtu6soNALi
8LcjzTDm1RWg2+4gr8t/iQTS60KSEFs6aWQBpZHZXUFMzymXhX2opebRrccjsJSF
7LFF54vjNjJw4ZiRYP1Z3wxEyCP3lIGbIq3F9CIQi7SG4jqWiIGt7fXKZk8yfPYp
k1SYfh05ATAf8uyWV2+YY9090RWoQdiK54XZf4pK9+0lwGaPJfTzWDpA2JvQg1pB
H4Xvg8YHS+XTdNCseNa8L65WQdmDhuqYsZfF7vXV4zR5Z+QCcVDUwVL9br74pHlI
bqfHQIWjtkUAnJDZxh4Iqa/8Fh3MMi94KXT9y+iqiDyea+OaEe1b3BK4hIwWp/5U
2xL5BOA1BEGYRhHmZrSSIsCh3bCQqaAdHuFrw8aeS/IMaEQ5R1wSeP0fRIq/J8on
TSL/ANyDtbXddzZ3QZYpXH5QviBzl9hbOk69gMKxcj4yMjyuDCurPq4cjT6pXi+S
Fs4WyYxHveT0N+Ihe+ymqc43Ld0Yhq8NH3mn99QbCReheZ4PJp3CIqaloi+J6Pkr
1yn7+UqMzTi6jMGjsrDweQkUN308smM1Z/4Lv/CCcQgD+/attH/gLVNHhKiX07Bb
Kck0X9IQB9ucCBXP7j36aBBrV3hzBRpNr+5WXIe3+Z5uWxiC+8un6D1aoPwbZI5h
F8GRbOdIN2yrBsNmpDrk
=Z8yv
-----END PGP SIGNATURE-----

--JGHemVitIIeT8MM4qTj07aJO99CnUB52W--
