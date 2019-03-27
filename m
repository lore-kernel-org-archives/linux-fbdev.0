From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Date: Wed, 27 Mar 2019 09:55:25 +0000
Subject: Re: [RFC][PATCH 00/11] DRM driver for fbdev devices
Message-Id: <6c6f22ff-b643-ee02-aacc-6c86f20fe0ea@daenzer.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326145320.GJ2665@phenom.ffwll.local>
 <0611651c-7fec-284b-d990-6fdbcf1f1b2a@suse.de>
 <CAKMK7uGOhAP0EjoKwLf+HUyoNX0Li5NL6dBw4+ir9Ae704pHkA@mail.gmail.com>
In-Reply-To: <CAKMK7uGOhAP0EjoKwLf+HUyoNX0Li5NL6dBw4+ir9Ae704pHkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@linux.ie>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 2019-03-27 10:41 a.m., Daniel Vetter wrote:
> On Wed, Mar 27, 2019 at 10:10 AM Thomas Zimmermann <tzimmermann@suse.de> =
wrote:
>> Am 26.03.19 um 15:53 schrieb Daniel Vetter:
>>>
>>> Looks surprisingly clean, at least from a quick read. Only big thing I
>>> noticed on the implementation side is that you probably want to use the
>>> simple display helpers. At least that's a much better fit for simple
>>> display hw supported by these fbdev drivers.
>>
>> I thought about using the simple-DRM helpers, but found that a full DRM
>> driver would be more helpful for porting over fbdev drivers. Unless
>> simple DRM is a hard requirement, I'd prefer to leave it this way.
>>
>> For those devices that only support a single pipeline, the conversion to
>> simple DRM should then be mandatory during the porting process.
>=20
> fbdev only supports a single output, all multi-head extensions are
> driver specific ioctl hacks. Given that all you can do is switch it on
> or off (with a given mode), simple pipe helpers are the perfect fit
> for fbdev.
>=20
> Some drivers might support more (like multiple heads, or at least
> different outputs), and those we should convert over. But at least for
> step 1 in converting fbdev drivers over, simple pipe is the right
> starting point I think.

Converting an fbdev driver to a KMS one loses some features:

1) Dynamically switching modes / colour formats via fbdev.
2) fbcon acceleration (or maybe this can be preserved?).

In turn, it allows exposing additional functionality:

3) Multiple outputs via KMS.


Is there any benefit in converting a driver without adding 3)? If not,
is simple pipe still a good starting point?


--=20
Earthling Michel D=C3=A4nzer               |              https://www.amd.c=
om
Libre software enthusiast             |             Mesa and X developer
