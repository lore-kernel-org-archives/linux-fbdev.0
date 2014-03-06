From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 06 Mar 2014 10:30:36 +0000
Subject: Re: [PATCH 0/4] Cleanups and fix for video/pxa3xx-gcu
Message-Id: <53184E4C.1030408@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="iSp1FtNsExwSlFdS13HeRAKqJCDp19LTL"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394035969-32420-1-git-send-email-zonque@gmail.com>
In-Reply-To: <1394035969-32420-1-git-send-email-zonque@gmail.com>
To: linux-fbdev@vger.kernel.org

--iSp1FtNsExwSlFdS13HeRAKqJCDp19LTL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/03/14 12:18, Daniel Mack wrote:

>> As a side note, I've got a drivers/video/ reorg patch series, possibly=

>> headed for v3.15, which moves the pxa3xx-gcu file to
>> drivers/video/fbdev/.
>=20
> Ah, ok. So then they really better go via your tree then.

Git should handle it fine, so it's not mandatory here. Still, I'd rather
have them via fbdev tree.

>> That's clearly not the right place for it, but I
>> think it's easier to move it along the other files, and later move it
>> back to drivers/video/.
>=20
> Maybe it might be worth adding a subdirectory for hardware accelerators=
?
> Because this is what the pxa3xx-gcu thing is all about really. And it's=

> only a tiny transport layer that passed commands between the hardware
> block and a DirectFB userspace driver.

Well, there's drivers/gpu/. It sounds like a good match, and by "sounds"
I mean the word "gpu" sounds like a good match. I'm not sure if other
people have opinions on what drivers/gpu/ should contain, though.

 Tomi



--iSp1FtNsExwSlFdS13HeRAKqJCDp19LTL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTGE5MAAoJEPo9qoy8lh715q0QAJ+aAdfx7SOuzYcgPVJAOQqi
rsfbWnnUFYvo2ia+U/mZdpVan4d/0flK0DpXs77S78PDfhp7vwNtCUeA+b3sNeOo
LiCugi9UyMdGARR93luYGaCRZSGmk4sR2koS9rvU9AByZnbvC7WO6EDIVlVI9ep7
pxsKxPjKupb8M3gwFE50wh0B7iPC5aqSA/4XrMkKLvN4xQBzGL4jHJwfx5tZ1vTv
izMAP+cxU2+n52bCaKr6K9B6EnG1M26R0okm7EQ7tXy3H9B/DV/xW76n0GDEfwmp
UvyeAQrbAorC+o4ZgyjqUp3bMj97XZ+j2l/FvT8OAd4x1XWiIZ0YT2c/P6me5I3J
8u5JKIMcJwQZnFBrS/VDeR2tbnElT9h/qCuHR71jQYDOK8/wqWbAVaSYdDAr5NT6
KvhDTO/lE/p90sjOCKEpHp/p7fN2/qGj4V8czjGzaFfWKO7F9M/UIN38g7EF/w04
lqPDtbdJeljnZ2WGNqwwxov0BHInzYw/wE3CAer4K3BkQO+rUF96yJg7gWQ7/wZU
hq3B1dVETonUJZ3Z4+Lgug7JiV6UIViSUZJlfRCX2E4qFjlhiMUqj9QYe4s5rzx+
DfXGPU9fCzGfawEXX7nTOGSjoeDMNk7FmuVyuYbidH3HYRF0ret0xHoQ+/6m/h/W
2hjYfHbF4S8Z34Yp8UZA
=3XQc
-----END PGP SIGNATURE-----

--iSp1FtNsExwSlFdS13HeRAKqJCDp19LTL--
