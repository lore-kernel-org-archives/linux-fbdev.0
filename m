From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 12 Mar 2013 13:40:14 +0000
Subject: Re: [PATCH 5/5] videomode: rename fields
Message-Id: <513F303E.5000007@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig6824E10AB9A285DB6E50F0C2"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363083578-17062-1-git-send-email-tomi.valkeinen@ti.com>
	<1363083578-17062-5-git-send-email-tomi.valkeinen@ti.com>
	<16625567.P7GdYge43z@avalon>
In-Reply-To: <16625567.P7GdYge43z@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>

--------------enig6824E10AB9A285DB6E50F0C2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 2013-03-12 15:37, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> Thanks for the patch.
>=20
> On Tuesday 12 March 2013 12:19:38 Tomi Valkeinen wrote:
>> Structs videomode and display_timing have rather long field names for
>> the timing values. Nothing wrong with that as such, but this patch
>> changes them to abbreviations for the following reasons:
>>
>> * The timing values often need to be used in calculations, and long
>>   field names makes their direct use clumsier.
>>
>> * The current names are a bit of a mishmash: some words are used as
>>   such, some are shortened, and for some only first letter is used. So=
me
>>   names use underscode, some don't. All this makes it difficult to
>>   remember what the field names are.
>>
>> * The abbreviations used in this patch are very common, and there
>>   shouldn't be any misunderstanding about their meaning.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>> ---
>=20
> I have no strong opinion on this, but I find the existing names easier =
to=20
> read. I might be biased by having read them often though.

Yes, the last patch was a bit of a "teaser" =3D). I found myself typoing
them a lot, using helper local variables to shorten the code lines, and
as I mention in the description, I find them a bit of a mishmash. So,
while they're not used in any drivers yet, I thought it'd be worth a
shot to change them.

 Tomi



--------------enig6824E10AB9A285DB6E50F0C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRPzA+AAoJEPo9qoy8lh7151MP/0KHshfVkKASv3xRKeQsC3SR
xGThJC9yWTOpajNo6+FFE0PRQ7RnXGhsC4/KraMNs3QXSnUG5c/8ZtNxng9T1ekD
GeT/s/ieriD7qmnUGMdthf+xFJo43AN1QFfP5PaRJ9kvM1A+VR1Yu9V0KpXIXzqp
CDtLq1BK99jXT75rY6Aor1QzAnfmCldtNyg6A1FsFq5DA+KNUH2i3rCzPC3NAYlH
Dl7AHZ/4tDxZsTrTTVdb8uGnJpYolZCsVp+2ml3o1783RAzEsXqsrvi90hAjvsPm
Xg9Sf/7KQkZcGTPgx4Tq/yjTAiQs41cqMRZZSHL8Ib/LZnVf7slx7Zj6WbXfStnM
x+UF+CdkADC4KMitUZhr+tuOV1oMA0acDKk/uKb5gZCtUaFJ9YdKcLarvyBbYNDX
xpOxJsEys6oKFTesfhMm2zT7uXmMYpGS/ru95h1ihFk1NXftqbLaJ7grmwBiq8vT
Z9vjakvIrPg7fat+/aArgzNPvBddlApTgZ+I2HFEYWia82/ZTakfJWYc9/pkbZkV
qIcid8FA1qGokd+N5cscDcG0c7HrAToCdxBvnYj6XWnCKHTJRLZ15PE642OH3sE8
uTcClcKIEGBImNFSYUWLqTCGDfYLymnaHGaSj4ZIdfuqn9ve3mchn2KONn5gmMqu
HXInkVzH1/8eCV2qMEon
=aoU5
-----END PGP SIGNATURE-----

--------------enig6824E10AB9A285DB6E50F0C2--
