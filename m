From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 10 Jun 2016 11:33:15 +0000
Subject: Re: [PATCH] [efifb] Fix 16 color palette entry calculation
Message-Id: <575AA57B.6080906@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="np38n9EXKP8a7wkh52pfKL1MRm6fsv6jb"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1465307143-21398-1-git-send-email-mstaudt@suse.de>
 <20160607172304.GD24886@redhat.com>
 <20160608124348.GY2658@codeblueprint.co.uk>
In-Reply-To: <20160608124348.GY2658@codeblueprint.co.uk>
To: Matt Fleming <matt@codeblueprint.co.uk>, Peter Jones <pjones@redhat.com>
Cc: Max Staudt <mstaudt@suse.de>, plagnioj@jcrosoft.com, eich@suse.de, tiwai@suse.de, agraf@suse.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--np38n9EXKP8a7wkh52pfKL1MRm6fsv6jb
Content-Type: multipart/mixed; boundary="2NcwNrdubUKRoI1j6S6WiOSini99FvKbX"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Matt Fleming <matt@codeblueprint.co.uk>, Peter Jones <pjones@redhat.com>
Cc: Max Staudt <mstaudt@suse.de>, plagnioj@jcrosoft.com, eich@suse.de,
 tiwai@suse.de, agraf@suse.de, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <575AA57B.6080906@ti.com>
Subject: Re: [PATCH] [efifb] Fix 16 color palette entry calculation
References: <1465307143-21398-1-git-send-email-mstaudt@suse.de>
 <20160607172304.GD24886@redhat.com>
 <20160608124348.GY2658@codeblueprint.co.uk>
In-Reply-To: <20160608124348.GY2658@codeblueprint.co.uk>

--2NcwNrdubUKRoI1j6S6WiOSini99FvKbX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/06/16 15:43, Matt Fleming wrote:
> On Tue, 07 Jun, at 01:23:05PM, Peter Jones wrote:
>>
>> Looks right to me.
>>
>> Acked-By: Peter Jones <pjones@redhat.com>
>=20
> Tomi, are you OK to take this one or would you like me to take it
> through the EFI tree?

I can pick this up, but as Greg said, this is not valid for stable.

Max, please resend with correct stable reference.

 Tomi


--2NcwNrdubUKRoI1j6S6WiOSini99FvKbX--

--np38n9EXKP8a7wkh52pfKL1MRm6fsv6jb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXWqV7AAoJEPo9qoy8lh71i2cP/i5Gvg8nVNIzz/1Y1+9kYZTr
6nMprRTYriEGx/jm2ZZxwNceVYgEUbZLJEsoYIz4HyLGLi3CvtWU6HcDkHxWmIUQ
U6PqHT+91PdkvbVjezraTgkYINUBtVfpVHgqOuWr91mor9SMGuGYSI8cjxXa21H9
azbUbeE00qtpi0gGJk4+3VHZ+GYLlpUFV/JytO8eO1CUrL2aW6LILzbbLfzEvLyb
sZJ8uBGqY/+Gs6xEpss3iR95a6fgu2/ICDW3W2cwaRK1KcC1RvPLL1IFvuYmQ834
3WWOS9Rf8saWjdEPzpBwlF7v4NZEULhQQ+W96AActZea3wXa3+fT6WotDEj4z8UE
kzJvC1bGmb6mgLqjxORsibh6Mfa/7BirxEUBaNj7GMWmhNRMM0119bSrYzTsjfOB
6DUTXz/ggnnorNnXJUxweCXOtYYwmuXgNBfw6BvieWjQsK2ZhQGx1mGVBFd56a4A
KCzi4JtIxgySLKjzVPY052hx6JDHUW9vsjNKH7uwE7jJkHFUlPwRPZWabF7XfPQE
x5gv7lbS0vuT0BBJcn/1K3lyQdtvCgiIWEIL1cbqeHsTRBLXdFQLEFlwjZ8nWs1P
lBKBDfDfmYADYD+vA6qMiNGV0MohBr98dHFviSPHeT+IYTGnu2bzF+5rX4z9TPXN
S4+6HTjWTRT4tzRgIfRK
=jzLj
-----END PGP SIGNATURE-----

--np38n9EXKP8a7wkh52pfKL1MRm6fsv6jb--
