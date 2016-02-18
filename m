From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 18 Feb 2016 13:37:01 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <56C5C8FD.7090004@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7gaN2juK5UHoSabcpF0DGweIOJ6CF9nD2"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <56C438DA.5040109@ti.com>
 <CACRpkdZ+G17hmVP8AejL7NTqg7k0SBC5kgF55ASjD+kfuGFJhQ@mail.gmail.com>
 <20160217213250.GK19428@n2100.arm.linux.org.uk> <56C5B080.9090007@ti.com>
 <20160218131233.GP19428@n2100.arm.linux.org.uk>
In-Reply-To: <20160218131233.GP19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org

--7gaN2juK5UHoSabcpF0DGweIOJ6CF9nD2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18/02/16 15:12, Russell King - ARM Linux wrote:
> On Thu, Feb 18, 2016 at 01:52:32PM +0200, Tomi Valkeinen wrote:
>> In my opinion the best option would be to use DT overlays, but so that=

>> the bootloader would supply them, or construct the dtb. But afaik that=
's
>> not possible at the moment. And perhaps I think that's the best option=

>> only because I don't work with the bootloaders =3D).
>>
>> So, I don't like this, but I don't have a good suggestion how to do it=

>> better with the infrastructure in place at the moment.
>=20
> The danger of that position is that we end up with nothing happening,
> and the problem remaining unresolved, which then pushes people into
> maintaining patches out of mainline just to have a working setup -
> which then pushes people to vendor trees.

I agree.

I didn't express my position clearly: I'm ok with the approach, if we
don't come up with anything better.

But if we go with this approach, it must be understood that it may cause
problems later. It's not the most maintainable approach.

I'd also like to have an ack from the DT maintainers, as I think this is
somewhat of an abuse of the DT.

 Tomi


--7gaN2juK5UHoSabcpF0DGweIOJ6CF9nD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxcj9AAoJEPo9qoy8lh71m3gQAIIj3QlhW71n4nRw13KtAbwS
xl4z9LbCA2k8ggdRR3ifnwLEm/ZduuqALIDKlHBWQ8flAYFtPm4DFaH8OCM7Ua/T
GRfOTfgKRJQXrPt/0GsJlKkNkRKAPhT9PuFqqOcYlaPHy5E86y1Q4dCXOpQPYpLe
cKmFGgvazbeRbLZoHSAuaBkVEE9lywjn2pMUVKznLlIHaTH/CY4ADMeH8HcHIzUT
cjyVCth9ad4Cb200rS1uQZwm0t/CU3NRGlvFPvJZP6DNbNVFLZ7vtQpFTV2qgiWm
py3OGwWGD9fSWdatpIrwv+nGcwlOohphZgQdV2/4soTRl06/q5eKZBvh8pGE72RL
iOBt70gNno7DnC0bejNnhuScs5c3ZJ0d+54dgN2jl77myxEDBWUEZGhUzWLeLnV9
M6JdABRpnUkI3hCPP+nUAfqLBSRESIRsL/qI4JoOA5hk9BMQW1a8Klbut7wJkYXt
LySM9XGG44Gd4jZHtPZofC6UVF+SLaAlQx0i2u9RANrU6zxAY+ZSKyHc9J/pYySQ
tm7xAYzIxqYC7xbnPj141xSHbcvGQyIaGykMQy73iC93FPVhOnRIR4rcZHrNWku2
3sV6Z7eFaxKQ3E2srewo1waqoxgx8O6VrVgEU/L7j27+jyEV/UTYRd69zeXw81uj
7ttaSDWgPZwMq8EQAG0Y
=ytUo
-----END PGP SIGNATURE-----

--7gaN2juK5UHoSabcpF0DGweIOJ6CF9nD2--
