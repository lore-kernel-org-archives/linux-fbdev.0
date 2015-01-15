From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Jan 2015 11:42:52 +0000
Subject: Re: [patch] fbdev: off by one test (harmless)
Message-Id: <54B7A7BC.7060700@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0rRWJtsgta7dWItoR7TJ62KJ7wVfSHblj"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20141226172657.GA14762@mwanda>
In-Reply-To: <20141226172657.GA14762@mwanda>
To: linux-fbdev@vger.kernel.org

--0rRWJtsgta7dWItoR7TJ62KJ7wVfSHblj
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 14/01/15 07:24, David Ung wrote:
>=20
>> -----Original Message-----
>> From: Tomi Valkeinen [mailto:tomi.valkeinen@ti.com]
>> Sent: Tuesday, January 13, 2015 3:19 AM
>> To: David Ung; 'Jingoo Han'; 'Dan Carpenter'
>> Cc: 'Jean-Christophe Plagniol-Villard'; 'Daniel Vetter'; 'Laurent Pinc=
hart';
>> 'Rob Clark'; linux-fbdev@vger.kernel.org; kernel-janitors@vger.kernel.=
org
>> Subject: Re: [patch] fbdev: off by one test (harmless)
>>
>> * PGP Signed by an unknown key
>>
>> On 29/12/14 23:51, David Ung wrote:
>>>
>>>>> test is really a no-op.  But it's still off by one and upsets the
>>>>> static checkers so we may as well correct it.
>>>>
>>>> 'idx' should be 0~63, because cea_modes array is defined as
>>>> 'cea_modes[64]'.
>>>
>>> According to CEA/EIA-861E, there are 64 defined modes, but idx is
>>> valid for 1-64, 0 is reserved hence the check for
>>>
>>>         If (!idx || idx > 63) {
>>>
>>> Think idx check really should be !idx || idx > 64 if following
>>> CEA/EIA-861E
>>
>> In that case there's something funny with the code. The code indexes
>> 'cea_modes' using 'idx', and I _think_ cea_modes is already offset pro=
perly,
>> i.e. there's no entry at 0. But its length is 64, which is not right, =
as there's the
>> empty item in the beginning.
>>
>> So maybe the correct fix is to increase the length of cea_modes to 65,=
 and
>> change the idx check as you mention above?
>>
>=20
> In that case might aswell go with CEA/EAI-861F for completeness and hav=
e the check against 107.
> but with a slight waste of memory.

Then we need to fill in the new modes. Or leave them blank, but then,
what would be the point.

And I'd rather not add new stuff to fbdev that is not absolutely needed.
Everybody should move to DRM =3D).

 Tomi



--0rRWJtsgta7dWItoR7TJ62KJ7wVfSHblj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUt6e8AAoJEPo9qoy8lh714icQAJMab3Yx8TYehBYNBvhSALkJ
fEKQ0PqqLAawUF2dbXP+FWf2Ke0DZCEQfKkyW5arooMiR9jqgMNJdIE9QFGs8W0D
+FU5Lbn6mLAPiT4Ftf166FuvqSNiD45CTdlZ15/Z40gZ3UH8p+YhNakeHcj4kI46
6SKmher0T4dK7UbTSE9SwuunuO3rYt42VJCmZmWqvN91/AJFwHlD+zsAuY1xZUIV
XTLIfxkaEAYGLSIGGn29BaxEWxPX2b7hGYwHSg6voHTdt1TT54SWqKO4Q58ySsqb
VMlUFaCBLLHt3x2Dhqf7vaINXfpM4HMQ4o5vQhZLrAH0fl6o43vUbuGtWAo319/x
UkBqzVdyAN4U4gfFSPQbMkrjdFPZB/wOR6Ko0z/Rz09+wlz+hiSn/E9NAj/GEmO2
3K2zUIwM0zYmPAzklwFnthaC/Hf1sOYCt5/otpklUiOzRnOJyq66Cd5NLbUtrHzO
zzYQzcpHUm2yn5zix69m7wBq81DpoiaaRieaey97oBlNd/0N6IvQfCKMJHuip+4s
Dl6ZL+beBVS3G3qzkTJidyRt98rTJ8iDyWznJkUwYyXY80Fi45sRi6wLOcGgvgA7
hVgJ4Hi/kjDd5s4FlonDoWYbVfvwK+pf+JtIO0NWeH8CWl4Jz0VXI7mNj0pwqMUT
PXIvlGIwuhk7yLZXhH8Z
=iA2J
-----END PGP SIGNATURE-----

--0rRWJtsgta7dWItoR7TJ62KJ7wVfSHblj--
