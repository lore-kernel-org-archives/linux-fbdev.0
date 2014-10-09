From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 09 Oct 2014 09:02:00 +0000
Subject: Re: [PATCH] fonts: Add 6x10 font
Message-Id: <54364F08.8050006@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RxETiIJSvocTGLEBTqkDprtIi3qonpnCk"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1410263188-10532-1-git-send-email-maarten@treewalker.org> <542A7ADA.4010500@ti.com> <2514574.0C4va8fPM6@hyperion>
In-Reply-To: <2514574.0C4va8fPM6@hyperion>
To: Maarten ter Huurne <maarten@treewalker.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Apelete Seketeli <apelete@seketeli.net>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--RxETiIJSvocTGLEBTqkDprtIi3qonpnCk
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/10/14 10:25, Maarten ter Huurne wrote:
> On Tuesday 30 September 2014 12:41:46 Tomi Valkeinen wrote:
>> Hi,
>>
>> On 09/09/14 14:46, Maarten ter Huurne wrote:
>>> This font is suitable for framebuffer consoles on devices with a
>>> 320x240 screen, to get a reasonable number of characters (53x24) that=

>>> are still at a readable size.
>>>
>>> The font is derived from the existing 6x11 font, but gets 3 extra
>>> lines without sacrificing readability. Also I redesigned a some glyhp=
s
>>> so they are more distinct and better fill the available space.
>>>
>>> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
>>> ---
>>>
>>>  include/linux/font.h  |    4 +-
>>>  lib/fonts/Kconfig     |    9 +
>>>  lib/fonts/Makefile    |    1 +
>>>  lib/fonts/font_6x10.c | 3086
>>>  +++++++++++++++++++++++++++++++++++++++++++++++++ lib/fonts/fonts.c =
 =20
>>>   |    4 +
>>>  5 files changed, 3103 insertions(+), 1 deletion(-)
>>>  create mode 100644 lib/fonts/font_6x10.c
>>
>> I think the patch is fine, but there hasn't been any comments or acks
>> for this. I'm a bit reluctant to add this much data to the kernel if
>> there are no users (except you) for this.
>=20
> Are you counting end users, developers or projects? We've got at least =

> several thousand end users in OpenDingux for Dingoo A320 and GCW Zero=20
> combined. I could ask a few fellow developers for signed-off-by lines, =
if=20
> that helps. But it's all from the same project.
>=20
> I think the font fills a space that is currently unoccupied: the 4x6 fo=
nt is=20
> space efficient but barely readable, the 8x8 font gets only 40 columns =
on=20
> 320x240 and the 6x11 font doesn't use the vertical space efficiently.

Ok, sounds good enough for me. Queueing for 3.18.

 Tomi



--RxETiIJSvocTGLEBTqkDprtIi3qonpnCk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUNk8QAAoJEPo9qoy8lh71+c4QAIERTWJLSUw5ofr6DP2ogM8C
Fg0KpwAt+e2S8bUHKVskZ3tg861WjAgYw5hniqFGlExtBgXb/IFGe8rkQY83i6Oc
JARaO8c+39w+BHlDZy+xgHxU9XDH8GogrzPq+yBzwc1tQce1P8gTUi0eq7cRXmdC
A2uoQtxZxk6haVphVG3kiuU7wsqDyyyBN3Wh7XIclS84JFtv793zDkC9Fzqp+ytu
7p65nw1uQxEJKQNRshCZ8ZgroGx8duyed96Gcssrn6G5RuuEtZ+dDDOk0VhRh3z4
g/kGcDs2pb19DPTqzUqerSyziJ+MQJ7nafzaLnw7K0l0Y96RmncMIrkfZ3CPNo4h
PULdk45qvwk3o0QMvobXbOhmIY8GQ8YfY3GSCgaQCVcjzuwrWkmxHDsnmJdWPfjx
cTl4zcUP/VJo1gF/fhy8IQ6jGRKgVPg+wt4UaN0gFKb6nQ5Y5FdJcNA5pKh+rUKY
Pe/FKXbcRdbaoX/QF8xDv9u5/UegO80upErfRaW/sOD6DxOCL/n3qiCQloEyzZlf
+xo3gQE3n+OfS+C0ub+JeLJUxHKchYr7gBiX/v7Xgr2SDi7eXIlBONaSwIrlZcGS
EZU4VIXurKO+6RpcfZKVzwawBrixBlQFjUa5Zl8dDKDveSplQ/sc53LK6XahA27T
otacEa/aLSvRlAx4t95S
=bbNi
-----END PGP SIGNATURE-----

--RxETiIJSvocTGLEBTqkDprtIi3qonpnCk--
