From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 May 2015 07:15:21 +0000
Subject: Re: [RFC PATCH] video/logo: introduce new system state for checking if logos are freed
Message-Id: <55641D89.5020103@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="hsCaLiq4v9p64um4w3PMXV4KBOPpfAQp5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430896145-8887-1-git-send-email-hs@denx.de>	<5562B9CE.7050807@ti.com>	<5563EEF9.3080901@denx.de>	<556418A9.8010603@ti.com> <CAMuHMdWHP6i15Z2qZJBEW9uz7kh1_ET5N1VbOKoMw1EC7F3O0g@mail.gmail.com>
In-Reply-To: <CAMuHMdWHP6i15Z2qZJBEW9uz7kh1_ET5N1VbOKoMw1EC7F3O0g@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: hs@denx.de, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

--hsCaLiq4v9p64um4w3PMXV4KBOPpfAQp5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26/05/15 10:08, Geert Uytterhoeven wrote:
> On Tue, May 26, 2015 at 8:54 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>> On 26/05/15 06:56, Heiko Schocher wrote:
>>>> Without locking, the initmem may be freed while fb_find_logo() is
>>>> running.
>=20
> Or afterwards. Drivers may keep the pointer around indefinitely.
>=20
>>> Yes, you are right, that must be added ... but has such a change a
>>> chance to go in mainline?
>>
>> I don't know. To be honest, this whole thing feels a bit like hackery.=
 I
>> think initdata should only be accessed from initcalls, never asynchron=
ously.
>>
>>> BTW: Could this not be currently a problem on multicore systems?
>>> If lets say core 2 just draws the logo, another core 1 calls
>>> fb_logo_late_init() and later core 1 free_initmem(), while the core 2=

>>> still draws it?
>>
>> Yes, I think so...
>=20
> I don't think that can happen. All initcalls should complete before ini=
tmem
> is freed.

Ah, true, the question was only about the initcalls. I was answering to
what actually can happen with the logo code as a whole.

The whole problem started when I fixed an issue where the logos were
accessed from a workqueue. I don't remember the details, but I think drm
always (?) sets up some console stuff via workthread. In that case we
could have the workthread accessing the logos, while initmem is being fre=
ed.

>> So, maybe it would be better to not even try to go forward with the
>> current approach. Two approaches come to my mind:
>>
>> 1) Keep the logos in the memory, and don't even try to free them. I
>> don't know many bytes they are in total, though.
>=20
> m68k/allmodconfig:
>=20
> $ size drivers/video/logo/logo*o
>    text   data    bss    dec    hex filename
>      24   6961      0   6985   1b49 drivers/video/logo/logo_linux_clut2=
24.o
>      24    800      0    824    338 drivers/video/logo/logo_linux_mono.=
o
>      24   3200      0   3224    c98 drivers/video/logo/logo_linux_vga16=
=2Eo
>      24   6955      0   6979   1b43 drivers/video/logo/logo_mac_clut224=
=2Eo
>     161      4      2    167     a7 drivers/video/logo/logo.o
>=20
> Not that bad... Custom logos may be larger, though.

I wonder how much a simple RLE would cut down the sizes...

>> 2) Make a copy of the logos to a kmalloced area at some early boot
>> stage. Then manually free the logos at some point (after the first
>> access to the logos? after a certain time (urgh...)?).
>=20
> 3) Draw the logos from an initcall on all frame buffers that exist at t=
hat
>    point in time. Yes, this will destroy (part of) the content that's
>    currently shown.

Isn't that almost the same as now? The problem is that the fb probes are
deferred to a very late stage, so we would not have the fbs when the
suggested initcall would be called.

 Tomi


--hsCaLiq4v9p64um4w3PMXV4KBOPpfAQp5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVZB2JAAoJEPo9qoy8lh71sn0P/3cdyxvh6mxumDCtEVLxeYg/
lFQc6EUReP7DskaQjBpPy5RiLPPgFdmFcek8sKUx8NVLJam6+2b2cjg5UgWonYx0
skWLq8/SMFr0ufPw8SfDip1JNl7u5EqlALlxzE/r51UukhSqDDcp6SlDiQk+H3h2
Tyrep+bVBb4xlUrd7O/db0rLv/76UCDS/fZua/ZcOA2NXK49PIRRvlpntYJRFrHX
M45TTFO9HsZirxNwbG9DXyrjkUFz1g0jfRAkPG+YsYL6nt/lTkKkgAN/PSyty8yo
Ny45QTIG9coQglqyKmn5s3zctQIC6QV806JD9ecUjiyuaGqA0xkWR0UQ/0lgPXo4
K4cJdaskjuEvByKV0ZFcGWciFy3P5eYLmRf/mWYraOyDlHdxPYdU/tSBAPz+EqWv
Q+WMxMcRGw2Qp+ieFAjMUDv3DL3gKK5UdwLlpHxxGMMVSEDfEz/xX/DOe82GOT24
X1vfcie6bDvKXmqbXnIjW5ZIMQCFgCJ5XN7C6rJRi3VhXBwqLxMC9dADdlAu4M/Q
6BSzOMQzwtGsDULjqnrTDFBb6mrKXffJQb14ZshQVyXNCESKSAGSErTedo1rnH/d
EN8HuO7hLWefThGh8lHeXy2htdwa6qqF19xh2+mKo1SjQBZHEKf20siXk5dDjFfS
UP8NgHWJtAI/wIkavoou
=h4Ny
-----END PGP SIGNATURE-----

--hsCaLiq4v9p64um4w3PMXV4KBOPpfAQp5--
