From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Sep 2013 09:37:19 +0000
Subject: Re: [PATCH 2/2] video: of: display_timing: remove broken of_display_timings_exist
Message-Id: <5244004F.6050105@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="M52s4qoQ1jeLBQmD76vsjHgcgVfV1MUPd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380109892-13040-1-git-send-email-a.hajda@samsung.com>
	<1380109892-13040-3-git-send-email-a.hajda@samsung.com>
In-Reply-To: <1380109892-13040-3-git-send-email-a.hajda@samsung.com>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: FRAMEBUFFER LAYER <linux-fbdev@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Kyungmin Park <kyungmin.park@samsung.com>, dri-devel@lists.freedesktop.org

--M52s4qoQ1jeLBQmD76vsjHgcgVfV1MUPd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/09/13 14:51, Andrzej Hajda wrote:
> of_display_timings_exist is implemented incorrectly.
> It tries to find property instead of node.
> The function is not used anyway so the patch removes it.
>=20
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/video/of_display_timing.c | 20 --------------------
>  include/video/of_display_timing.h |  1 -
>  2 files changed, 21 deletions(-)

Fix by removal? =3D).

Wouldn't it be better to fix the function? It's not used currently, but
the whole display-timings stuff is still quite new. One could use
of_get_display_timings() to check for the existence of timings, but that
function will print an error if no timings are found.

Then again, what would be the case where you want to check if the
timings exist... I'd presume that there either has to be timings or
there are no timings.

So, I don't know. Any else has opinions whether to remove or fix the
function?

 Tomi



--M52s4qoQ1jeLBQmD76vsjHgcgVfV1MUPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSRABPAAoJEPo9qoy8lh71XrsP/jrUKzcLvl7QMgBaudTx/MKD
NMHBTmW5SVQjClvYg2UXGhXx5BY0qLi4gV/GgBD+eniiGhWqhAEL1JK0Dkw1LCGe
PDqG42LBcYW9VFLyx1QLiKS5b+prt+p6D6goTcMV1RTybGVP4cRCLCwA+bNT25Q2
ybJLDrxOnwOSuaakDylL0ERDCaN27zOvAucLw+E0z9KjDTqzjoet/cBTanj6vZS+
FgDDJk7VXMiUbNOTqi3Rda+ilwRrBaFc1YNDMKxBQF+1nIXxckH75G/KFsoVqe34
TohPd1py8d3PtnDQvdeor0OKC+L13AahNt+BOT3TNIM1oI8KpuqEW2OnYK57v1IJ
6T7kK9HPUbONG/4OKc+36TVHB72GG1grpOV4KmKgllcCxl7oNeAD6lpEG93WXVR1
kNvC1Bk+0cE83FZ6GfGkPf7HFtlRoP7xkkfNcCA73hFncbQYpi1ADs3R+hbIr77J
QrlERqQ+K/APmo3zrlIC/Ny8cB6+cVege7Y4K2XDiUhcYYamXpEfl3BUv7nYx5XP
zziCXTqKTQlwgr3O1Vh+whqoxez8Dq9lJ4G2UvL3Fqm4IRiKv/09mFIPwsMOfln1
EbLpaQusbgS8zPBsPBGN30dbdwfLKwWvTtcJqaNTSZ6HsVvvCte+IX9GZqcleVJR
xOr0GOG4JuKWMIjF/KSR
=RJBX
-----END PGP SIGNATURE-----

--M52s4qoQ1jeLBQmD76vsjHgcgVfV1MUPd--
