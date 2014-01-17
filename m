From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 17 Jan 2014 09:00:58 +0000
Subject: Re: [PATCH 13/15] fbdev: sh-mobile-lcdcfb: Enable driver compilation with COMPILE_TEST
Message-Id: <52D8F14A.7030100@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Woqssl4lWevVTJTeUS6MQt0Sadc5oMiDK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1542726.dq1lpTml5f@avalon> <1917257.yB7aZMXWdP@avalon>
 <52CD0CBB.3070801@ti.com>
In-Reply-To: <52CD0CBB.3070801@ti.com>
To: linux-arm-kernel@lists.infradead.org

--Woqssl4lWevVTJTeUS6MQt0Sadc5oMiDK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 2014-01-08 10:30, Tomi Valkeinen wrote:
> On 2014-01-07 17:15, Laurent Pinchart wrote:
>> On Wednesday 11 December 2013 13:51:18 Laurent Pinchart wrote:
>>> Hi Jean-Christophe and Tomi,
>>>
>>> Could you please pick this patch up for v3.14 ?
>>
>> Ping ?
>=20
> Queued for 3.14.

I'll drop this patch, as it causes compile break (from kbuild test robot)=
:

All error/warnings:

   drivers/built-in.o: In function `sh_mobile_lcdc_pan':
>> sh_mobile_lcdcfb.c:(.text+0x77373): undefined reference to
`sh_mobile_meram_cache_update'
   drivers/built-in.o: In function `sh_mobile_lcdc_start':
>> sh_mobile_lcdcfb.c:(.text+0x79320): undefined reference to
`sh_mobile_meram_cache_free'
>> sh_mobile_lcdcfb.c:(.text+0x79394): undefined reference to
`sh_mobile_meram_cache_alloc'
>> sh_mobile_lcdcfb.c:(.text+0x793d4): undefined reference to
`sh_mobile_meram_cache_update'
   drivers/built-in.o: In function `sh_mobile_lcdc_stop':
>> sh_mobile_lcdcfb.c:(.text+0x79616): undefined reference to
`sh_mobile_meram_cache_free'

 Tomi



--Woqssl4lWevVTJTeUS6MQt0Sadc5oMiDK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS2PFLAAoJEPo9qoy8lh71Ou8QAJhexkmnGSubRXneViG77yvF
+qgpT0A2w4FMMViOgNE5L3d84l1NLD/+HuOYpjPPnjrkn+eAUJAArtvi5tZEbexG
WTwx/osAvf+WjSXHAhra9uL5crNB5NR9qt4uXZP6lfw9Wgj3Bg+svzCsebfSQ7aI
pNm8/ETcqtkG/yy/gXFXLfO2O6LqttEAhY5ePHbkP0mFJTRDSV/CnNzKqcc5FEHY
KdbEslkC7XVV23PoBBPotJe6Yq9T4yJ0vo7Q8P8QwY6d8MK8TTkOHUULBv/3MVNi
7rEEl9S9DK6qDeVvt9BFNTsnuiMQ1JIpFlALuW5blE3LRg21TsF9Xd7CF0scWNY6
h5eFfq21FZAkxTGINFCWIht/ENNtqxTxQHnKT1qWQV0zUQKPfknXfK2jNS6dxg9v
SUpk46jgK+I5hE+bvuGmCcc1zGQvgqZcCqrVChKGDKA0UQmYYiAVkLP0DKRL19a2
+aPuUrNNAwmaO5T8XDCbo6f7WESog4R+OGIPT4MV1jsdsXoEYGOonxwncUH2Az30
K/89h49XfbGle7jj20GRL2IM65wf2Tkxy27IRvLLlW+GxRlKHLZWvrUGQhjz6k8Z
5NJ7eLKDybem+dLFdtScybIorOOT6oomMnbaguG+GFJHogU3s/F1Xwg/5bvhiWJA
t9Pdfu9b4MKIhX7PgNCc
=f0S5
-----END PGP SIGNATURE-----

--Woqssl4lWevVTJTeUS6MQt0Sadc5oMiDK--
