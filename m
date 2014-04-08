From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 08 Apr 2014 09:56:24 +0000
Subject: Re: [PATCH 0/3] video: clps711x: New CLPS711X FB driver
Message-Id: <5343C7C8.5020300@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dFjmgAmtEVaLBB4Le7VIOBobiuPidE8un"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395332675-23135-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1395332675-23135-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--dFjmgAmtEVaLBB4Le7VIOBobiuPidE8un
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 20/03/14 18:24, Alexander Shiyan wrote:
> This series adds a new framebuffer driver for Cirrus Logic CLPS711X
> CPUs. Since all code rewritten from scratch, patch is designed as a
> replacement of the old (not updated for a long time) for a new one.

Why was it rewritten from scratch? It's almost always better to improve
the old one, than write a new, replacing one.

 Tomi



--dFjmgAmtEVaLBB4Le7VIOBobiuPidE8un
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTQ8fIAAoJEPo9qoy8lh710XgP/ikYE3xurnV9hMMivzIMV50S
DIdIiLcYroIw7uoGEMvXbzwRxSxiiaryVu6Hrga07tCf+6pCIGFwQYMLid2YJCsa
wmx0jlWJTm8hDSfFpPIlFjWcxcsh796bLzhPy3V5/lyiaMieBNn6XsLb8mBeAeLR
fodFSQusXEUOUv/T0O5BRP4SOoGyyVP/+Iy3MHN+A6K3WPDuEQBv6SwvyUIqUVnQ
Hf9vEKdK7In4sZ/y2Zc0+VVVyV2xaodmqi5NGkcnuEcSuyg9VETTUM1Iiq4osgiK
BRWHhF8+tkDS6oDgFjunkXYlyB2YPjJ4/5dfd7Ef7JwfMT+4tHHRlebhcbShqYF3
0hcsPD+wUgBsgt3k1BYSmnlhFmfr9sXi3NTBxNSRY/KKtysCduLRVXrbjHIReal/
Dt6m7bF0ijBw8GQM98zuRgzeRyT5ulrkIIrw2LJZW2xav4kkXcVSA4Xt9HR5EU1J
8FTDKWcPezYMT1ADAanz4+AI0QW2/N2B1JDzs/WbFW6ShiKTRlY1HMuLXmxlpOFF
GGjYel9ZugeMuCTNM3PpQDy1EDOK4HJL/K0IQ9ylx5UUuxXu0iuXLWzjRpjssHDi
5XxYvbkc+Gkwr8epCdlM5gaynyrBS5CWJHdh27/FooprN5kDIO5UNhP58qdm4YDT
SXQztM/MmLrIQ3VqInwG
=f4Yd
-----END PGP SIGNATURE-----

--dFjmgAmtEVaLBB4Le7VIOBobiuPidE8un--
