From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Aug 2015 11:54:36 +0000
Subject: Re: [PATCH] drm: Remove two-level menu in Kconfig
Message-Id: <55C890FC.2090809@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nXDNqsFJ6NjRdfLiJlS0unrOBF5cBIL4s"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438963817-9695-1-git-send-email-thierry.reding@gmail.com>
 <55C87DA8.1010206@ti.com> <20150810114718.GU17734@phenom.ffwll.local>
In-Reply-To: <20150810114718.GU17734@phenom.ffwll.local>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, dri-devel@lists.freedesktop.org

--nXDNqsFJ6NjRdfLiJlS0unrOBF5cBIL4s
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 10/08/15 14:47, Daniel Vetter wrote:
> On Mon, Aug 10, 2015 at 01:32:08PM +0300, Tomi Valkeinen wrote:
>>
>>
>> On 07/08/15 19:10, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> The Direct Rendering Manager Kconfig option is already a separate men=
u,
>>> so remove the extra level to make it easier to navigate.
>>>
>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>> ---
>>>  drivers/video/Kconfig | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>>> index 8bf495ffb020..e0606c01e8ac 100644
>>> --- a/drivers/video/Kconfig
>>> +++ b/drivers/video/Kconfig
>>> @@ -22,9 +22,7 @@ source "drivers/gpu/vga/Kconfig"
>>>  source "drivers/gpu/host1x/Kconfig"
>>>  source "drivers/gpu/ipu-v3/Kconfig"
>>> =20
>>> -menu "Direct Rendering Manager"
>>>  source "drivers/gpu/drm/Kconfig"
>>> -endmenu
>>> =20
>>>  menu "Frame buffer Devices"
>>>  source "drivers/video/fbdev/Kconfig"
>>>
>>
>> Thanks, queued for 4.3.
>=20
> Oops failed to send out my usual mail, but I picked this already up in
> topic/drm-misc.

Ok, dropping this from fbdev tree.

 Tomi


--nXDNqsFJ6NjRdfLiJlS0unrOBF5cBIL4s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVyJEIAAoJEPo9qoy8lh71fPIQAJfmcYg4rLt0sNtfQUmvoVKJ
+yTtJ3qpMtUD+q2UiqssssD+HjlXKDzLZeCOexgPQK7fYA0ssp3gCg2NbGtnQmCb
7ZDAvNx6IfMJqOyLbUJW0GCiFMWA4diMxao3+0lcxHQ4qyKSarsgJT2G/z+9ga9C
rCmh65wHQFE/Vzk7BRiBsFCrCyaoZbRlvQVl4jLPqzG3rKOYcv6QMmoX9XPUmaAp
eYGZNRBzRp8OqnOKLN58jTDpHTzx1UNozNceS41jFSRGp4oKhaSdW61AGlEur7LI
dCw9OGd+Fvd4Yo3VZjC+Hpj6me5oFSAJHeD2QgMSAL2KopsMC58h9SVI8WuYq7f8
lQxII72969TFO/3x1ToS0UpIUVrt9AT3yGCcstxLNtkmbU5wwGFeehsA9vl0sZnv
mErPZBx+UkXKnjcoFNTQRgtoQbQDPCcwqDDbCau/fNqMTZR9g9X/qZfKGhw5Aa3G
IttD+XtuCE5dag1xSUQYtAJvj7LrSEE1Qeu4HmZvSDZCvo6wPmJGs5pxUQHRQPG2
dVPXMOfN6P7aihNURWUiT/bYtDrZhSnoUH1jsAG3G1EEGqNzAgE0qfA25dvbPeSo
lXpMTSnWicuh+rSDOs40r54EwXnH8nlNCCEANY+9CXtffPGBqXdOKRcEUpekhDQZ
PUWHItqMM/aaLPaADt2J
=z8Fr
-----END PGP SIGNATURE-----

--nXDNqsFJ6NjRdfLiJlS0unrOBF5cBIL4s--
