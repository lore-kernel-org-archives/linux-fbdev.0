From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Feb 2016 11:35:25 +0000
Subject: Re: [PATCH 9/9] simplefb: Remove impossible check for of_clk_get_parent_count() < 0
Message-Id: <56D0387D.9040705@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1i5dj9O8dCn8iuT15ajlAsQkkDsBLmh9T"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456174487-28397-1-git-send-email-sboyd@codeaurora.org>
 <1456174487-28397-10-git-send-email-sboyd@codeaurora.org>
In-Reply-To: <1456174487-28397-10-git-send-email-sboyd@codeaurora.org>
To: Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org

--1i5dj9O8dCn8iuT15ajlAsQkkDsBLmh9T
Content-Type: multipart/mixed; boundary="cXlsU873t5XgLkNaO1JbvnFTdDfQDiN5h"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Stephen Boyd <sboyd@codeaurora.org>,
 Michael Turquette <mturquette@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linux-fbdev@vger.kernel.org
Message-ID: <56D0387D.9040705@ti.com>
Subject: Re: [PATCH 9/9] simplefb: Remove impossible check for
 of_clk_get_parent_count() < 0
References: <1456174487-28397-1-git-send-email-sboyd@codeaurora.org>
 <1456174487-28397-10-git-send-email-sboyd@codeaurora.org>
In-Reply-To: <1456174487-28397-10-git-send-email-sboyd@codeaurora.org>

--cXlsU873t5XgLkNaO1JbvnFTdDfQDiN5h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 22/02/16 22:54, Stephen Boyd wrote:
> The check for < 0 is impossible now that
> of_clk_get_parent_count() returns an unsigned int. Simplify the
> code and update the types.
>=20
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: <linux-fbdev@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>=20
> Please ack so this can go through clk tree along with patch 1.
>=20
>  drivers/video/fbdev/simplefb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


--cXlsU873t5XgLkNaO1JbvnFTdDfQDiN5h--

--1i5dj9O8dCn8iuT15ajlAsQkkDsBLmh9T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0Dh9AAoJEPo9qoy8lh71zU4P/Ao6u5eKhSG2gOvnDBa+oCI8
0dklVqgwbsuV8pdmNuWLOgwtjgGJXonvOJEtPm4lf8Qoe0Bz79a4cx3VzuI4YJX6
toL+hn3UHUZjCZ33ACYbMlAiGhfg8RrxKBrtjDQi1m5EzQjoxmxVkuwcfEQQ5pcf
WM/Ym7M2ObjKWwDON2/BHyemY9MynTnk7KFk6pel2PyPGCuH8+2G5U+uHUXArI9q
fQ1Ttys9cbmKF+bmtvBZ/ZmmpEByUnxygRfKnsnHvAOZmrAa78hJe7qEmE+x2j4R
QhfvVLcjUSML1tM0N/SOSUB5tYBI/m6Dm2oiMC98qJ5r66+q24W0DgPDIyxF3z5Y
8dhurit8nPLGIdoqvJIuo71Ro6c82n8uyU38270EstlLamLFdIwQcsoMoenOhZdG
PnTyKU0mKuDGIUQVQnbSOX53lNSrNBvrsGjk6Kh9Z/VZdqA1fhHfKyBzAsrDD9Yt
TZxO+q/xwj8Iy9H9dktqt65yXpfiGlbw5k6XlHdPx7tay/gc5plJK8MwH04kRszo
SGA1/7ijf1vmeo7hmX0x61rX8dR01FjjU0Qt0v6kOg2ctUdwAH7xox9UfwTS96GM
SUcQEzh1wYB1W2fBG/Q2ycndqceeTHiOFP42MrDNlJOEJPow/oLPZ/nwjjUZn3K9
QU71qwaz+fgfWPs/ljT2
=Y6UK
-----END PGP SIGNATURE-----

--1i5dj9O8dCn8iuT15ajlAsQkkDsBLmh9T--
