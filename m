From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 15 Nov 2016 11:40:06 +0000
Subject: Re: [GIT PULL] fbdev fixes for 4.9
Message-Id: <c1cf7b43-0cf8-3f7e-5ad8-56c3c5589563@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="HJUPTJ5jPmxOC5DeSMPl6Jl50Ed1uOs66"
List-Id: <linux-fbdev.vger.kernel.org>
References: <b74835d1-b878-55ec-65d3-dd3766a5b194@ti.com>
 <CA+55aFwygcJpoEWWZyB5R3e25=842EuQ0wxFvdn5uyhtEo9Kkw@mail.gmail.com>
In-Reply-To: <CA+55aFwygcJpoEWWZyB5R3e25=842EuQ0wxFvdn5uyhtEo9Kkw@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mathieu Malaterre <malat@debian.org>

--HJUPTJ5jPmxOC5DeSMPl6Jl50Ed1uOs66
Content-Type: multipart/mixed; boundary="DhkIDap4kNriVC5aFBfIGRnoHk916OgXM";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mathieu Malaterre <malat@debian.org>
Message-ID: <c1cf7b43-0cf8-3f7e-5ad8-56c3c5589563@ti.com>
Subject: Re: [GIT PULL] fbdev fixes for 4.9
References: <b74835d1-b878-55ec-65d3-dd3766a5b194@ti.com>
 <CA+55aFwygcJpoEWWZyB5R3e25=842EuQ0wxFvdn5uyhtEo9Kkw@mail.gmail.com>
In-Reply-To: <CA+55aFwygcJpoEWWZyB5R3e25=842EuQ0wxFvdn5uyhtEo9Kkw@mail.gmail.com>

--DhkIDap4kNriVC5aFBfIGRnoHk916OgXM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14/11/16 18:25, Linus Torvalds wrote:
> On Mon, Nov 14, 2016 at 3:44 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>>
>> Please pull two fbdev fixes for 4.9.
>=20
> No.
>=20
> This has obviously never even been test-compiled. It introduces two
> new annoying warnings.

Sorry about that. I dropped the patch for now and here's a new pull reque=
st.

I did test compile, and I would have noticed errors but I missed the warn=
ings
(I blame the flu...). I need to improve my testing methods, but I couldn'=
t find
a way to add -Werror to kernel builds. I guess I should just always captu=
re the
warnings and errors to a file, and check that after the build.

How do you test build?

 Tomi

The following changes since commit a909d3e636995ba7c349e2ca5dbb528154d4ac=
30:

  Linux 4.9-rc3 (2016-10-29 13:52:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-fixes-4.9

for you to fetch changes up to cfbd950d5e6e649c6c1a88925feada64f890c894:

  video: ARM CLCD: fix Vexpress regression (2016-11-03 12:20:14 +0200)

----------------------------------------------------------------
fbdev fixes for 4.9

* Fix CLCD regression on Vexpress

----------------------------------------------------------------
Linus Walleij (1):
      video: ARM CLCD: fix Vexpress regression

 drivers/video/fbdev/amba-clcd-versatile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


--DhkIDap4kNriVC5aFBfIGRnoHk916OgXM--

--HJUPTJ5jPmxOC5DeSMPl6Jl50Ed1uOs66
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYKvQWAAoJEPo9qoy8lh71rigP/jLpfw1P0UpaVBwGcIF2hKEX
ZX7uKQWLsvGM/QFfwiqZK4AXX69JRa4cEMOq87X4z54L+2iCxx3TxUyyTHBq1Qn+
xhQ/ZGuM/GeqJwz6P9FPm3KN925iyI3qsHVTmuoOjcOfGVE3dwP8scW9hzrlCzTH
Uk/5jd2wt8+wxdVMGyveO0Zfll7TK/1Pp3heu9VNl55+SPWxto9YD0VqftzO7R3/
3B1sSKKIUtyTeUjgbCBsigacj5TMyCGpw5euMLswESrqjSnEdjohhWbGLQV3uCPk
KgtKZkK0Lv5H2QgvxpH7g+xUrls0kaPwEt/+o2FK2RFrOBZNWkMz9u6G+r5ZH7Ky
N332huTbbZCVFxh172dHJq0rw0fC08n3KwQ3Le39KjbTlRZQNJOk1wOKQJB1M4f3
EvzdwGO9x71PmyD4x5uP39DlSJ3s9LZu1ZRN1GZXB+JCh/BMqsFtgdyf8QTCMdTL
VKdYqAkAIcZ64z3UeD9aDM3rgTSgYbG9zYDzC4eb0tBSv6q7yBpUp9UcNyVuZ2vk
BHZVo+AEapz6+idyT67Mn/tID5HXAkvZshhVoyJDpYoGg8XaNukILgFgv25y8Zp9
Ih6EirqKH8DifHY8s2Ap9oDZsoxVKJTAcmZUwdTarD/hm2GzEXKtTD6XdiAOGGDr
vcLGe4A7u6hXhngjv29d
=0A8M
-----END PGP SIGNATURE-----

--HJUPTJ5jPmxOC5DeSMPl6Jl50Ed1uOs66--
