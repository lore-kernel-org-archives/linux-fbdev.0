From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 09 Oct 2020 13:31:05 +0000
Subject: Re: drmfb console switching problems/questions
Message-Id: <050632f0-6440-1254-2aed-931dd515ff37@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OuhsM6hLiBvItfYpOSeTxcQ3jJj9Q09ak"
List-Id: <linux-fbdev.vger.kernel.org>
References: <17980f58-c2d2-ac58-88ce-e21b5a56da39@yandex.ru>
 <df4d1918-dcb1-4951-6280-f178ecbbfc2f@suse.de>
 <70ce31ca-5922-584c-8631-3853c488f3c7@yandex.ru>
 <e2118f89-2c55-ec12-1e33-f2ba418af914@suse.de>
 <cacba527-fe32-e80c-4659-799452741791@yandex.ru>
In-Reply-To: <cacba527-fe32-e80c-4659-799452741791@yandex.ru>
To: stsp <stsp2@yandex.ru>, linux-fbdev@vger.kernel.org, Linux kernel <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OuhsM6hLiBvItfYpOSeTxcQ3jJj9Q09ak
Content-Type: multipart/mixed; boundary="fZrlL9ftKBHdbItsmntY63Uze25lS4hVM";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: stsp <stsp2@yandex.ru>, linux-fbdev@vger.kernel.org,
 Linux kernel <linux-kernel@vger.kernel.org>
Message-ID: <050632f0-6440-1254-2aed-931dd515ff37@suse.de>
Subject: Re: drmfb console switching problems/questions
References: <17980f58-c2d2-ac58-88ce-e21b5a56da39@yandex.ru>
 <df4d1918-dcb1-4951-6280-f178ecbbfc2f@suse.de>
 <70ce31ca-5922-584c-8631-3853c488f3c7@yandex.ru>
 <e2118f89-2c55-ec12-1e33-f2ba418af914@suse.de>
 <cacba527-fe32-e80c-4659-799452741791@yandex.ru>
In-Reply-To: <cacba527-fe32-e80c-4659-799452741791@yandex.ru>

--fZrlL9ftKBHdbItsmntY63Uze25lS4hVM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 09.10.20 um 15:19 schrieb stsp:
> 09.10.2020 15:58, Thomas Zimmermann =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Hi
>>
>> Am 09.10.20 um 14:16 schrieb stsp:
>>> 09.10.2020 14:59, Thomas Zimmermann =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> Fbdev exposes the video ram (or a shadow buffer of it) to all
>>>> applications. Only one can draw at the same time. It's a limitation =
of
>>>> the design. To fix this, your application has to stop drawing when y=
ou
>>>> switch consoles.
>>> OK, thanks for info.
>>> Quite a sad news, if you ask me.
>>> Is there any ongoing work at solving that?
>> I don't think so. Both, SDL1 and fbdev, are pretty much dead these day=
s.
>> The solution to fbdev is DRM, which does not have these problems.
>>
>> You could your application under X11 to use SDL's X backend. X would d=
o
>> all the VC handling then.
> That of course works.
> I was trying w/o X.
> Do you think it is possible for
> me to test other techniques of
> drawing under kms console?
> Or fbcon and X are all that we
> have?

I can't say for sure. IIRC SDL2 can use DRM directly. If your
application is stuck at SDL1, fbdev or X11 are the only realistic
options. But the SDL dev could probably give you a better answer.

Best regards
Thomas


--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--fZrlL9ftKBHdbItsmntY63Uze25lS4hVM--

--OuhsM6hLiBvItfYpOSeTxcQ3jJj9Q09ak
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl+AZhkUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiPXBwf/ZrKP64JecPLZsG/MiEQ+KIeF8qgs
jJsKcghIksbGyI7DO+eyjtkQXeTSbMDeDL1NlXkE3+mGgKfX6eN4/bOI1oZsA/I2
YOHEuhgTznvWlAUfdGtkkQmSaA3iRdu/FWYQNgnz1A9HijiunGeR0/n8ZjsTeksU
oMeMK9QPql9hsBtptXGNjYmAexpZPG6YbGtpmUjFJfaRMIu2wFjJKhQBLD7e3pvf
1tHgN3CBPWbDNsmqPRMIsQgagwmgTRBWwJDSuHSirY3cRV8p+jB0MzFHDbNfSuiY
AZR9rbIv9LBekg8oqfdtm1dLQl7rWgoC+OYqhfwXnDsMqID0y14eNmXVcA==
=C1dt
-----END PGP SIGNATURE-----

--OuhsM6hLiBvItfYpOSeTxcQ3jJj9Q09ak--
