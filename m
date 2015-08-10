From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Aug 2015 09:26:51 +0000
Subject: Re: [PATCH] video: fbdev: pxa3xx_gcu: prepare the clocks
Message-Id: <55C86E5B.4020808@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="S0cOEhbLfLQnnsib9BXMVJJjfrQq9AOl1"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438632934-29506-1-git-send-email-robert.jarzmik@free.fr>
In-Reply-To: <1438632934-29506-1-git-send-email-robert.jarzmik@free.fr>
To: Robert Jarzmik <robert.jarzmik@free.fr>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--S0cOEhbLfLQnnsib9BXMVJJjfrQq9AOl1
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 03/08/15 23:15, Robert Jarzmik wrote:
> The clocks need to be prepared before being enabled. Without it a
> warning appears in the drivers probe path :
>=20
> WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:707 clk_core_enable+0x84/0x=
a0()
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.2.0-rc3-cm-x300+ #804
> Hardware name: CM-X300 module
> [<c000ed50>] (unwind_backtrace) from [<c000ce08>] (show_stack+0x10/0x14=
)
> [<c000ce08>] (show_stack) from [<c0017eb4>] (warn_slowpath_common+0x7c/=
0xb4)
> [<c0017eb4>] (warn_slowpath_common) from [<c0017f88>] (warn_slowpath_nu=
ll+0x1c/0x24)
> [<c0017f88>] (warn_slowpath_null) from [<c02d30dc>] (clk_core_enable+0x=
84/0xa0)
> [<c02d30dc>] (clk_core_enable) from [<c02d3118>] (clk_enable+0x20/0x34)=

> [<c02d3118>] (clk_enable) from [<c0200dfc>] (pxa3xx_gcu_probe+0x148/0x3=
38)
> [<c0200dfc>] (pxa3xx_gcu_probe) from
> [<c022eccc>] (platform_drv_probe+0x30/0x94)
>=20
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/video/fbdev/pxa3xx-gcu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, I've queued this for 4.2 fixes.

 Tomi


--S0cOEhbLfLQnnsib9BXMVJJjfrQq9AOl1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVyG5bAAoJEPo9qoy8lh71Fs4P/jSDwXo4HIxtbCFuPsSUoFR2
SDesBNPoz5/84yaxqqscYNlCbYNiZf8Om8rCW4GpB+a4VNusQeOaNrycw6/OmHag
EHLZIPSGY+/WnmKr1KxNVKcL7AbWFJ1CpZuZi26tNxFkd72TYtZ5aovurONyiCnu
KMui0a3HPSBRNG7nBEupysJrq1oM36NWivTXeRELUkCh8FoqR2ldWqViBg3FKODf
WjCPjY0m0kMIh1nrUWugQn80tB5QuQICm+jxpvY3e5NIn9gopulQP9/rvVUfrO1L
q4E0MaKj2oUcg6Qo9FnZqma5/ilT8S9Svc7sudi9Ih8Dgd/tGEx4bgi/KnA6D94w
7pziIA4Wk4bnitdlrYgkcxxWXLEx4qJpwlx35nDoSzlJRhrbEeiHKk0vFI6R7WWd
8XmZ+2XdIoeut3hTJ7PiJoWzRnnXapRy69tJzF/MyNCMc6pDYGNYJxxwPiwVPNCZ
xrI5VnePml8maXQOKGawZuEKwVwBP2kBUNwFk0oKRfbg5Ms8Dh2A9sEJmHBBFTw1
p7RhvjJdW4HtcXOld/59pvIw+n0jcHVDXslpzq11yxCpgmrgwGgZNfm9JBSelAA/
PH/J4GBSAsWAEESEVF2/+/31SSnB/fBzTZ/b3EdFDd4mpURtT/L2G9+JMfKVX+6U
8IsFPZ2CBYfO7Jvo8qNW
=kmMq
-----END PGP SIGNATURE-----

--S0cOEhbLfLQnnsib9BXMVJJjfrQq9AOl1--
