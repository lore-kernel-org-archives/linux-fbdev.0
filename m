From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 20 Aug 2015 09:05:21 +0000
Subject: Re: [PATCH] fbdev: remove unnecessary memset in vfb
Message-Id: <55D59851.7010205@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DV0QPjE4whHF11DQkM748awaHQ9C06tTF"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434632512-128161-1-git-send-email-marcinch7@gmail.com> <CAMuHMdW9g4h0EX_gZsXiTfaXsOTtqOqVN+SN=GtV8zNRQo_LXA@mail.gmail.com>
In-Reply-To: <CAMuHMdW9g4h0EX_gZsXiTfaXsOTtqOqVN+SN=GtV8zNRQo_LXA@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Marcin Chojnacki <marcinch7@gmail.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--DV0QPjE4whHF11DQkM748awaHQ9C06tTF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 20/08/15 11:21, Geert Uytterhoeven wrote:
> On Thu, Jun 18, 2015 at 3:01 PM, Marcin Chojnacki <marcinch7@gmail.com>=
 wrote:
>> In vfb_probe memory is allocated using rvmalloc which automatically
>> sets the allocated memory to zero. This patch removes the second
>> unnecessary memset in vfb_probe.
>>
>> Signed-off-by: Marcin Chojnacki <marcinch7@gmail.com>
>> ---
>>  drivers/video/fbdev/vfb.c | 8 --------
>>  1 file changed, 8 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
>> index 70a897b..b2d38b7 100644
>> --- a/drivers/video/fbdev/vfb.c
>> +++ b/drivers/video/fbdev/vfb.c
>> @@ -490,14 +490,6 @@ static int vfb_probe(struct platform_device *dev)=

>>         if (!(videomemory =3D rvmalloc(videomemorysize)))
>>                 return retval;
>>
>> -       /*
>> -        * VFB must clear memory to prevent kernel info
>> -        * leakage into userspace
>> -        * VGA-based drivers MUST NOT clear memory if
>> -        * they want to be able to take over vgacon
>> -        */
>> -       memset(videomemory, 0, videomemorysize);
>> -
>=20
> As vfb also serves as a sample driver, I think it would be worthwhile t=
o move
> the comment to rvmalloc().

I changed the patch as follows:


commit c0a3229313d6931a77e0c1e1c22e398c0312bf6f
Author: Marcin Chojnacki <marcinch7@gmail.com>
Date:   Thu Jun 18 15:01:52 2015 +0200

    fbdev: remove unnecessary memset in vfb
   =20
    In vfb_probe memory is allocated using rvmalloc which automatically
    sets the allocated memory to zero. This patch removes the second
    unnecessary memset in vfb_probe.
   =20
    Signed-off-by: Marcin Chojnacki <marcinch7@gmail.com>
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index 70a897b1e458..b9c2f81fb6b9 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -51,7 +51,14 @@ static void *rvmalloc(unsigned long size)
 	if (!mem)
 		return NULL;
=20
-	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
+	/*
+	 * VFB must clear memory to prevent kernel info
+	 * leakage into userspace
+	 * VGA-based drivers MUST NOT clear memory if
+	 * they want to be able to take over vgacon
+	 */
+
+	memset(mem, 0, size);
 	adr =3D (unsigned long) mem;
 	while (size > 0) {
 		SetPageReserved(vmalloc_to_page((void *)adr));
@@ -490,14 +497,6 @@ static int vfb_probe(struct platform_device *dev)
 	if (!(videomemory =3D rvmalloc(videomemorysize)))
 		return retval;
=20
-	/*
-	 * VFB must clear memory to prevent kernel info
-	 * leakage into userspace
-	 * VGA-based drivers MUST NOT clear memory if
-	 * they want to be able to take over vgacon
-	 */
-	memset(videomemory, 0, videomemorysize);
-
 	info =3D framebuffer_alloc(sizeof(u32) * 256, &dev->dev);
 	if (!info)
 		goto err;


--DV0QPjE4whHF11DQkM748awaHQ9C06tTF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1ZhRAAoJEPo9qoy8lh71QTkQAKlKG+FPvIiQAns5t2ANrKvf
w/OuW389gtyl2m7KlHmCx8NoeZ2fqrsgmZr8woZ4lcZDtSyN4dfVeUiJr/crIXME
kpl+w1VL7PKDXD+0ZVIs9RvuGBg/b9DSQKHSoJP/6e/fve6KrPPPyUfz6oO/dxho
Lk9N9jvTUsbAysIhIPXf6kGVFk0KXItkQ2CC03jFiEgzc4Aea+2ihXEQS6nPTbVb
LkvN2xcNJyGQN1i4i7UW6WiCd2izVckgzLgW0IANKcXvsSTSGQKxYc66xOmTCF0f
Lt/Jt5m6rGQ2HlSoxNWbAYtV55eGipbslMmReGjnGAQx8B0IR6sLxEvV9uETzOFi
S7N51DynuyL0o/sw+mngIKhP5tvKwEMUTtSsiTawMh3Wc+xh3DLEsTz/njAUEAya
A0BPFVHG7Dm8w9RgfW06OXiWRjVgIT1/bYp4dIS8g8BMcl/hy8ITrL1/kiQGCKtN
yOGmA9SlLBJoHwg0lAKpQYs4rN0WBDogwekVynvOGG13edUt6VPq2W45Uw3CKtv6
6PhBbssIkmtdV120IGIBU+aStkbZc+NmNj7lHvguGCvRSuzjqLW/dPdslx1IM7TR
A/1RIa+IqGQqLRFIrIH5E2JJFYD/rShq2fU8+qCBsWSVZS4TXFbRRXii+DPLma12
1Se1SQqz+wqFxsn+T+sC
=9w9q
-----END PGP SIGNATURE-----

--DV0QPjE4whHF11DQkM748awaHQ9C06tTF--
