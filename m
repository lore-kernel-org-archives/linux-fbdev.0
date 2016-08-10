From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 10 Aug 2016 10:24:54 +0000
Subject: Re: [PATCH] video: fbdev: mb862xx: mb862xx-i2c: don't print error when adding adapter fails
Message-Id: <176ef085-b9b5-ad0c-da46-9dcbad5e0c10@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="knpuuscOehAqujvgwR8gqWvktJBWLPrDX"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1470742059-12341-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742059-12341-2-git-send-email-wsa-dev@sang-engineering.com>
In-Reply-To: <1470742059-12341-2-git-send-email-wsa-dev@sang-engineering.com>
To: Wolfram Sang <wsa-dev@sang-engineering.com>, linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org

--knpuuscOehAqujvgwR8gqWvktJBWLPrDX
Content-Type: multipart/mixed; boundary="xpGTDgb8JNS4CFXlPH0ulhhfhSR8boBOR"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Wolfram Sang <wsa-dev@sang-engineering.com>, linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linux-fbdev@vger.kernel.org
Message-ID: <176ef085-b9b5-ad0c-da46-9dcbad5e0c10@ti.com>
Subject: Re: [PATCH] video: fbdev: mb862xx: mb862xx-i2c: don't print error
 when adding adapter fails
References: <1470742059-12341-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742059-12341-2-git-send-email-wsa-dev@sang-engineering.com>
In-Reply-To: <1470742059-12341-2-git-send-email-wsa-dev@sang-engineering.com>

--xpGTDgb8JNS4CFXlPH0ulhhfhSR8boBOR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/08/16 14:27, Wolfram Sang wrote:
> The core will do this for us now.
>=20
> Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
> ---
>  drivers/video/fbdev/mb862xx/mb862xx-i2c.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Thanks, queued for v4.9.

One comment: the patch description should be "stand-alone" text, not a
continuation of the subject. I fixed this.

 Tomi


--xpGTDgb8JNS4CFXlPH0ulhhfhSR8boBOR--

--knpuuscOehAqujvgwR8gqWvktJBWLPrDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXqwD2AAoJEPo9qoy8lh71dyUQAJLc+uI/O/5gY3Pwf/YXnNqv
qcaxxexBkNv8KbHFUU74LvZ83p3bAV2vG9k9675PLfg6WBIUD6pKwvd0NcGQWcro
0bWTkjSYK+iV9T2hCm4+jkn7RAJeLkyRBgFAWQK5fVtG506AZCl1ovgexiibJTU3
24xkQPxepe1f+bYX83lotoJKPNUFVFMaPoRmJ5rf4RgcZpTYGr443ox5iHWGGgNX
IbnP4kVbk4pA3LKf/LlNIR+Hoyn7XBDu9Oiz67o1oNzSQ0AiAdklQGOi6kdjdhPf
+pR8lOldwlflMpU+0hpDyEwFA7ioHEOM6s2Y8leoXwhLzhaXNoZQPjMHgz0e56XE
9Fk0A4zjOtFXOLeUQnBhTS5DAwcKHX/9F3DqzLcvBD9X9rUrTdG0hrkrKnKPnxXi
w8enPSP2WpJsdoJRJ+p+U6NWzbErVX/X5Tb4C7JyOAVdn7ipTP8WEI18JY2S55cn
rvQsdrjiYv2pc+Hm7UHjhTvXe2zjzEJgXZV9AZv3BNW13s6wCDBqxmmRBylqLkFK
saSExqBmBZHoo1cpD/E/lN5eP/6251k3mongk2XSAjM5BwVllWjAZV7mWJwwJ49B
wP4WL5ZLOz97COqQ6jawX2n8DRA2ib467kBKSadZwfd+FvvoiCvGltIMWNJ6ZKqv
43BK2szkRLP/2/YHIJfl
=kIyy
-----END PGP SIGNATURE-----

--knpuuscOehAqujvgwR8gqWvktJBWLPrDX--
