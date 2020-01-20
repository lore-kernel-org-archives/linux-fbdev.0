From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=  <marmarek@invisiblethingslab.com>
Date: Mon, 20 Jan 2020 18:11:46 +0000
Subject: Re: [PATCH] fbdev: wait for references go away
Message-Id: <20200120181146.GL1314@mail-itl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="p0HNO2YbtFeVXwJ3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200120100025eucas1p21f5e2da0fd7c1fcb33cb47a97e9e645c@eucas1p2.samsung.com>
 <20200120100014.23488-1-kraxel@redhat.com>
 <d143e43b-8a38-940e-3ae5-e7b830a74bb3@samsung.com>
In-Reply-To: <d143e43b-8a38-940e-3ae5-e7b830a74bb3@samsung.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>


--p0HNO2YbtFeVXwJ3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fbdev: wait for references go away

On Mon, Jan 20, 2020 at 06:51:17PM +0100, Bartlomiej Zolnierkiewicz wrote:
> I guess that a problem is happening during DRM driver load while fbdev
> driver is loaded? I assume do_unregister_framebuffer() is called inside
> do_remove_conflicting_framebuffers()?

Yes, exactly. More details here:
https://lists.linuxfoundation.org/pipermail/virtualization/2020-January/045=
026.html

> At first glance it seems to be an user-space issue as it should not be
> holding references on /dev/fb0 while DRM driver is being loaded.

How plymouth would know when exactly it needs to release /dev/fb0?

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--p0HNO2YbtFeVXwJ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl4l7WIACgkQ24/THMrX
1ywYwQgAimDeFDny3c/ar866L78Bc5TRyJynEGGbFlnb9BR/gCc9gpS1tNCyemPC
keqTV3PxXHMFaTPnrJi2ebuUP+Lmj/YOK+tCXB8+ipwMs3Z1HZv1DR7D4s3gDDzk
To8b4e0RnxpCdQJ4xpOoWL+XcueHy+RB8FtEXqXyVJTW/bJWGYGnuyQVSubBKQxL
TyEp6ASDocGLFX0QsSrdVEkuVF/PMdfbyu6Th9MwQMtMmd0s2BuepAfJhDP3js1f
JlMnL3N1wscxFOWn1TSAGywTMbAjwRctGwrCcULMDME2STVryuH0VNWpapKIMQpj
PUlDFH5CMVOKGjXo2OkywONz4gP7kQ==
=2hqv
-----END PGP SIGNATURE-----

--p0HNO2YbtFeVXwJ3--
