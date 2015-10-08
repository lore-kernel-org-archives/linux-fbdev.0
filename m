From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 08 Oct 2015 12:21:31 +0000
Subject: Re: [PATCH] uvesafb: make scaling configurable on Nvidia cards
Message-Id: <56165FCB.30504@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="QqDmrwRHK6XgSMtGS8KVDDDHVigqS4mso"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1509021719170.12073@file01.intranet.prod.int.rdu2.redhat.com>
 <56163806.40608@ti.com>
 <alpine.LRH.2.02.1510080744170.20879@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1510080744170.20879@file01.intranet.prod.int.rdu2.redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Michal Januszewski <spock@gentoo.org>, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org

--QqDmrwRHK6XgSMtGS8KVDDDHVigqS4mso
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 08/10/15 14:51, Mikulas Patocka wrote:

>> I have to say I don't know much about x86 video, but isn't uvesafb
>> supposed to be a generic driver? Adding nvidia specific features there=

>> doesn't sound like a right way to handle this.
>>
>>  Tomi
>=20
> Where do you think that this functionality should be added? To Nouveau?=
 -=20
> Nouveau can't be used with nVidia binary driver, and this functionality=
 is=20
> useful especially with nVidia binary driver (it allows to get nice cons=
ole=20
> with sharp fonts).

I don't know where is should be. But with a quick look I don't see any
gfx card specific features in uvesafb, and the doc clearly says it's a
generic driver. So if we add this nvidia feature there, shall we add
other features for other cards also? It's a kind of slippery road.

So how does uvesafb work with nvidia driver? uvesafb is used for initial
console, and nvidia driver takes over later when (and if) it's loaded?
And it's not possible to change the scaling via nvidia's driver?

> BTW. I don't know if this BIOS function is supported on AMD or not. Cou=
ld=20
> someone try it? I don't have an AMD card.

Quick googling shows that 0x4f14 might be used by other gfx cards (Epia)
for something else. But I can't really say for sure. So in the minimum I
think the parameter should be renamed to "nvidia_scaling" or similar.

 Tomi


--QqDmrwRHK6XgSMtGS8KVDDDHVigqS4mso
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWFl/LAAoJEPo9qoy8lh71q+sP/RsCawlKMuqLaM6OpaYrzkZ8
iVSWXDPBGa8XB4iIHOL3DfYG3hJGRG/t7ReA3UwACu3hkhvkew24jL5ozy6AmpdY
t4ymrf6rX7vcePb1wfsm7NKqJweK6eWHkIk4ah7Erl+nvT3yvL7qGqRjmH7uVPT6
+Kqfxw7SGZ8m0wyG2cbBsx5kodZnQgSZ3m/8UTPhtIzdVuw0+xyu+cAVPfOMAL4G
JDztgWq5dEUHXKgb4Z8pP8ryjzqg+OCrWNoVPx5EHmmNL36aTLmLANaSGTnI+3C1
zIyo6L15CAOCbh/p49+eWdAYr9J045hw/UH2TVWzTQ4d1acjFyhOTUBALnN9mkwg
GUDx+w8vyOxi0YVpmPPZUevXBe48Gcyy7Pg1+DuuRoXm+1ibTZQZaveoZODg8bv/
vm7rPaOgYXziUaNuB0dY4JMJ9fAYRxukwe4ipz4sCTW/GW2MnWzxh0rP8JqCdg8t
Veua29dzfHytFFPZsUTnFmslcO3723/OzvEDtbjvqfqTqBVlJYaWrTgpifmhxUrX
EcrB07OmdjUhO+lVCEKAZK4SG4EqJLsZv4PA5Q+J1ithqhG7NWkIv7ht5PTkj5hP
QHsYP3KDHWx0kSkM/+ROmgTNY12wisWTI2+g9W4wonvYjOPcmP7BH3AkGnzPgn1A
vVJWPOu/cInr9vQD5FGB
=msk1
-----END PGP SIGNATURE-----

--QqDmrwRHK6XgSMtGS8KVDDDHVigqS4mso--
