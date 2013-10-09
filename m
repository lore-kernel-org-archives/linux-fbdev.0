From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Oct 2013 09:53:21 +0000
Subject: Re: [PATCH 1/2] hyperv-fb: add pci stub
Message-Id: <52552791.1020505@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="S8Qm5cFRQnvQJaSohu2h1RjNfou5hp8Ll"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380714911-6254-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1380714911-6254-1-git-send-email-kraxel@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "open list:Hyper-V CORE AND..." <devel@linuxdriverproject.org>, FRAMEBUFFER LAYER <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

--S8Qm5cFRQnvQJaSohu2h1RjNfou5hp8Ll
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/10/13 14:55, Gerd Hoffmann wrote:
> This patch adds a pci stub driver to hyper-fb.  The hyperv framebuffer
> driver will bind to the pci device then, so linux kernel and userspace
> know there is a proper kernel driver for the device active.  lspci show=
s
> this for example:
>=20
> [root@dhcp231 ~]# lspci -vs8
> 00:08.0 VGA compatible controller: Microsoft Corporation Hyper-V virtua=
l
> VGA (prog-if 00 [VGA controller])
>         Flags: bus master, fast devsel, latency 0, IRQ 11
>         Memory at f8000000 (32-bit, non-prefetchable) [size=3D64M]
>         Expansion ROM at <unassigned> [disabled]
>         Kernel driver in use: hyperv_fb
>=20
> Another effect is that the xorg vesa driver will not attach to the
> device and thus the Xorg server will automatically use the fbdev
> driver instead.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/video/hyperv_fb.c | 40 +++++++++++++++++++++++++++++++++++++++=
-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>=20

Thanks, queuing the series for 3.13.

 Tomi



--S8Qm5cFRQnvQJaSohu2h1RjNfou5hp8Ll
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSVSeRAAoJEPo9qoy8lh71rGgP/2dEfMQlpprRxqLEARZ6km8Z
eesjGlizkqyzqjsgz2Qa9c1EegZg7uOf0dKzam9bFiN2StUFUxWZTfYYdwhRyCdb
6mKajyG9oFsxXa9lDtz4ZtYCIbKM8HYz9nBTz7IuMU6ufjoQvDtWOfnQHTVCIXZy
pTd6fPR4JC0yQ8WTo7ux6HaTMp1T/WGauPDxPYWQVRsqNsHehvD+O4SxA+f2xJym
NbHnwwYnEkjavj743mZcnepWiVdKxEmOy4fE5gB0H/2aXsXK2U+Dn/8dxLJgSV9k
IKKNf1MFj527G1UnOqK/GglOnPNUHmD0IXqpocRa9atVR/2P/5osukmwIfobSjJb
WxVAutjMMyFtcFTvJPfFvJ/YBJxMdrCNmMBPCp0Dc/tEUl6UJx8JbCzE2FFM8Z5W
1yEe4GaXea4zVDEuIvQFd92GYTwZEC4IgDtu/Nyj/VaSGP5v1c3QjZKkFO1ZaQRy
PhOqcmOU1jHo5tXiGy5pxoz+yFermf85QY3Mu3PjFBEdc3OhGMU03SGSf43szVcA
PSMLenoEAChD0r6uJMeckbkgLNveg2J7++Lbbj4h1K0iG3+FQ7t7fLGgpKxhVeui
KMz6UXkNHl2/Y7CxbPYPVJDBhEBhUrcwujTTRpHDaqkHqvoHwIOMmad2+pl5ffHD
61C2E97nS+uYwxe9Bodz
=PQT7
-----END PGP SIGNATURE-----

--S8Qm5cFRQnvQJaSohu2h1RjNfou5hp8Ll--
