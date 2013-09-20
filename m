From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 20 Sep 2013 10:04:27 +0000
Subject: Re: [PATCH v3 0/5] ARM: vf610: Add DCU framebuffer driver for Vybrid VF610 platform
Message-Id: <523C1DAB.60808@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="P4t2bltVdNa67qkjfnVpUkXr27fAIe1UE"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1376553714-25922-1-git-send-email-b18965@freescale.com>
 <81BA6E5E0BC2344391CABCEE22D1B6D83F448E@039-SN1MPN1-002.039d.mgd.msft.net>
 <81BA6E5E0BC2344391CABCEE22D1B6D8403CB3@039-SN1MPN1-002.039d.mgd.msft.net>
 <52270C71.7080805@ti.com>
 <81BA6E5E0BC2344391CABCEE22D1B6D842FD6A@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <81BA6E5E0BC2344391CABCEE22D1B6D842FD6A@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org

--P4t2bltVdNa67qkjfnVpUkXr27fAIe1UE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 13/09/13 10:07, Wang Huan-B18965 wrote:
> My comments inline.
>=20
>> -----Original Message----- From: Tomi Valkeinen
>> [mailto:tomi.valkeinen@ti.com] Sent: Wednesday, September 04, 2013
>> 6:33 PM To: Wang Huan-B18965 Cc: plagnioj@jcrosoft.com;
>> linux-fbdev@vger.kernel.org; linux-arm- kernel@lists.infradead.org;
>> Jin Zhengxiong-R64188; Estevam Fabio-R49496; shawn.guo@linaro.org=20
>> Subject: Re: [PATCH v3 0/5] ARM: vf610: Add DCU framebuffer driver
>> for Vybrid VF610 platform
>>=20
>> Hi,
>>=20
>> On 03/09/13 11:21, Wang Huan-B18965 wrote:
>>> Hi, Jean-Christophe, Tomi,
>>>=20
>>> Could you please help to review these patches? Thanks!
>>=20
>> There seemed to be some strong opinions that there should be a drm=20
>> driver for this hardware, instead of an fb driver. So as there
>> seems to be disagreements about this, I'll leave this series to
>> Jean-Christophe, who's the primary maintainer.
> [Alison Wang]
>=20
> Thanks for Tomi's comments.
>=20
> I agree that we can implement the DRM driver for the DCU. As the
> bandwidth limitation, I suggest we use the fb driver firstly. On the
> other hand, the fb driver can meet the application requirement based
> on this SoC. We'll try to provide the DRM driver when this IP
> integrated into other SoC.

If you plan to move to DRM driver anyway, I would strongly suggest
merging only the DRM driver. If we merge the fb driver, and a bit later
the DRM driver for the same hardware, we'll have two drivers of which
the other is already deprecated.

 Tomi


--P4t2bltVdNa67qkjfnVpUkXr27fAIe1UE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSPB2rAAoJEPo9qoy8lh71gLEP/2W4F4MDai++tZnA9Hykv+0W
/J5udxsF155YEheA98JcO+WM+KgmdYn5fwd+fL5yMbAXI+UGF2vrHWA7KaWOPsRe
cS/TMRbLaj8OsFCpdiqMqEmKkNifKJQFy9g/+qd9Kq1Pm53PzKTh+SAap/hzGWNq
A3XxhVAx21wyfZ68TTm+jrwnRYgjzosycErXxjl1O2q5YglVDdvoS0DU6Rwa875P
MUpEsmMtK9JDT/3G8yuvaLTu5rjFuXIGUq9L7dr/McCj95Sy/gC37RK2QjZ1G+EZ
nvZkQQ+DzxV4xrUXcg7Qwo1KVKpR61jMgBmxPYNjdFcTPKQb4X6KBz3q1Fo95DA8
aB+UBDcDLSVuACeAdWdlqEXS1IbeHgLA8b4ykHrjC8qtQlNF/hoH/nHRlfJ/84bD
+l4bGc8dlsY/0RIdPbIaydYyRKOiQIEVSSFSBeG2KxjzEHHZdP6WgMJY2F5mdGzK
UXUOOneeFnCrAeXJprdwNoL4XNzoeu/idw+xzudA0Uak+jqUVgogpajYIoDY5cnc
xEkhTo6yPnwocEbmahCz8swZAkrNAbM+Vw1cKfDJLbKoNam/KCpLr+JBCmhEC336
syqg8R8lJZ9zLc9WbBci9JevkhvE4klFVNdC+Ko1iLfieYCf4U3kpXlAaYGDJg+d
66t/Z55mOBLmMcAX+5zX
=Epsa
-----END PGP SIGNATURE-----

--P4t2bltVdNa67qkjfnVpUkXr27fAIe1UE--
