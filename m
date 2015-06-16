From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 16 Jun 2015 07:15:38 +0000
Subject: Re: [Cocci] [PATCH v3 0/4] pci: add and use pci_ioremap_wc_bar()
Message-Id: <557FCD1A.4020105@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="otT2tklbgu0iFtpxBthlgG33tIc49awuh"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAB=NE6UsMMoPhkKof+VN7ZUCd81VxrwP9nqHDUj5Lr3DJLm3bA@mail.gmail.com>
In-Reply-To: <CAB=NE6UsMMoPhkKof+VN7ZUCd81VxrwP9nqHDUj5Lr3DJLm3bA@mail.gmail.com>
To: linux-fbdev@vger.kernel.org

--otT2tklbgu0iFtpxBthlgG33tIc49awuh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 22/05/15 00:23, Luis R. Rodriguez wrote:
> On Wed, May 20, 2015 at 1:54 PM, Luis R. Rodriguez <mcgrof@suse.com> wr=
ote:
>> On Tue, May 19, 2015 at 10:53 AM, Luis R. Rodriguez <mcgrof@suse.com> =
wrote:
>>> On Wed, Apr 29, 2015 at 02:08:47PM -0700, Luis R. Rodriguez wrote:
>>>> On Tue, Apr 21, 2015 at 1:20 PM, Luis R. Rodriguez
>>>> <mcgrof@do-not-panic.com> wrote:
>>>>> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>>>>>
>>>>> This series adds pci_ioremap_wc_bar() and makes use of it
>>>>> on a few framebuffer device drivers.
>>>>>
>>>>> Luis R. Rodriguez (4):
>>>>>   pci: add pci_ioremap_wc_bar()
>>>>>   video: fbdev: i740fb: use arch_phys_wc_add() and pci_ioremap_wc_b=
ar()
>>>>>   video: fbdev: kyrofb: use arch_phys_wc_add() and pci_ioremap_wc_b=
ar()
>>>>>   video: fbdev: gxt4500: use pci_ioremap_wc_bar() for framebuffer
>>>>
>>>> Bjorn,
>>>>
>>>> any feedback on this series?
>>>
>>> Hey Bjorn, any feedback on this series ?
>>
>> I meant this series. Also Tomi, do I get your Acks for these as well?
>> Since they depend on pci parts do you mind if we route them through
>> the PCI tree? I'll poke you soon about another similar type of patch
>> which has dependencies on another development tree.
>=20
> Bjorn, Tomi, please let me know if this series is OK, if so I'll
> resubmit rebased onto Bjorn's pci tree.

For the fbdev patches:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


--otT2tklbgu0iFtpxBthlgG33tIc49awuh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVf80aAAoJEPo9qoy8lh71zIUP/2qZKSUjzGHpBsXM4Ttro8/Q
gGJF/4qOXkwASYXd6yd7XeimHXMFy3n9wyIvvB9HLR/+LV0fj3iZZD9ji/du+VpJ
1BlQvH2HSGqVFYHHetco7Rs3dgct7IvNlwojGj5X3BdLSOPkvHi5No4HGLrC5LS2
7rt5AGRetImpJsSRleYPQ5RNcN+3Q8V4tyhcDWRxYFqdz70yVp3TVM9DQ5KqfdHG
AZulU8LN4fjPn300HQN27+V6Q8DK9sUTekuHefHCp6V2sLxEeyW2WobxZTFUUrRK
bJNgjs868L0OXlUuSH7DwtUuOQx0cy82kIbCWUAn+b4NwcUs2VRbqOb+BzY9Ti+a
DnYuAppE5k3AY5s37kxoJBHhE2uFnWQuvvZtkYerWVcHzFL3abalyjmYwkQxqhD8
pSMZhRI14vJdsMKLvpAjPXaoXr6vFv8CjXfmgkZyu3yNaEVVcQXe8OdX08JvDDNm
9OQQIjc85toWD6HgYFRvL1zVUpMTzzwfjJ4NVlGc32fJg/XjElcr/YuoZQUQyUjs
tTSTZWFUvCnHGqQ5JpFy0iJdHnzWjY7e+lxSe9kmLHp7iY2+lwhfI7C1EjkNiTo+
AFfhL5kptkOQ7xDZHzxqsfEthM3oBvH9nVxpQMM4XYok8O2MkqUaSFYMirDZoZfH
ukWrQBkI00S0m0HhF5Gh
=QysA
-----END PGP SIGNATURE-----

--otT2tklbgu0iFtpxBthlgG33tIc49awuh--
