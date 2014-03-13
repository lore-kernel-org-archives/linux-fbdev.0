From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Mar 2014 09:04:34 +0000
Subject: Re: [PATCH] lcd: Provide dummy functions if CONFIG_LCD_CLASS_DEVICE is not set
Message-Id: <532174A2.2030102@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JgqS4bCnanImdmGjlrMkD6rwwrSMNunhh"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394695879-22845-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1394695879-22845-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--JgqS4bCnanImdmGjlrMkD6rwwrSMNunhh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 13/03/14 10:48, Alexander Shiyan wrote:
> =D0=A7=D0=B5=D1=82=D0=B2=D0=B5=D1=80=D0=B3, 13 =D0=BC=D0=B0=D1=80=D1=82=
=D0=B0 2014, 10:23 +02:00 =D0=BE=D1=82 Tomi Valkeinen <tomi.valkeinen@ti.=
com>:
>> On 13/03/14 09:31, Alexander Shiyan wrote:
>>> Provide dummy functions for LCD register()/unregister() if
>>> CONFIG_LCD_CLASS_DEVICE is not set.
>>
>> Hmm, why do you want to do that? If a driver needs the LCD class, it
>> should depend on or select it.
>=20
> I inspect my recent changes for the imxfb driver.
> I use the LCD class for power management and contrast, nevertheless,
> if it lack in the kernel this leads to an error.

So is the CONFIG_LCD_CLASS_DEVICE optional for imxfb? It works fine with
or without the LCD class support? Is there some reason to run it without
LCD class support?

> Yes, we can choose the LCD_CLASS_DEVICE symbol for the imxfb driver,
> but at the same time we must choose BACKLIGHT_LCD_SUPPORT.
> I do not think it's a good way.

Why not?

> In any case, I would like to revise the patch to use NULL as a result
> if there is no support LCD_CLASS_DEVICE in the kernel.

Why do you want to run imxfb without LCD_CLASS_DEVICE? Isn't it simpler
to just depend on it?

> Additionally, I have a plan to convert "menuconfig" entry for
> BACKLIGHT_LCD_SUPPORT to the "menu".

Hmm. That does make sense, as I don't see BACKLIGHT_LCD_SUPPORT
affecting anything, except enabling the BL & LCD Kconfig menu.

However, many of the items in BL & LCD menu have, for some reason,
"default y" or "default m". So if you make BACKLIGHT_LCD_SUPPORT a menu,
it means all those subitems are always enabled. So there definitely will
be a side effect to that change.

I guess there's legacy reasons why many of the items are enabled by
default. It would make sense to me to have BACKLIGHT_LCD_SUPPORT as a
menu, as you suggest, and having all the subitems disabled by default.
But again, that would change the current behavior, which may or may not
cause issues.

 Tomi



--JgqS4bCnanImdmGjlrMkD6rwwrSMNunhh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTIXSiAAoJEPo9qoy8lh71GAQQAKZZlhsqnF8TbCd0dHUWOM3q
f4ktbWurPnSR/NgeX7fkzZJx2Ob+bZLN8mWaQ7x/6RQqZc/sPb7Gbgl9dpvBkOZ3
nuF2kBj6ByGcZR/na+yyp/uLtX4P/1W2eyjDYMCbVppGfb47yDnyszX1koqaYR1D
tIwaOer+dDiTvICHA87g4Qo6OLBcuOZAsYN500DLzs4IQ7wSJlcK8z7EbUsBY7Bb
vacxm9abglhlfrVQ10LnbysMkrGyl1NXFy/tUW8L7S4FqyA5Kv3wxTX+SDu4ZpCZ
9nL4QLGgbaJ3pXSudFX/ExvWgetUWw0W0kYh+Ozhfc9/1OkcO23hxSwA/T0wYSA0
3Drz1nVLkKBcX/n5U+k2VzTPmAuxiTaVwfX5GSMJp+XQG2Ls4/+mHb4t5TKgiHBi
Z8ovsTHuK2yMCauNyDTtFWYhX0fXnynXuTUqMHFA2L5meXpQ8UjMalEZ+sK5Eptt
3lWImiulD57QtsiWzkPBzgUM2qlBBRRGZrB219RXM3jNepnDqQKspYEmjEhsQ4iD
BRd6bVdn9ijbm+jYH/0CtC2WiBPizNKP244Gy6vd+9BHf4iY9lpJH3Jjs3cqV+9Q
/9EB4f2Y/zJcIVFab28wSxc5D5bLEErr5xjDMmJ5GNaJpLQOcaByvOmxuXV2dM9E
IcykWXuYQYNwbyF7v5k1
=NDDH
-----END PGP SIGNATURE-----

--JgqS4bCnanImdmGjlrMkD6rwwrSMNunhh--
