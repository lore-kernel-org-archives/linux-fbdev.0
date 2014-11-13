From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Nov 2014 15:52:39 +0000
Subject: Re: [linux-sunxi] Re: [PATCH v3 1/4] dt-bindings: simplefb: Specify node location and handoff relate
Message-Id: <5464D3C7.7060707@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="BEPFkd1WjqrFWxwtSP9fEc7uLvmTI3xaC"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
 <5464C026.7030300@ti.com> <5464C444.4050101@redhat.com>
In-Reply-To: <5464C444.4050101@redhat.com>
To: linux-arm-kernel@lists.infradead.org

--BEPFkd1WjqrFWxwtSP9fEc7uLvmTI3xaC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/11/14 16:46, Hans de Goede wrote:
> Hi,
>=20
> On 11/13/2014 03:28 PM, Tomi Valkeinen wrote:
>> On 13/11/14 15:34, Hans de Goede wrote:
>>
>>> +chosen {
>>> +	framebuffer0: framebuffer@5fc00000 {
>>>  		compatible =3D "simple-framebuffer";
>>> -		reg =3D <0x1d385000 (1600 * 1200 * 2)>;
>>> +		reg =3D <0x5fc00000 (4096 * 1024)>;
>>
>> Was there a reason for this change?
>=20
> I changed the node name to match the new bindings text which
> specifies that the node name must be framebuffer@<address>,
> while at it I've taken a real world address range.
>=20
> I assume you refer to the bit where the size of the reg property
> is changed ? That indeed is not really necessary.

Yes, I meant the size of the reg prop. As this is an example, I think it
should be as clear as possible.

I guess a valid use case here is to set the size to larger-than-needed,
so that it gets preallocated and you don't need to worry about getting
the memory later when the system has already been running for a longer
time. But if that's the case in this example, I think it would be better
to describe it explicitly.

 Tomi



--BEPFkd1WjqrFWxwtSP9fEc7uLvmTI3xaC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZNPHAAoJEPo9qoy8lh71cBwP/RH/NwBTxWJqw/Dl1J292ZtX
GuFNFaMQ1d08iZr5ENS4GsmU+iNsBcYLoF6hHS0dJvW91Q2zjWKtLI8fyUqhJqgb
KW16CXBYSGYFo4XJq0ul1+FECawQSRmMdtCugITk6SKAT70hhKiWefa5C9Vym8X7
2nDaKKIMYQgd26XFX83kdJ9zu9QnKyAmypczfxDEnXxs92iHoPEtSQ5/L+e3Dw5K
t9ClwOhUEKPFDIJc5YdN7G9fCuDQxhlCun9xX6fCsVnFgWiqyLSf2n3Jepl2bccE
vy6uNGA7LC+MqXgIoeFZNhT3XXraau9UhsiPxcFPAErWz2fkzrk+9R5FkxcLHx9H
NT9znGuZ9hImCQsEfiiSvydtb+bDXNVV1ogn5w14jLye6GDext1RTr6k327Bxvb8
vi7p8X5kG5pykhWnhXFgE1Z5HIwtsF3AIGW0XsBF4WFLnNT/D6J/RlzQ3ZT/F42m
vwjFLVFRT2PgXy6n1Szfofk4KU/7h2IyXSTqpykaIRIfQdWpVhPzInxuUQCmzBJo
DdcOCWweWHFN3LtHRZyXF3n8lTHdQoHIYbxwus5JufKR5SHwFxGxIKtToi1YQRDA
Ur9Xd79aj1VfxCH/zyS8DHxx6kN2+rVbzbI+5kn3gTav6lQk4k0OmzUhRS7fGWj5
QfzwYekNufTmV8rJyvuM
=jrZ+
-----END PGP SIGNATURE-----

--BEPFkd1WjqrFWxwtSP9fEc7uLvmTI3xaC--
