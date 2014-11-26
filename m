From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Nov 2014 08:13:39 +0000
Subject: Re: [PATCH v3 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb extensions
Message-Id: <54758BB3.9090008@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="k9stV8awai5muVvitfDxv7P62veX9rvSM"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416309051-26784-1-git-send-email-hdegoede@redhat.com>
 <1416309051-26784-3-git-send-email-hdegoede@redhat.com>
 <547476DA.2030004@ti.com> <54747B72.1050406@redhat.com>
 <54747DCF.9010502@ti.com> <5474824F.8080000@redhat.com>
 <5474863A.5040801@ti.com> <5474880F.8040908@redhat.com>
In-Reply-To: <5474880F.8040908@redhat.com>
To: linux-arm-kernel@lists.infradead.org

--k9stV8awai5muVvitfDxv7P62veX9rvSM
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 25/11/14 15:45, Hans de Goede wrote:

>> Wouldn't
>>
>> compatible =3D "allwinner,sun4i-simple-framebuffer", "simple-framebuff=
er";
>>
>> tell that it's a simple-framebuffer, with allwinner's sun4i extensions=
?
>>
>> I guess you can have just "allwinner,simple-framebuffer", and then if =
a
>> new Allwinner SoC has a totally different display controller, the
>> documentation would specify that this property is for that SoC, and th=
is
>> another property is for that another SoC. But isn't the compatible
>> string what's supposed to use in cases like this?
>=20
> The only soc specific thing in the binding is the pipeline property str=
ing
> values, and we can always add new values to that, the rest is all gener=
ic,
> as simplefb is generic.

The thing I don't understand is that the compatible string states that
"this covers all Allwinner SoCs", even if we have no idea what kind of
SoCs those may be. And if it covers all kinds of SoCs, then it might as
well be fully generic, not Allwinner specific.

And if it's not fully generic, then having it cover all possible
Allwinner SoCs doesn't make sense either.

> As said Ian Campbell, Grant and me have decided on using this, and
> currently
> patches are already queued up for both the dts files and u-boot to use
> this,
> so unless there are really strong reasons to change it at this point I
> would
> prefer to keep this as is.

Ok. Well, as I said, it does not look correct to me, but if everybody
else agrees on it (and I see I didn't get any replies during the night),
I'll be applying this today.

 Tomi



--k9stV8awai5muVvitfDxv7P62veX9rvSM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUdYu2AAoJEPo9qoy8lh71PBMQAIieuGQUqGZmopjJ9ktVQw79
Po3RIsr6sLw0dPwA/a+vG8XvPuCUq+cg62Dt/cyVGm6k7kJ56tv4KVSTZZ3boxvU
NKKn/c/KbXGeJm1Qq5M/ABFRWkCSO5vce0EBCsZff9odbzAqDsrqBnnya1syQog1
DcXcJZCAhX0La+wySp6Zx2Wx+zOCu1VZZ3WEDTpzY4kkHDmHGK/fTEuAafGw8TZs
u6NC3+Q6a84JXlpUsN+RmK2vQ8E+dcPfBxDPQTw1q7cCaff2n0068NqxEkyhkMPD
jadvk4ZXSQrCXlHN/pKdLTeDYIHp4nO5acHvZ0OUKq7EJnLAgIcmMvoOpjSrzk/u
r264QW7DjMSdhoAxsLWCHVgruzjmCj6ZdGS8LRgJ5L4vY8j+uki2apBbc4/T4yAl
kNQOOHTo3PC0thH3l5qwWS8E3ohUWrIG4KCZ/xvElMdCmZp+W6jToCSuwkiImmHv
M7DABqr5WMfLqK5G5muP+2ZQSrp6vNwzHxvqjxE36HMCNl0svi/+QYiDX2Eu24hU
ExNG5KRw/fJIhpdeSDrRoyE6FzUl1ygX178zfVqhMq7s4d78EgOi0wxvwKrKhvlF
Yz7jgimNbO1IGSkGR9dxiYeX3R8KxwjHN9BqS8nhJjiwEZ8/y0JryWijjsQfhfP9
uR8KrPvuh2SXH5cXXl31
=ESdP
-----END PGP SIGNATURE-----

--k9stV8awai5muVvitfDxv7P62veX9rvSM--
