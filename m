From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 20 May 2019 08:37:53 +0000
Subject: Re: [PATCH 10/33] fbcon: call fbcon_fb_(un)registered directly
Message-Id: <8aecc0d8-83a3-8144-a266-441a5c1d5db5@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="QdOG6VnP6yygaSD5tqNtZtllH9oo2Rfnp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
 <20190520082216.26273-11-daniel.vetter@ffwll.ch>
 <423eba4b-15e1-f10b-ae2d-855b8a585688@suse.de>
In-Reply-To: <423eba4b-15e1-f10b-ae2d-855b8a585688@suse.de>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, Yisheng Xie <ysxie@foxmail.com>, Peter Rosin <peda@axentia.se>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Mikulas Patocka <mpatocka@redhat.com>, linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QdOG6VnP6yygaSD5tqNtZtllH9oo2Rfnp
Content-Type: multipart/mixed; boundary="wYKLRIK9QH5G6TuclSMFvx1Hwt9S3IzqB";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
 DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, Daniel Vetter
 <daniel.vetter@intel.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 Yisheng Xie <ysxie@foxmail.com>, Peter Rosin <peda@axentia.se>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Mikulas Patocka <mpatocka@redhat.com>, linux-fbdev@vger.kernel.org
Message-ID: <8aecc0d8-83a3-8144-a266-441a5c1d5db5@suse.de>
Subject: Re: [PATCH 10/33] fbcon: call fbcon_fb_(un)registered directly
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
 <20190520082216.26273-11-daniel.vetter@ffwll.ch>
 <423eba4b-15e1-f10b-ae2d-855b8a585688@suse.de>
In-Reply-To: <423eba4b-15e1-f10b-ae2d-855b8a585688@suse.de>

--wYKLRIK9QH5G6TuclSMFvx1Hwt9S3IzqB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 20.05.19 um 10:33 schrieb Thomas Zimmermann:
> Hi
>=20
> Am 20.05.19 um 10:21 schrieb Daniel Vetter:
> ...
>> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/co=
re/fbmem.c
>> index fc3d34a8ea5b..ae2db31eeba7 100644
>> --- a/drivers/video/fbdev/core/fbmem.c
>> +++ b/drivers/video/fbdev/core/fbmem.c
>> @@ -1660,7 +1660,6 @@ MODULE_PARM_DESC(lockless_register_fb,
>>  static int do_register_framebuffer(struct fb_info *fb_info)
>>  {
>>  	int i, ret;
>> -	struct fb_event event;
>>  	struct fb_videomode mode;
>> =20
>>  	if (fb_check_foreignness(fb_info))
>> @@ -1723,7 +1722,6 @@ static int do_register_framebuffer(struct fb_inf=
o *fb_info)
>>  	fb_add_videomode(&mode, &fb_info->modelist);
>>  	registered_fb[i] =3D fb_info;
>> =20
>> -	event.info =3D fb_info;
>>  	if (!lockless_register_fb)
>>  		console_lock();
>>  	else
>> @@ -1732,9 +1730,8 @@ static int do_register_framebuffer(struct fb_inf=
o *fb_info)
>>  		ret =3D -ENODEV;
>>  		goto unlock_console;
>>  	}
>> -	ret =3D 0;
>> =20
>> -	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
>> +	ret =3D fbcon_fb_registered(fb_info);
>=20
> What about backlight drivers? [1] Apparently these also use the
> notifiers. [2] From my understanding, backlight drivers would stop
> working with this change.

I just saw that backlight drivers only care about blanking and
unblanking. Never mind then.

Best regards
Thomas

>=20
> Best regards
> Thomas
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/video/backlight
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/video/backlight/backlight.c#n40
>=20
>>  	unlock_fb_info(fb_info);
>>  unlock_console:
>>  	if (!lockless_register_fb)
>> @@ -1771,7 +1768,6 @@ static int __unlink_framebuffer(struct fb_info *=
fb_info);
>> =20
>>  static int do_unregister_framebuffer(struct fb_info *fb_info)
>>  {
>> -	struct fb_event event;
>>  	int ret;
>> =20
>>  	ret =3D unbind_console(fb_info);
>> @@ -1789,9 +1785,8 @@ static int do_unregister_framebuffer(struct fb_i=
nfo *fb_info)
>>  	registered_fb[fb_info->node] =3D NULL;
>>  	num_registered_fb--;
>>  	fb_cleanup_device(fb_info);
>> -	event.info =3D fb_info;
>>  	console_lock();
>> -	fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
>> +	fbcon_fb_unregistered(fb_info);
>>  	console_unlock();
>> =20
>>  	/* this may free fb info */
>> diff --git a/include/linux/fb.h b/include/linux/fb.h
>> index f52ef0ad6781..701abaf79c87 100644
>> --- a/include/linux/fb.h
>> +++ b/include/linux/fb.h
>> @@ -136,10 +136,6 @@ struct fb_cursor_user {
>>  #define FB_EVENT_RESUME			0x03
>>  /*      An entry from the modelist was removed */
>>  #define FB_EVENT_MODE_DELETE            0x04
>> -/*      A driver registered itself */
>> -#define FB_EVENT_FB_REGISTERED          0x05
>> -/*      A driver unregistered itself */
>> -#define FB_EVENT_FB_UNREGISTERED        0x06
>>  /*      CONSOLE-SPECIFIC: get console to framebuffer mapping */
>>  #define FB_EVENT_GET_CONSOLE_MAP        0x07
>>  /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
>> diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
>> index f68a7db14165..94a71e9e1257 100644
>> --- a/include/linux/fbcon.h
>> +++ b/include/linux/fbcon.h
>> @@ -4,9 +4,13 @@
>>  #ifdef CONFIG_FRAMEBUFFER_CONSOLE
>>  void __init fb_console_init(void);
>>  void __exit fb_console_exit(void);
>> +int fbcon_fb_registered(struct fb_info *info);
>> +void fbcon_fb_unregistered(struct fb_info *info);
>>  #else
>>  static inline void fb_console_init(void) {}
>>  static inline void fb_console_exit(void) {}
>> +static inline int fbcon_fb_registered(struct fb_info *info) { return =
0; }
>> +static inline void fbcon_fb_unregistered(struct fb_info *info) {}
>>  #endif
>> =20
>>  #endif /* _LINUX_FBCON_H */
>>
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--wYKLRIK9QH5G6TuclSMFvx1Hwt9S3IzqB--

--QdOG6VnP6yygaSD5tqNtZtllH9oo2Rfnp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlziZ2EACgkQaA3BHVML
eiM4rwf/fn2WYKjt/UOwz//xdRihpc2AoE9WseTOm0xdRHv9z7jlgEYpXxj0uS4D
S/Vn5hua0IALZTgaGV9spWDinYCudNMNvTrpP1cPKbWknPKLyiOWy+nq6n4zMl6n
jKKOpGNT9PAISpL4dyzrNE0sb+DKDE4O1V5BlPuiOygNjew4iCdqvwRtHwWIWaSf
9nLCHEmqnXDS8G4fXaeb0LUtVvVH3K5ACOFv7thuLdTtqpbSE7KT57KBc+clqEXX
PknuFWt/hEmyzJhiSQ9XVXD9SfwcyKOaDXGEkhvokf72Wb3ki7rXe3i8Vr6tD1s7
+U3Q+WHNtvLRVoZI61S7CHV8NCDGZw==
=WBMw
-----END PGP SIGNATURE-----

--QdOG6VnP6yygaSD5tqNtZtllH9oo2Rfnp--
