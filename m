From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 May 2015 07:08:23 +0000
Subject: Re: [PATCHv6 05/10] ARM: mxs: fix in tree users of ssd1306
Message-Id: <55641BE7.4090605@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5dNlqLIT4mBqM8IetmKMCL0tmGbPq8Aex"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de> <1427826436-21783-1-git-send-email-niederp@physik.uni-kl.de> <1427826436-21783-6-git-send-email-niederp@physik.uni-kl.de> <554B44A7.1090007@ti.com> <20150507112759.GC3162@dragon> <20150508133138.GS11057@lukather>
In-Reply-To: <20150508133138.GS11057@lukather>
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: =?windows-1252?Q?Thomas_Niederpr=FCm?= <niederp@physik.uni-kl.de>, Sascha Hauer <kernel@pengutronix.de>, plagnioj@jcrosoft.com, robh+dt@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--5dNlqLIT4mBqM8IetmKMCL0tmGbPq8Aex
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 08/05/15 16:31, Maxime Ripard wrote:
> Hi Shawn,
>=20
> On Thu, May 07, 2015 at 07:28:01PM +0800, Shawn Guo wrote:
>> On Thu, May 07, 2015 at 01:55:35PM +0300, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> On 31/03/15 21:27, Thomas Niederpr=FCm wrote:
>>>> This patch updates the in tree-users of the SSD1306 controller for u=
sing
>>>> the newly introduced DT properties.
>>>>
>>>> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
>>>> ---
>>>>  arch/arm/boot/dts/imx28-cfa10036.dts | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dt=
s/imx28-cfa10036.dts
>>>> index b04b6b8..570aa33 100644
>>>> --- a/arch/arm/boot/dts/imx28-cfa10036.dts
>>>> +++ b/arch/arm/boot/dts/imx28-cfa10036.dts
>>>> @@ -99,6 +99,9 @@
>>>>  					solomon,height =3D <32>;
>>>>  					solomon,width =3D <128>;
>>>>  					solomon,page-offset =3D <0>;
>>>> +					solomon,com-lrremap;
>>>> +					solomon,com-invdir;
>>>> +					solomon,com-offset =3D <32>;
>>>>  				};
>>>>  			};
>>>
>>> Should this patch be merged separately via proper tree? I can take th=
e
>>> rest of the patches via fbdev tree. I can, of course, take this via
>>> fbdev also, if I get an ack.
>>
>> @Maxime
>>
>> I assume you're the person, right?
>=20
> I don't have this board right now to actually test, but the changes
> look good.

So should I take this via fbdev tree with the rest of the patches? If
so, I want an ack from a relevant dts maintainer. get_maintainers.pl
gives Shawn as the first contact for imx28-cfa10036.dts.

 Tomi


--5dNlqLIT4mBqM8IetmKMCL0tmGbPq8Aex
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVZBvnAAoJEPo9qoy8lh71XtoP/3h/iUzERvKYFZOMbrv56CrO
BG2kHwC5uF3osbngtk5YXKVL9qaxJidN/eMr1CddEfpshPwROLOkbSEJd4EAoR2V
4uRR9WLi8MP4NpYyB1icchVwKupW8xZsqCk4KnMdDMpFDiAhC7BcSO+PN+Q+bQ2C
KAS4tfn6hGbohoxrfYWcWcFqWZ7S81I7JsZWeYuzTxp9UOm64SC/JdI3444oL1hN
/uU4IUs+v1bK72tllVHib9kzg0nd4l1ps1Cqq0OAwSY8gSf0YA6FYm97ST70v5oL
2rg3AG5c4el9vrr2ycYav57dVWxPupOL/3AvvDK+yTZ4G/m7XR0VIy5NsNajjqcX
1HmAL5KcVWoxMi5UwAXmOsEiKIXzElW/3MscET86CNW/QeMY0JPQDw31sWme0wN3
lhb0EYc8d2kNUk5enH8sqYufm0yrmLRD57yOzz6bK4Nh7KKor0lwNR8Q5vUkSehq
3ooqnsl1pOtEUX6vyvYqqdWJ1iv8fYV0HdLW0O4SL10hFfAWPXrasTmr2LYBH+bQ
zUBMckzF6msasqOiQuDWeJMUTIcyscB9fgKElQm/QiY+AsvuYVzDCOgV6LdVAauT
ABopZEOl4EuXWjJY3RYb6IYWkGIOtszoYbLJoP0AtswFgdjW9RnVmYAe3+gKqT/A
Ld67Dgk8XlAZfenCSx9f
=J9Fl
-----END PGP SIGNATURE-----

--5dNlqLIT4mBqM8IetmKMCL0tmGbPq8Aex--
