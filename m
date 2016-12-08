From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 08 Dec 2016 08:01:11 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <035da7a8-5a3f-1ef6-f686-479773e78084@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MkHUm3KpMcWLPsknRQaPwhatXlJkHSUka"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <1481158879.26959.41.camel@kernel.crashing.org>
In-Reply-To: <1481158879.26959.41.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-kernel@vger.kernel.org

--MkHUm3KpMcWLPsknRQaPwhatXlJkHSUka
Content-Type: multipart/mixed; boundary="d8kpKIHlg2pKCrfkAS115rn3mlDHwP9Fm";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Teddy Wang <teddy.wang@siliconmotion.com>,
 Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <035da7a8-5a3f-1ef6-f686-479773e78084@ti.com>
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <1481158879.26959.41.camel@kernel.crashing.org>
In-Reply-To: <1481158879.26959.41.camel@kernel.crashing.org>

--d8kpKIHlg2pKCrfkAS115rn3mlDHwP9Fm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/12/16 03:01, Benjamin Herrenschmidt wrote:
> On Wed, 2016-11-23 at 10:03 +0200, Tomi Valkeinen wrote:
>> Hi,
>>
>> Since the fbdev framework is in maintenance mode and all new display d=
rivers
>> should be made with the DRM framework, remove the fbdev drivers from s=
taging.
>>
>> Note: the patches are created with git format-patch -D, so they can't =
be
>> applied. Only for review.
>=20
> I missed the discussion where this decision was made, I admit I am
> unimpressed by it.
>=20
> DRM drivers don't strike me as suitable for small/slow cores with dumb
> framebuffers or simple 2D only accel, such as the one found in the ASpe=
ed
> BMCs.

Then the DRM framework should be improved to be suitable.

> With drmfb you basically have to shadow everything into memory & copy
> over everything, and locks you out of simple 2D accel. For a simple tex=
t
> console the result is orders of magnitude slower and memory hungry than=

> a simple fbdev.

I don't think that's true. You can have a single fbdev buffer and blit
there all you want, afaik.

> Not everything has a powerful 3D GPU.

We don't use GPU on OMAPs (except for 3D).

 Tomi


--d8kpKIHlg2pKCrfkAS115rn3mlDHwP9Fm--

--MkHUm3KpMcWLPsknRQaPwhatXlJkHSUka
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYSRNIAAoJEPo9qoy8lh71rV0P/A3OppPfJ6mTCaq0Aqdztwoh
IVFPn8eWYMivkopkTYZOD4EdfGvXvcrOKajRC8wJ4GawCcd4crnjG0MErLNPofcZ
PEmBfKyejjMCDYkchYMIJ/PW02D6vaulGD4oMYVHcQorGmnICHQRGvQsHJNIzIOm
Tlf0xXfP8r0wXMxOEf3huKp1CpFl7VGAz5KEpkWUchf8bntffecQYd/GIpUAQyt4
Z87T993XP5Oknh4QeLqM4ZJDo2U72uXVmsX5P7U4cUMk0uzWyy0o3kaGVipOlGpT
sGVtXZHK1BQYs1WuJH2Aw2Q242lNydaJ9ZYyB2gfx80XxObPjNpYRLIgpqOMWXXK
aDBAs0+evQA8sCEN2vHarR7oAjUBEbQFpgT0pO6g3VHSCP8RTsnH7hmUART8xFwb
zct8010RUV7POgQP7ifskxV60qMNTX2dppeVSPaIDUoXv1VigLlNcrCQQUSnIgDT
Zg17h9CReyd8Q3xh9x1bQF91DyQdggEhT2LRdlfme69DTd3uDVO3YpPLWLeqzXXp
0DP7LAxhTVA3nUnl9JxGSLkw5TCQzLPwCppT+c5RwfQvkp29I3OTB2nyQZ7oqJ5X
EZCTcvkNY2iCMftA4UXZc1RTsgHMRb8M24+ltuotDdDbkbbvNnyULTvBFxn4t0Ra
hEDPyOJlmY73jOMMWgUP
=g/5K
-----END PGP SIGNATURE-----

--MkHUm3KpMcWLPsknRQaPwhatXlJkHSUka--
