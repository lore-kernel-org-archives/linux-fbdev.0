From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Aug 2013 11:58:37 +0000
Subject: Re: Bochs VBE & Virtualbox framebuffer driver
Message-Id: <522088ED.6080300@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="HoHGDmKGmNo8XD5CfmdNsFabkXemB3nvV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <5211D634.3010204@castus.tv>
In-Reply-To: <5211D634.3010204@castus.tv>
To: linux-fbdev@vger.kernel.org

--HoHGDmKGmNo8XD5CfmdNsFabkXemB3nvV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 19/08/13 11:24, Jonathan Campbell wrote:
> This is an experimental framebuffer driver for VirtualBox and Bochs VBE=

> displays. It started off as a proof of concept and grew into the code i=
t
> is now. When testing Linux in Bochs or VirtualBox this allows greater
> control over the display and bit depth, though no h/w acceleration.
>=20
> What do you think? Would this be something that could make it into the
> mainline kernel?

I don't see why not, although I know nothing about VirtualBox nor Bochs.
But with a very quick glance, it at least needs to be changed to match
the kernel coding conventions.

 Tomi



--HoHGDmKGmNo8XD5CfmdNsFabkXemB3nvV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSIIjtAAoJEPo9qoy8lh71MywP/iCKLMUjwmKy209XL4VKNrR2
TOYc3RWdqmYVO7CicDOdPzAxmMzA/U1QxivBb/wAW2ykW88wSluG1yL47AqzKjEl
+pRDBvO7zs9EwhyHPB32Pt/B3NHUikcUcKKKgnO7L6YUjLco+QU3P3ub62a1WYYO
6/xnr4LRpXMbLnmwZGZ0yv9PmCJOvv1Z/fqpqxegN1fWBZMlccP+FSo6TUcd6KpW
5VYRzXuswxC2shYInjW/J6rRmn7Kr7pcLlwZmnmUVH4Q5ZV4ZMlT31PDOHR7MWbT
b/dhvnqtoqpgx1uJhuyRbMzwaTOnj7DbttjsrNVnFiHPsynJYW5KAiRMaJs62FlW
Pgol4aagxIM605e24Yp8ofP8sVPw9+PKGw/HW4jm9gBG9IBhipeLbGdHs9DgVh2M
A6iAFd/obqSkdjCuEBkq9Efj0R3FILXVjXL9B6Y4dxmVtkoOSpGlqELOH+E/+G8I
+XG6zxWBXuuOL4glG5GLP/asaPWPhfI4WKawFL5gYSyn/VLKYm8Z+0ofnqsDUhPz
ahfCOiiHeUb1+SY2LaTVNzbTOpNdm2MX9bB8IkWrLH4rs9yyo1Y6ZL4AD9TZudef
LjjWBwhX2sF5SCc8ejRHp/gNj0hLcPTiuRjJTev3k84eRzmu7cRkz3l9+FVddeqM
ThmL9TriN94zLUbPSgdi
=Eu+Z
-----END PGP SIGNATURE-----

--HoHGDmKGmNo8XD5CfmdNsFabkXemB3nvV--
