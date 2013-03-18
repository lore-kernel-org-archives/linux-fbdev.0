From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 18 Mar 2013 12:28:17 +0000
Subject: Re: [PATCH 5/5] videomode: rename fields
Message-Id: <51470861.7040201@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig2754B8641FA0B2900ABB2B0D"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363083578-17062-1-git-send-email-tomi.valkeinen@ti.com>
	<1363083578-17062-5-git-send-email-tomi.valkeinen@ti.com>
	<16625567.P7GdYge43z@avalon> <513F303E.5000007@ti.com>
	<20130318080057.GL9021@phenom.ffwll.local>
In-Reply-To: <20130318080057.GL9021@phenom.ffwll.local>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org

--------------enig2754B8641FA0B2900ABB2B0D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-18 10:00, Daniel Vetter wrote:
> On Tue, Mar 12, 2013 at 03:40:14PM +0200, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 2013-03-12 15:37, Laurent Pinchart wrote:
>>> Hi Tomi,
>>>
>>> Thanks for the patch.
>>>
>>> On Tuesday 12 March 2013 12:19:38 Tomi Valkeinen wrote:
>>>> Structs videomode and display_timing have rather long field names fo=
r
>>>> the timing values. Nothing wrong with that as such, but this patch
>>>> changes them to abbreviations for the following reasons:
>>>>
>>>> * The timing values often need to be used in calculations, and long
>>>>   field names makes their direct use clumsier.
>>>>
>>>> * The current names are a bit of a mishmash: some words are used as
>>>>   such, some are shortened, and for some only first letter is used. =
Some
>>>>   names use underscode, some don't. All this makes it difficult to
>>>>   remember what the field names are.
>>>>
>>>> * The abbreviations used in this patch are very common, and there
>>>>   shouldn't be any misunderstanding about their meaning.
>>>>
>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>>> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>>> ---
>>>
>>> I have no strong opinion on this, but I find the existing names easie=
r to=20
>>> read. I might be biased by having read them often though.
>>
>> Yes, the last patch was a bit of a "teaser" =3D). I found myself typoi=
ng
>> them a lot, using helper local variables to shorten the code lines, an=
d
>> as I mention in the description, I find them a bit of a mishmash. So,
>> while they're not used in any drivers yet, I thought it'd be worth a
>> shot to change them.
>=20
> Imo the new names look quite a bit more ugly and less readable, for ver=
y
> few saved chars. And at least for i915.ko development it's been a long
> time since I've last had to type them ... Maybe the real problem is tha=
t
> we have a few too many video mode structures and can't properly share
> them?

I guess it's a matter of taste. But I've received three "I don't like
the new names" comments, and no positive comments, so I'm dropping the
last patch. The first four should be fine, though.

And yes, we should definitely try to use only this new videomode struct
in the future everywhere in the kernel. It sure would make me remember
the names better =3D).

 Tomi



--------------enig2754B8641FA0B2900ABB2B0D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRRwhkAAoJEPo9qoy8lh71DsMQAIdlU94FDwtWkmPIJJ3N1m8e
GGNjn+fNNIH/ifsocoyJ0Sru42cEXHl582d7HMDGVWMpZbD8U68nEezHAa5w61DH
Z50gQzjDvRE1n/Jeq1SpHj5OsrXmBEaQoakx0a0N71192axuM15CCw2+JQgDLAfV
EABKEQX9WsWJoIuQVJ7kZhlM/0MHdcqStgHMhwUqJLWuL+g36k4NcYxPNVpQbeA9
P0KW/DJS8QxRH6vFcyNrThzOaoHnASjKQ4i1ZzQ/LaSdL/x8/O03cntu0B86dwSM
smU9G69wQS+lYBszufRr24hvlTd/9RiAoKduvaXXS3n6mVnvQTWmcyrSI7VwT85r
KzCJp0A/HrAS3U+4d9NspxghMuj6Dy9ua67taDMtRUYeGOfxvA6mC0LU84jyVM1j
xS2/+1FYGFJ/9J+oqtSXj3br99C8uGOir5UWDtRYLxGswvDWuvFQ1D68nQORi/0g
nouk/6DWsFLI27E2P63d7yQWsUzIiknAd03YuKi4Dss/GI8xXJawb16vUkJ6xrtv
A1nyIwhwAirvla/6UjKZt8XG4ijL76PcM/vnNl07B7zbiVv+BZ/CUz8EHeffk5K/
Ur65Kt1VAkwFTlNFtL+0Pa1+F9pKccw2zl/MuaeZPImF9ukqlkOW8igoBlBuucMo
sb2giW2NEDtusDhvZfJc
=rJal
-----END PGP SIGNATURE-----

--------------enig2754B8641FA0B2900ABB2B0D--
