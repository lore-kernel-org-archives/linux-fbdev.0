From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 31 Oct 2014 08:15:31 +0000
Subject: Re: [PATCH v4 0/5] simplefb: add clock handling code
Message-Id: <54534523.8080801@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ER492xxKe18xpMuW2luQFtQPIs7CSwEuS"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org

--ER492xxKe18xpMuW2luQFtQPIs7CSwEuS
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On 22/10/14 19:45, Hans de Goede wrote:

> -We will add a clocks property to the simplefb devicetree bindings, so
>  that u-boot setup framebuffers passed to the kernel (for early console=

>  support) can properly list the clocks used, and simplefb can claim the=
m to
>  avoid them getting turned off, thereby breaking the early console

Perhaps this has been discussed earlier, but I started to wonder if
managing clocks is enough.

What about regulators (to power the LCD), gpios (to keep the LCD
enabled) and pinctrl (for video signals)? I guess any those could be
reset by the kernel if no driver uses them.

 Tomi



--ER492xxKe18xpMuW2luQFtQPIs7CSwEuS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUU0UjAAoJEPo9qoy8lh71Rq4P/iBMueYx1qH1hmpij6KbM3zy
xv920ZWRO6ZmV+lvcZRE+rFJJHkjqOySvcZZxrM35Kfdmu3DgtPKAZmVlr296bhK
Ler9dTX7oXjDJ1liOD+C+5GRLqpr74wWX2bDtjfhdjsQBtHIOkFVyv0/hO0G+wee
X+6aiYlBBbRLizzYTPEyBLTXkI57WmfnPtLfs+11rS7FrFk+LwZ1trdGJjwY3/C3
P+kJkYrd8b5s73giOXsfgsKK4j9rMnfP3eNlEABjBPY+JRN0kQbC3PGoNKJE+CXA
kkJFvxc1WdkZMFoVo32wQm2dQYEz6qPQxg4gWYJGiJrIJ3LRlep3yVPSvOafAOpu
y+7KK98JgzG2wx18y2dPqbJSuTZiF/ndeiysXtHftnjDvJJaVr+OIJrPKpLrSyj/
oqUOIjB7Qs1JWFZ512u67gGzm+cN2oagnGDAW3pCOVmvMXmPCcJk2X0dSDSd23cd
t6ewYybrZP5ip95vAyhFk2m9C3PbnFWWV6NKflG9vEklC9fZFKHTrXMd4O8UTBgO
0T0IXt8KLfvLCY9jWzU6Ve9mYjttUxrAaI8hjqHLb8L/BgJc9NhZ26QX1YVoYmqt
6Pk0Dyry/4vgSvKMzew3eXOe4vwqMW/G4I7NWnqf+R8yHitjHKHlzJWSiqNAczv1
0VdACYy3HLfIbv2oryev
=m8dE
-----END PGP SIGNATURE-----

--ER492xxKe18xpMuW2luQFtQPIs7CSwEuS--
