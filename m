From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 May 2015 06:54:33 +0000
Subject: Re: [RFC PATCH] video/logo: introduce new system state for checking if logos are freed
Message-Id: <556418A9.8010603@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dGp7h61nlHpg1N1xBtWBf4EdFB5HQ1xnr"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430896145-8887-1-git-send-email-hs@denx.de> <5562B9CE.7050807@ti.com> <5563EEF9.3080901@denx.de>
In-Reply-To: <5563EEF9.3080901@denx.de>
To: hs@denx.de
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

--dGp7h61nlHpg1N1xBtWBf4EdFB5HQ1xnr
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 26/05/15 06:56, Heiko Schocher wrote:

>> Without locking, the initmem may be freed while fb_find_logo() is
>> running.
>=20
> Yes, you are right, that must be added ... but has such a change a
> chance to go in mainline?

I don't know. To be honest, this whole thing feels a bit like hackery. I
think initdata should only be accessed from initcalls, never asynchronous=
ly.

> BTW: Could this not be currently a problem on multicore systems?
> If lets say core 2 just draws the logo, another core 1 calls
> fb_logo_late_init() and later core 1 free_initmem(), while the core 2
> still draws it?

Yes, I think so...

So, maybe it would be better to not even try to go forward with the
current approach. Two approaches come to my mind:

1) Keep the logos in the memory, and don't even try to free them. I
don't know many bytes they are in total, though.

2) Make a copy of the logos to a kmalloced area at some early boot
stage. Then manually free the logos at some point (after the first
access to the logos? after a certain time (urgh...)?).

 Tomi


--dGp7h61nlHpg1N1xBtWBf4EdFB5HQ1xnr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVZBisAAoJEPo9qoy8lh71Tb0P/09W7glVxl9Qth+qPoH3/sAN
5WNoe4fYhB65yLivIQ9pCRbj/uLZRgQCgscKN8Uy2ACg4ZvONymvziyR+iAsd+hi
gDAwDs4pSZGxoZKZd+NLev2HbAGPFxCq6Q9JSmTcNlfL6LPEmxq8GFXCq/XHCynq
ZK0Fic5Kt5gn1cz7xhpFKpTEtaUUvjeDkdKLMRygD9kBQI4fKd9trtCqTE55U7bO
WaNpSE4PdOZNE1g7CaEkUXAIj/gE6kymLhb5Ljtb9z9ihHRUwhEHIIR6pokJI3r+
J9aLDPX+21w/q05QurPdRfUvguOX0w6J+HkRX/gabn/nzlEYg5O5djpZvqu1L3Cb
6xRCyJ2lUSuKwjzTBBbTIO+FUaewPRdREoy4kTSutZejLInbWKAfhk2JO83AIryP
lccCtsucIHL254UIitj7M1IgrlgT+XfP7hIbZ6Wnoy5I4lVoAuY3AMMFf73jWXSn
PdnK3m70ZvZXv8uaHIqM6zcNAXA4JdEpm2hp6/Ug+J3uwp4Yqvsw7kj5Ci8TgZfl
6tMSGwtJXb3c1lQAQ/f1Y16sgy40R3oPpGHTm4R3Hb8XfOPe/bp1PdNULWN1srO+
jHAImaQ4H/pegPumxZn796C+ykU2hB4RGczCmbam6qnjVbRS2UzMjq2h9H/yiFlb
v00qbCyIAFyJNKEtr0qv
=3GE8
-----END PGP SIGNATURE-----

--dGp7h61nlHpg1N1xBtWBf4EdFB5HQ1xnr--
