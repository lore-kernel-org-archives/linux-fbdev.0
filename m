From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 19 Jul 2018 10:20:17 +0000
Subject: Re: [PATCH v2 1/1] fbdev/core: Disable console-lock warnings when fb.lockless_register_fb is set
Message-Id: <48b38f83-f3cf-943d-bd31-ab2e1bd29d0a@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0iSG0IoeF2liNhbAz539lDXmi10qQdoJu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718093002.4596-1-tzimmermann@suse.de>
 <20180718093002.4596-2-tzimmermann@suse.de>
 <20180719085303.mkxu7i7zl4suybcz@pathway.suse.cz>
 <20180719100526.GB424@jagdpanzerIV>
In-Reply-To: <20180719100526.GB424@jagdpanzerIV>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>
Cc: linux-fbdev@vger.kernel.org, hdegoede@redhat.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, sergey.senozhatsky@gmail.com, rostedt@goodmis.org, akpm@linux-foundation.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0iSG0IoeF2liNhbAz539lDXmi10qQdoJu
Content-Type: multipart/mixed; boundary="ZrgC55tb4SE6fNTAPTi6oCIstCmQQ8wHm";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Petr Mladek <pmladek@suse.com>
Cc: rostedt@goodmis.org, linux-fbdev@vger.kernel.org,
 sergey.senozhatsky@gmail.com, b.zolnierkie@samsung.com,
 dri-devel@lists.freedesktop.org, hdegoede@redhat.com,
 akpm@linux-foundation.org
Message-ID: <48b38f83-f3cf-943d-bd31-ab2e1bd29d0a@suse.de>
Subject: Re: [PATCH v2 1/1] fbdev/core: Disable console-lock warnings when
 fb.lockless_register_fb is set
References: <20180718093002.4596-1-tzimmermann@suse.de>
 <20180718093002.4596-2-tzimmermann@suse.de>
 <20180719085303.mkxu7i7zl4suybcz@pathway.suse.cz>
 <20180719100526.GB424@jagdpanzerIV>
In-Reply-To: <20180719100526.GB424@jagdpanzerIV>

--ZrgC55tb4SE6fNTAPTi6oCIstCmQQ8wHm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 19.07.2018 um 12:05 schrieb Sergey Senozhatsky:
> On (07/19/18 10:53), Petr Mladek wrote:
>> Hmm, this approach is racy if there are other users
>> saving/setting/restoring ignore_console_lock_warning in parallel.
>> I mean that this works only when the entire safe/set/restore
>> operation is nested or sequential.
>=20
> Good point!
>=20
> However, I tend to think that we don't need to care about it
> that much. Having a counter to permit nesting would probably be
> better, but, like you said, it's unlikely that we will see any
> problems with ignore_console_lock_warning anyway. So we can keep
> it simple [IOW - the way it is].

I just sent a new patch set based on atomic_t and TBH it's easier to use
that this version. I only had to introduce the save-state variable in
the caller because I couldn't do inc/dec.

Best regards
Thomas

>=20
> 	-ss
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--ZrgC55tb4SE6fNTAPTi6oCIstCmQQ8wHm--

--0iSG0IoeF2liNhbAz539lDXmi10qQdoJu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAltQZeYACgkQaA3BHVML
eiO0kAf/UKIcLnJQUWyqzRGxGeFSMJdy2VawPoe/bCtPFitH0ncJZkNzV8Q+ffgr
rAJmdgDotzMApZfY5tsryW8mvISxkWOGP0c4uSii7HgBrFK9kX9eraavHTivMpor
GtvZxlw47KWzFWQVnGZDGjbY3nz/OTq8CM7AZnWUXDkae4mBuBRqReOB9rxgKlC2
5zILXtVEjZcSBcpcmS8IWneyASwQNMI2vDcEYHS4Be6V9g3CAyPY2DTbb3K6scs8
cBJTDqYnPDlXn1AAgD/bSQb+7U7te/IAf4kkz1oOqz2FmRedi/I4yXmg/kg/RDku
KbW+krb1eo52JWl6LPh/ldXi+VvnGA==
=DN8h
-----END PGP SIGNATURE-----

--0iSG0IoeF2liNhbAz539lDXmi10qQdoJu--
