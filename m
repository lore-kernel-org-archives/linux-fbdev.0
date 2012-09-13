From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Sep 2012 05:45:39 +0000
Subject: Re: [PATCH v6 1/4] Runtime Interpreted Power Sequences
Message-Id: <1347515139.7471.7.camel@lappyti>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-X7CYTU1tnldXpuBQcygl"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347443867-18868-1-git-send-email-acourbot@nvidia.com>
	 <1347443867-18868-2-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1347443867-18868-2-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--=-X7CYTU1tnldXpuBQcygl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-09-12 at 18:57 +0900, Alexandre Courbot wrote:
> Some device drivers (panel backlights especially) need to follow precise
> sequences for powering on and off, involving gpios, regulators, PWMs
> with a precise powering order and delays to respect between each steps.
> These sequences are board-specific, and do not belong to a particular
> driver - therefore they have been performed by board-specific hook
> functions to far.

The sequences are not board-specific, they are device (backlight, etc.)
specific. The sequences have been handled in board-specific hook
functions so far because there hasn't been proper drivers for the
devices.

If I were to take the same panel (and backlight) you have and install it
on my board, I would need the same power sequence.

 Tomi


--=-X7CYTU1tnldXpuBQcygl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQUXMDAAoJEPo9qoy8lh71ChgP/3m4mVfwgbYy4y0p23b9clXf
CyGznDlFYfwXfS0GZSWvdsU9MnaY5X8AWFidc6SjtbICMG0IzsPIL4Qv4093izVZ
/8O8r+6W0tXbvug++jHFFdXao2FZOvbzGRFCkIij3gnZB87SlKgpXL4IXY83Wmf6
DsZw18x3xeNT72vKB9oG0VGNCF3g475m+nRb0MXPxecLtLAl1XoK04TdyP+6NikJ
5MQEtKbp86hGh1a1AZiGVl15SYrsR7nVVmbxHsfJC2qQbP4vWdGIFhrjMl8vWq61
WS57bQ3yP/pIwz1QwapkHoz25+xXjIA9al7LTcBl5svlABfoJjXMyRB9Ini90pqv
ihYJ+l+sktIPErZLDtvJP4neiMyxxVB3gQ5k2emgvVk2ze1TAEm4AaL3lU1JULX5
LS3ed/kWT3L6PEu2FQDbL4PnKBbW+0IMIzrMT4Cc1h/IWsThQfbLke1YHJGX211e
oMGvKHe5gqkoAsOnYzglco6c0MViX5YqR5/MIhcLGbnM0ztX77feSdX0slnWnSn7
nufo6Vks8qbJmIXVuwxdSXlRpPSwF7sM3+HHRAmwjaZSx8VqcAjsj5eUclPDSLmV
yxMLMpPWYWZ2PMzA4aFWN1bFjwgy12gs8WNSnVhiZBj61SVxobFqbFDyGx/bqC+S
8PSrC/MZMcLG9Ys+RvCW
=SqAz
-----END PGP SIGNATURE-----

--=-X7CYTU1tnldXpuBQcygl--

