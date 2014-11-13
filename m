From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Nov 2014 15:20:58 +0000
Subject: Re: [PATCH v5 0/5] simplefb: add clock handling code
Message-Id: <5464CC5A.7010508@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="NtRsRo5Edfc5Vn0GoiA1OQg00cA4hwFJV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415808952-23549-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415808952-23549-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org

--NtRsRo5Edfc5Vn0GoiA1OQg00cA4hwFJV
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 12/11/14 18:15, Hans de Goede wrote:
> Hi Tomi,
>=20
> Here is v5 of my simplefb patch-set, this time with an Ack from
> Grant Likely for the dt-bindings bits, which should end all controversy=

> surrounding that patch.
>=20
> For changes since the original postings please see the per patch change=
logs
> in the patch commit messages.
>=20
> Please merge this into your tree for 3.19.

I applied this and the "dt-bindings: simplefb: Specify node location and
handoff related properties" v3 series to my test branch, compiled for
x64 and:

drivers/video/fbdev/simplefb.c: In function =91simplefb_clocks_init=92:
drivers/video/fbdev/simplefb.c:204:2: error: implicit declaration of
function =91of_clk_get_parent_count=92 [-Werror=3Dimplicit-function-decla=
ration]
  par->clk_count =3D of_clk_get_parent_count(np);
  ^
In file included from include/linux/i2c.h:33:0,
                 from include/uapi/linux/fb.h:5,
                 from include/linux/fb.h:5,
                 from drivers/video/fbdev/simplefb.c:24:
drivers/video/fbdev/simplefb.c: In function =91simplefb_init=92:
drivers/video/fbdev/simplefb.c:399:25: error: =91of_chosen=92 undeclared
(first use in this function)
  for_each_child_of_node(of_chosen, np) {
                         ^
include/linux/of.h:736:33: note: in definition of macro
=91for_each_child_of_node=92
  for (child =3D of_get_next_child(parent, NULL); child !=3D NULL; \
                                 ^
drivers/video/fbdev/simplefb.c:399:25: note: each undeclared identifier
is reported only once for each function it appears in
  for_each_child_of_node(of_chosen, np) {
                         ^
include/linux/of.h:736:33: note: in definition of macro
=91for_each_child_of_node=92
  for (child =3D of_get_next_child(parent, NULL); child !=3D NULL; \
                                 ^

We need "depends on OF"?

 Tomi



--NtRsRo5Edfc5Vn0GoiA1OQg00cA4hwFJV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZMxaAAoJEPo9qoy8lh71xw8P/0a9vxreeaRD8NNJQd3hdLMM
zbXq6K/GwGV7Qv87LAto9HrXUEk/iUZCaPmS7tRjxHnRBdUUIangy0JIraTGEgg0
mNRasHi+h9zaQzqOzAAkVaWhSsiByX3htNwL2oNF9DpezGHmSIBbUOYsbK+g9+73
Ph3v2NhDCbcAori9/yYbrssMRoKrD1gTKFdSpxADrBP64iYw6ZdGtXMIUX1EgEFa
ouJAAsohHEC14R4TJeXTj56mqCQSRuo6yI9QgYKhJiOvFpi3t4j310LNwfbcPfVJ
WytC6U9+WRUAWkdZoxSdYr103i7iH8qwnoE120Vw9wClEjIX3Hd193/kDOf2jgph
QK4atXi81vi9NyX81ooJmMOJMbWUvRmZCsE373bBFXr+FgzIsS07tkOT+K4DVpC5
Wa6xxPsYJR8sS05y2Ok9yebhwPmYPra81otgOamzINWtJ0mECi7p/UPi43ySpMZp
G96MN7/ehSsLccPlXW5U2tbnPi9MvxPFwZVo82DiL1gClHuxEd/9Al4L7AERPdJi
AeMNB50bIMmcr2TTATneZ968ElOtnmt7IuTfpWaDiivHkjN8I56zyYYV51HjFUkY
W1uJtbTbixnPGe6nYOEvSykukn/m9zyGQ/swRssrZcgAmP1o9FzboiDvKDYry7fY
a3GjBNTdXqDXFJykxt8W
=89r8
-----END PGP SIGNATURE-----

--NtRsRo5Edfc5Vn0GoiA1OQg00cA4hwFJV--
