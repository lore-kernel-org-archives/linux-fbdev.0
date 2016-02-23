From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 23 Feb 2016 13:00:44 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <56CC57FC.20707@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="l2IJGT70plb4EkhUndq7rgWAaUTounhA5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel>
In-Reply-To: <6859810.tb1t0IEONi@wuerfel>
To: linux-arm-kernel@lists.infradead.org

--l2IJGT70plb4EkhUndq7rgWAaUTounhA5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 23/02/16 13:22, Arnd Bergmann wrote:
> On Tuesday 23 February 2016 11:10:33 Linus Walleij wrote:
>>
>> ERROR (duplicate_label): ERROR (duplicate_label): Duplicate label
>> 'clcd_panel' on /panel@1/port/endpoint and /panel@0/port/endpoint
>> Duplicate label 'clcd_panel' on /panel@1/port/endpoint and
>> /panel@0/port/endpoint
>>
>> So the dtc does not allow duplicate node labels for the phandle
>> even if the node it resides in is disabled. Tough luck...
>=20
> Ah, too bad. I guess we could still do it by also setting the
> remote-endpoint property to node->phandle, but then it's
> not as simple any more.

I think it could be done with all panels in an endpoint of their own, as
it is currently in this patch. All the panels would be disabled by
default, and one of them gets enabled at some early boot phase. The
fbdev driver would then iterate the endpoints and pick the first panel
that's enabled.

That would be almost the same as what's already in this patch, except
(if I'm not mistaken) the detection part could be in platform code, and
the fbdev driver itself would know nothing about board specific
detection or board specific panel lists.

So maybe that would be a bit cleaner. Still ugly, I think =3D). I really
don't like having possible-panels in the Schr=C3=B6dinger's DT data
(http://www.angryflower.com/387.html).

That said, maybe this is the best way to deal with Versatile, without
requiring any change to the bootloader or the boot mechanism.

What is the current status of Versatile? Have we had working display
with Versatile when booting with device tree? Or has the display been
supported only with legacy boot?

 Tomi


--l2IJGT70plb4EkhUndq7rgWAaUTounhA5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWzFf9AAoJEPo9qoy8lh71x7QP/0kPKEZ9eg53GbpzNDq4Mxa3
IEaBHm2u2eJIadWqTMeFPGdyXsfgCYhGJr7INqqITa+baSAtoXPId0By7cL68FJo
Wy7jhlIYBJUecTKwlwpBxmPyW6e15bI1md6xUyFXm4cWBpDjUraYFUSnUeDVlhbx
Ckx8OtL/bDyAaRa8uE9ARaipRtxMF3HQ5iqDhu1BaasvliNDiqWQN8E8kj6QT6fH
TadFT1+Vvujx7Be49FyTtHcq8qrPBHvmmUyvzY+d/xr+eIpc5HhbOgo4nDFcL/4E
TY+6sSUCoQVHiXcbyUqJn2hewIlreU23X3pmemqSrCrczLCMDD6bkt4VBtuvAtRK
7OPUflt2vEJeWjk+8BZN213U5L3n8A7AdWr6QKHi8twAldCwuU7yNEAtVG5k99Qs
j7BrebrMaQTU+cxQeBAESVU5HqvVvu8wLMxdt6McFcSyxDqAcpkNJA7oviT/u6kV
ZF26EaP5S3906j+6yM2YugvR26BV/kYsiffM/80fmBxxeE5Jh8cFg9GDFxms04Nk
BbFQHI9aG19jmD1Q0m90JYeuZ+ZSTxySNCG+cRPHcPU5ElsVG8Pvmc0k5ieNWxyV
LgvLrl4sdA8bhQe+4mqZgUu6OtVchiEdwA/h5PwCbA657SHAvTBBOCTqpVKb8jLT
rJy0XRBSAvomEOpHy0YB
=EcQo
-----END PGP SIGNATURE-----

--l2IJGT70plb4EkhUndq7rgWAaUTounhA5--
