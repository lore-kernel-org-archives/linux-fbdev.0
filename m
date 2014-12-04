From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 04 Dec 2014 07:05:46 +0000
Subject: Re: [PATCH 1/3] video: fbdev: vt8623fb: suppress build warning
Message-Id: <548007CA.7010900@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="L4Lxibdg4wNuWqHgMSfIIPIH9i8pleOPu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417039645-5313-1-git-send-email-prabhakar.csengg@gmail.com> <547EF8CC.9030502@ti.com> <CA+V-a8vnv4B77XvbzwNkJk=vqGCFWoXxFoyUf0ZNiKwa+gY2ug@mail.gmail.com>
In-Reply-To: <CA+V-a8vnv4B77XvbzwNkJk=vqGCFWoXxFoyUf0ZNiKwa+gY2ug@mail.gmail.com>
To: Prabhakar Lad <prabhakar.csengg@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, LFBDEV <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

--L4Lxibdg4wNuWqHgMSfIIPIH9i8pleOPu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/12/14 20:29, Prabhakar Lad wrote:
> On Wed, Dec 3, 2014 at 11:49 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>> On 27/11/14 00:07, Lad, Prabhakar wrote:
>>> this patch fixes following build warning:
>>> drivers/video/fbdev/vt8623fb.c: In function =E2=80=98vt8623_pci_probe=
=E2=80=99:
>>> drivers/video/fbdev/vt8623fb.c:734:23: warning: cast to pointer from =
integer of different size [-Wint-to-pointer-cast]
>>>   par->state.vgabase =3D (void __iomem *) vga_res.start;
>>>                        ^
>>> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>>> ---
>>>  drivers/video/fbdev/vt8623fb.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/video/fbdev/vt8623fb.c b/drivers/video/fbdev/vt8=
623fb.c
>>> index 5c7cbc6..ea7f056 100644
>>> --- a/drivers/video/fbdev/vt8623fb.c
>>> +++ b/drivers/video/fbdev/vt8623fb.c
>>> @@ -731,7 +731,7 @@ static int vt8623_pci_probe(struct pci_dev *dev, =
const struct pci_device_id *id)
>>>
>>>       pcibios_bus_to_resource(dev->bus, &vga_res, &bus_reg);
>>>
>>> -     par->state.vgabase =3D (void __iomem *) vga_res.start;
>>> +     par->state.vgabase =3D (void __iomem *) (unsigned long) vga_res=
=2Estart;
>>
>> This does look quite ugly... Where does the warning come from in the
>> first place. Isn't vga_res.start (resource_size_t) the size of a point=
er?
>>
> Yes looks ugly, I am not sure what you meant from 'where does this warn=
ing
> come from' its in the commit message.

I meant why is there a warning at all. With a quick glance,
vga_res.start is the size of a pointer. So the sizes of the integer and
the pointer should be the same. But the warning still says "of different
size".

 Tomi



--L4Lxibdg4wNuWqHgMSfIIPIH9i8pleOPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgAfOAAoJEPo9qoy8lh71Gl8P/j4VBc/Eci3PHavYhRxu23bH
rYBdLJzpbJPSnysJJRGVErwDid5jkgOtUSwKjZlH2jZd29d+zlO0qbWuBpuMwL7x
11+wpejg4fmuCVbN+YPgBE5oSysIaV0hU4IbWBLSm991RcGAm7bXbs0gr0tGJCNK
8T1NAYtA6s0I8crlwZw5dSEOhC2E22Yl/ijeEYl2NMknF83OQfu0ajYr4L9dYvPJ
krgK0o9bGbr5MQJdI9iq6HxPK9Mhauzqp6/fflFnGiJOsq01N++xsqYUUCGk0Utv
5Y5mcsq4nIs+dv0p+4gv+rILQY7vHghCKtpSZddEsHseNKEO2O5NjGW6wLisQJli
kUjt/hg9qql7OLq1OHZvEIthe4mngJftULXMqbLad93Tn2ihhMJFP/iYvu7F4u8c
/3BkNZJshs/s537Gt447epoG5uRWHdPExOb2ye8GBQalP3URR2zv9c+RpzD/qCzS
O+q97NkOiRVVrkrEewoOiDJ6OvI5/eVPsC87VB55N13gJh+QRctU8oTRslQ9EcBG
LWd8plGkUUGMRTEbyxzlum+DcCxNCVkDlDEHukMwtoQnwjTwOGaiLxmv/Faf+EvV
aZei/UsZV85CdtK5FzdLt2HHJsrpA0If3aACvMYDKiH+nK1//UMem3Og7aQTub0L
PJE7T4qPbjTP0/fbjhRt
=jdS2
-----END PGP SIGNATURE-----

--L4Lxibdg4wNuWqHgMSfIIPIH9i8pleOPu--
