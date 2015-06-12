From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 12 Jun 2015 09:36:22 +0000
Subject: Re: [PATCH] drivers/video/fbdev/sis/sis_main.c: avoid repeated strlen() calls
Message-Id: <557AA816.4060102@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JFl2GQwRmQrR5M1h1xSgpq8v9tQXknHbi"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1433855066-20260-1-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1433855066-20260-1-git-send-email-linux@rasmusvillemoes.dk>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Thomas Winischhofer <thomas@winischhofer.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--JFl2GQwRmQrR5M1h1xSgpq8v9tQXknHbi
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 09/06/15 16:04, Rasmus Villemoes wrote:
> gcc is not smart enough to realize that strlen(strbuf1) cannot be
> changed by the loop body, so it is forced to recompute it, at least in
> the branch containing the assignment. Avoid this by using an
> equivalent stopping condition.

Does it matter? Is sisfb calling sisfb_search_mode thousands of times?

 Tomi


--JFl2GQwRmQrR5M1h1xSgpq8v9tQXknHbi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVeqgWAAoJEPo9qoy8lh71iM4QAImCpTXHO6ndRWVtWLaGpDGA
jzZs3hEEFDcaLHNDznNVgIubM/AcBZLvPbyg7qnuawd3OivEU4jXjZzpoqWuqh7G
w6/DI3ZSzpatw0nAnTwFaQvnm+fLzpyKM2X+Emvoe68d6PZxx6GRkdTxpznDETkA
RKAyKq7La2p1ptST9CgG6DXo6Bd03ZE5uynhrVzsHE0VMtr+j1JJbb4yDWdXj0j8
xeQDFq1c7OyskKj++09LpfPQEujQPx7pjNiXONNk5fSmRtSWBJiG09HQbQVggK4f
4LwzGOZuuV7PhQ+nFVRFoZN2CFtM+keCn94ydxIr9nPCZuOCp7vvEWwNm0o5A7+A
whgs/ipoDuV+ZwJQo/F6l01JCbso2basAH9M65aY8n2w4ij8LzORgwok9/pmsu/F
8wJ0OSqLioYyTHdMtTG2dMn0yfq1BHevSDJnJ7Wfm/9DnXgzigVdQMzZQSXFqLk5
cdnvtBkS2M19eMWo9wIVwxusDA6J2nh53hWWHqTpdSH0dCkrIIo1ZtV37SUeuCPQ
pXdCD1dPbi3KHnFbyZUjoOcI1JonJtGs4EnAOVdZqohh8CreF7wRAEpvvc5FuiVZ
5lUxyByoboZE3+/Tm/VpkyVOzePDZUM6reNPRJc32F41+lkTPsGnCPQTLIxKgjmP
3bw8iWs5WkYjvw/a3HUU
=Vm1S
-----END PGP SIGNATURE-----

--JFl2GQwRmQrR5M1h1xSgpq8v9tQXknHbi--
