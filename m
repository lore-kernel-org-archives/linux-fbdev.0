From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 11 Jul 2018 15:07:00 +0000
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
Message-Id: <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8jO8uhRH2wuGaDZE6PEmEAoivhuFSjoHp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
 <20180711105255.32803a3c@gandalf.local.home>
In-Reply-To: <20180711105255.32803a3c@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>, linux-fbdev@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8jO8uhRH2wuGaDZE6PEmEAoivhuFSjoHp
Content-Type: multipart/mixed; boundary="ajt8tghe2MGlzHmLLB0KjTT2nIIjCXGmg";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-ID: <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
 <20180711105255.32803a3c@gandalf.local.home>
In-Reply-To: <20180711105255.32803a3c@gandalf.local.home>

--ajt8tghe2MGlzHmLLB0KjTT2nIIjCXGmg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 11.07.2018 um 16:52 schrieb Steven Rostedt:
>=20
> What if you make lockless_register_fb visible to fbcon, and then we can=

> have a macro:

There are more of these macro invocations under drivers/tty/vt, which
also mess up the log during debugging.

WARN_CONSOLE_UNLOCKED is already protected by an '#ifdef 1 ... #else
=2E..' construct [1]. I thought about turning this into a config option.

Best regards
Thomas

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/linux/console.h#n203

>=20
> #define WARN_FB_CONSOLE_UNLOCKED() 			\
> 	do {						\
> 		if (unlikely(!lockless_register_fb))	\
> 			WARN_CONSOLE_UNLOCKED();	\
> 	} while (0)
>=20
> And use that instead?
>=20
> -- Steve
>=20
>=20
>> Best regards
>> Thomas
>>
>>> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v3:
>>> -New patch in v3 of this patchset
>>>
>>> Changes in v4:
>>> -Keep the comments about which fbcon functions need locks in place
>>> ---
>>>  drivers/video/fbdev/core/fbcon.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/c=
ore/fbcon.c
>>> index c910e74d46ff..cd8d52a967aa 100644
>>> --- a/drivers/video/fbdev/core/fbcon.c
>>> +++ b/drivers/video/fbdev/core/fbcon.c
>>> @@ -828,6 +828,8 @@ static int set_con2fb_map(int unit, int newidx, i=
nt user)
>>>  	struct fb_info *oldinfo =3D NULL;
>>>   	int found, err =3D 0;
>>> =20
>>> +	WARN_CONSOLE_UNLOCKED();
>>> +
>>>  	if (oldidx =3D=3D newidx)
>>>  		return 0;
>>> =20
>>> @@ -3044,6 +3046,8 @@ static int fbcon_fb_unbind(int idx)
>>>  {
>>>  	int i, new_idx =3D -1, ret =3D 0;
>>> =20
>>> +	WARN_CONSOLE_UNLOCKED();
>>> +
>>>  	if (!fbcon_has_console_bind)
>>>  		return 0;
>>> =20
>>> @@ -3094,6 +3098,8 @@ static int fbcon_fb_unregistered(struct fb_info=
 *info)
>>>  {
>>>  	int i, idx;
>>> =20
>>> +	WARN_CONSOLE_UNLOCKED();
>>> +
>>>  	idx =3D info->node;
>>>  	for (i =3D first_fb_vc; i <=3D last_fb_vc; i++) {
>>>  		if (con2fb_map[i] =3D=3D idx)
>>> @@ -3131,6 +3137,9 @@ static int fbcon_fb_unregistered(struct fb_info=
 *info)
>>>  static void fbcon_remap_all(int idx)
>>>  {
>>>  	int i;
>>> +
>>> +	WARN_CONSOLE_UNLOCKED();
>>> +
>>>  	for (i =3D first_fb_vc; i <=3D last_fb_vc; i++)
>>>  		set_con2fb_map(i, idx, 0);
>>> =20
>>> @@ -3177,6 +3186,8 @@ static int fbcon_fb_registered(struct fb_info *=
info)
>>>  {
>>>  	int ret =3D 0, i, idx;
>>> =20
>>> +	WARN_CONSOLE_UNLOCKED();
>>> +
>>>  	idx =3D info->node;
>>>  	fbcon_select_primary(info);
>>>   =20
>>
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--ajt8tghe2MGlzHmLLB0KjTT2nIIjCXGmg--

--8jO8uhRH2wuGaDZE6PEmEAoivhuFSjoHp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAltGHRQACgkQaA3BHVML
eiMqUQf+OhrkPRUI5OUM3E8z1+kzEOaiT/4kBAPSVPhwGbPCKQ5QalK9AqAFXEmT
bUKHn5XOMDBRWRzkauR7iTmgyJ7AQgs06dmQDFSJRKA1H8DXRHuv225+LOx5h26L
Bn1JhedgI7sxPm/X5wxJLjzyNNpxfBYPy18ddS4ebsTAU1nkB/xEmFtrJj7xRkFo
0PBskiwJerAifcqH6KkFtfUmfamIIe4HnNcyJtVUCiKCrKaDYmn6dwSLO1ZZ+6+M
wRPjOszWr0Xhgfzp328d+kihEvwo1gAspl6AG4ZjT8XK1tCZY60gAGWKarv1MyzI
qY64aBmjnaizTwL4XgUULY+l4W6J2Q==
=scnP
-----END PGP SIGNATURE-----

--8jO8uhRH2wuGaDZE6PEmEAoivhuFSjoHp--
