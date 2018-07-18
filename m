From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 18 Jul 2018 09:13:32 +0000
Subject: Re: [PATCH 1/1] fbdev/core: Disable console-lock warnings when fb.lockless_register_fb is set
Message-Id: <25776fb7-725b-da32-8785-14704f1519f7@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="hlL9LLOEnZxBqYvcGTuMknnIORu6ByYJ2"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718083633.24182-1-tzimmermann@suse.de>
 <20180718083633.24182-2-tzimmermann@suse.de>
 <f8d45969-fb04-f706-de66-e51522bbf1ed@redhat.com>
In-Reply-To: <f8d45969-fb04-f706-de66-e51522bbf1ed@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>, rostedt@goodmis.org, pmladek@suse.com, linux-fbdev@vger.kernel.org, sergey.senozhatsky@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hlL9LLOEnZxBqYvcGTuMknnIORu6ByYJ2
Content-Type: multipart/mixed; boundary="B9920iqyxERu3ObFBvPg9fhADkWueApUA";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Hans de Goede <hdegoede@redhat.com>, rostedt@goodmis.org,
 pmladek@suse.com, linux-fbdev@vger.kernel.org, sergey.senozhatsky@gmail.com,
 b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
 akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com
Message-ID: <25776fb7-725b-da32-8785-14704f1519f7@suse.de>
Subject: Re: [PATCH 1/1] fbdev/core: Disable console-lock warnings when
 fb.lockless_register_fb is set
References: <20180718083633.24182-1-tzimmermann@suse.de>
 <20180718083633.24182-2-tzimmermann@suse.de>
 <f8d45969-fb04-f706-de66-e51522bbf1ed@redhat.com>
In-Reply-To: <f8d45969-fb04-f706-de66-e51522bbf1ed@redhat.com>

--B9920iqyxERu3ObFBvPg9fhADkWueApUA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


Am 18.07.2018 um 10:44 schrieb Hans de Goede:
> Hi,
>=20
> On 18-07-18 10:36, Thomas Zimmermann wrote:
>> If the console is unlocked during registration, the console subsystem
>> generates significant amounts of warnings, which obfuscate actual
>> debugging messages. Setting ignore_console_lock_warning while debuggin=
g
>> console registration avoid the noise.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>=20
> Thank you for doing this, but there are multiple console_unlock exit
> paths in do_register_framebuffer(), you missed the one in:

Sorry for this half-baked patch and thanks for the review. I'll provide
an update.

Best regards
Thomas


>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!lock_fb_info(fb_info)) =
{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!lockless_register_fb)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 consol=
e_unlock();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -ENODEV;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> I would change this to:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!lock_fb_info(fb_info)) =
{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D -ENODEV;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto unlock_console;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0ret =3D 0;
>=20
> And put a "unlock_console:" label here:
>=20
> unlock_console:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!lockless_register_fb)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_un=
lock();
> =C2=A0=C2=A0=C2=A0=C2=A0else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ignore_console_lock_warning =
=3D
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 save=
d_ignore_console_lock_warning;
>=20
> And change the final return to:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0return ret;
>=20
> Otherwise this looks good to me.
>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
>=20
>=20
>> ---
>> =C2=A0 drivers/video/fbdev/core/fbmem.c | 6 ++++++
>> =C2=A0 1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/core/fbmem.c
>> b/drivers/video/fbdev/core/fbmem.c
>> index 9e2f9d3c760e..79b489ad603d 100644
>> --- a/drivers/video/fbdev/core/fbmem.c
>> +++ b/drivers/video/fbdev/core/fbmem.c
>> @@ -1627,6 +1627,7 @@ static int do_register_framebuffer(struct
>> fb_info *fb_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct fb_event event;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct fb_videomode mode;
>> +=C2=A0=C2=A0=C2=A0 bool saved_ignore_console_lock_warning =3D
>> ignore_console_lock_warning;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fb_check_foreignness(fb_info=
))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOSYS;=

>> @@ -1691,6 +1692,8 @@ static int do_register_framebuffer(struct
>> fb_info *fb_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event.info =3D fb_info;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!lockless_register_fb)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_lock();=

>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ignore_console_lock_warnin=
g =3D true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!lock_fb_info(fb_info)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!lockless_r=
egister_fb)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 console_unlock();
>> @@ -1701,6 +1704,9 @@ static int do_register_framebuffer(struct
>> fb_info *fb_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlock_fb_info(fb_info);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!lockless_register_fb)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_unlock(=
);
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ignore_console_lock_warnin=
g =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sa=
ved_ignore_console_lock_warning;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--B9920iqyxERu3ObFBvPg9fhADkWueApUA--

--hlL9LLOEnZxBqYvcGTuMknnIORu6ByYJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAltPBLwACgkQaA3BHVML
eiOXQQf+OYNHXwIlIw5GPjU58iQV2+jscwbuU6QgQSIsGNzcYmiUqg2u4zT00EFF
ZJE6OZHTt2el6IK+SKoK9LhPSnfrGrYM4gcLQ7okrR5jwxyd2T5dIMv3+IpLTAOm
mQXz+vgYRMpmyIS6ZdmH0wKQH2qa6jIXgtoC/1Sc+R8OFrpX6AmKmSoyv4K3e+iV
rwueRmSvl2LezPNJvLNdtb2jREx/Mh5jyloCKXBGdRqBkvTUZ22idnt+estH5pKS
ebOzqiY4GaFelHeRre3hVUojWF4ri0etzvMlEh+/n32anlUH2mWFhDlJNH2E0w8a
aor3/xQ/8syW5RMaJRriN6mdtWC6aA==
=tPb2
-----END PGP SIGNATURE-----

--hlL9LLOEnZxBqYvcGTuMknnIORu6ByYJ2--
