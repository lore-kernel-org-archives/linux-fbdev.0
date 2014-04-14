From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 14 Apr 2014 12:53:36 +0000
Subject: Re: [PATCH] video: Check EDID for HDMI connection
Message-Id: <534BDA50.2090406@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9L7AlU6q20nw7fihgnnw6QxvMnxtePoeX"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395873337-41305-1-git-send-email-cfreeman@nvidia.com>
In-Reply-To: <1395873337-41305-1-git-send-email-cfreeman@nvidia.com>
To: linux-fbdev@vger.kernel.org

--9L7AlU6q20nw7fihgnnw6QxvMnxtePoeX
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/04/14 00:43, Christopher Freeman wrote:
>=20
>=20
> On 4/8/14 2:19 AM, "Tomi Valkeinen" <tomi.valkeinen@ti.com> wrote:
>=20
>> * PGP Signed by an unknown key
>>
>> Hi,
>>
>> On 27/03/14 00:35, cfreeman@nvidia.com wrote:
>>> From: David Ung <davidu@nvidia.com>
>>>
>>> Check EDID Vendor Specific Data Block bytes to see if the connection
>>> is HDMI and set FB_MISC_HDMI.
>>>
>>> Signed-off-by: David Ung <davidu@nvidia.com>
>>> Signed-off-by: Christopher Freeman<cfreeman@nvidia.com>
>>> ---
>>
>> Patch looks fine, but how do you use the flag? Shouldn't things like
>> detecting if the monitor supports audio be done with some more detaile=
d
>> bits in the EDID data (not that I remember much from the HDMI spec).
> The Tegra HDMI driver uses FB_MISC_HDMI to select the type of connectio=
n
> it has hdmi/dvi and setup the avi info frames.
> agree that we could use the EDID data to determine the audio format
> support and sampling rates, but currently that's not being used.
> I think determining the audio format and sample rate support could be
> added in a separate and future patch.

Yep. I don't see any harm with the patch, even if it's not perfect =3D).
So I'm queuing it for 3.16.

 Tomi



--9L7AlU6q20nw7fihgnnw6QxvMnxtePoeX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTS9pQAAoJEPo9qoy8lh71BEcP/1o+eF+nC8b87XyXKGnGm6vc
Q4kaKHEMHgurU7/WEir+0uCq1LsmS94FgV8H8T8LvvpTj4QBw/wzuLfnUdjFY8Ii
chM2Ws6vJclNdjDMSXDUJVJBTPWt+3ULZvg6fZUBM4t8RQoV9QMAyAU2EowOfF5s
klqY/KB8merBKseK96G1qGentagEn9PJFqBdOADNObAFnF8W8Ju6MDdDuXXEYsR9
38P4DTNl3jrRQ54fxsUZIcdL6DtWOUGPzFzTgUJc0HKXisbiVhXPi99NCXfeWRim
F/7/xbTM3y1e4/C3slOHRkqLLzimyzKeJ/9z0cuSC3UttB9+TnwO2AdQxMf1beg9
xEcmUBKd48mNmA0rb5//Cgi4ygSDLSacuwjeDnDf8g6tuzjxAqykW8SyZbOfNnsT
n2aSq+G/qpLVhaU/P60MF4xjV66pBSwjcvMAPcD9856rtfKIt8RsA071Yq4tRLm5
xmBLdct+tzi7o54gwkI3mn2YjFgyrtgDITEdHoPDyeF75sADpHhVz8iqBWCJ/BR+
3TPPYWcOSEHGeN/KbwqXBC4T1oydvz9OS4uEH4/2yewbpDBhXbjoP8RMRokOQMl4
M4QfbINn9NDezLy4qvaBsy2gJ3D8XqXgxFcTQQmHqX9DTh7MqrFmies237mUfX59
vWmAg+HRtl6inhc5ZBiI
=7EQM
-----END PGP SIGNATURE-----

--9L7AlU6q20nw7fihgnnw6QxvMnxtePoeX--
