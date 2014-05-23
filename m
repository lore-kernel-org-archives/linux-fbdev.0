From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 23 May 2014 14:32:08 +0000
Subject: Re: [PATCH v2 1/3] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <537F5BE8.5020102@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="cT8togX6g5VN9gpxk52VWrsvdtCDVSdWh"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--cT8togX6g5VN9gpxk52VWrsvdtCDVSdWh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 23/05/14 17:27, Alexander Shiyan wrote:

>> But I don't want to make this more difficult for you than it needs to.=

>> As I said, I'm fine with the current patches, if we skip 3.16 and get
>> them to linux-next right after the merge window. If nobody would use t=
he
>> new driver in 3.16 anyway (in your proposal above), would this be the
>> easiest way?
>=20
> This is the only way to announce initial multiplatform support (in case=
 we will
> use two differrent drivers).
> Another (easiest) way is to use the current patchset...

If the old driver doesn't even play well with multiplatform, and is thus
blocking moving the SoC to multiplatform, I'd just get done with it in
one go.

So I would recommend pushing the new driver and the removal of the old
one for 3.17, and having those changes in linux-next right after the
3.16 merge window.

Is that ok?

 Tomi



--cT8togX6g5VN9gpxk52VWrsvdtCDVSdWh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTf1voAAoJEPo9qoy8lh713IMP+wT+DTGx/RgQxmJA+ocHNzwa
Ihkmi4m0mN1kQ8tO/OFIqFY3WMM91YW11+wd04FJgwU0bFgJX9pgmeZNKvUiL6E5
POX5CmA18WA8Z/o6SMqG9xv3koSFKObBifOsBLEplPjLGUhbJ/WSbagTx4EbJQFU
BU5F3XMjzwaoX7rAcLD+82ATYsQWXkxhrYiyT1/IAvOPQvSMBaB4ViC7JY0/jGxS
Wnmt/+LX8k+inQ1HqU8g+XpHFJ+q/uzeFZgGzfhWCDPGAjCc/GbC7HF0cdaBpT2d
B7As1DUpglWQWFfplsC7giBiOw5b1B9ptg8GacgqDIhEdqFJ/L1GDBgn8uOUAIRz
BL4dFgD+1Qc/nqrQ96PUay+KR0N89dTpxiifmTsf/MGVoyHeT0PubSUKtEVnVQUr
m9T1iTTYwC5bhKOhyMvo3/+hGEz2gOw4+hKBDlnwbWC8WINs58mg38pHFRrz6BDF
qirRAsuLkW+EeNz+7s0FOnoCH03fN3byUy6+XOTt4K2b/brrQQex3AlKF/8afnbR
17PwVZw0lpV9hvNdlpl2ZXu+G4ZOdf7tHisSMUXu729jp2X35Eu4r2w/dtXHFAu0
i4tZDxZzQs/SAXaPzHVbPdrTYp7v/37owgF1+h1xZbgqxkIyavE3w9/CYOWfaAdI
qACbKBfXJ694gFAj/0Ai
=8sZk
-----END PGP SIGNATURE-----

--cT8togX6g5VN9gpxk52VWrsvdtCDVSdWh--
