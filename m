From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 14 May 2018 13:39:44 +0000
Subject: Re: [PATCH] video: fbdev: remove unused auo_k190xfb drivers
Message-Id: <508774774.A4nF8YdQe2@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180427110425eucas1p12aca3b573a6c3fc4b51da9d5d34b3cec@eucas1p1.samsung.com>
 <6386409.PTMV4p8OHo@amdc3058> <3959140.hnfON7x99k@phil>
In-Reply-To: <3959140.hnfON7x99k@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Friday, April 27, 2018 05:07:41 PM Heiko Stuebner wrote:
> Am Freitag, 27. April 2018, 13:04:24 CEST schrieb Bartlomiej Zolnierkiewi=
cz:
> > auo_k1900fb and auo_k1901fb drivers have been introduced six
> > years ago by following commits:
> >=20
> > commit 2c8304d3125b ("video: auo_k190x: add code shared by controller d=
rivers")
> > commit 96b1d500e028 ("video: auo_k190x: add driver for AUO-K1900 varian=
t")
> > commit 53027cdf2a67 ("video: auo_k190x: add driver for AUO-K1901 varian=
t")
> >=20
> > They never had any in-kernel user so just remove them (since
> > they are platform drivers they need corresponding platform
> > devices to be registered by kernel and it has never happened).
> >=20
> > Cc: Heiko St=FCbner <heiko@sntech.de>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>=20
> While I still hold the ereaders using these controllers in high regard
> as my first kernel hacking project, reality is that I don't think I'll
> ever continue on trying to mainline these and if later someone wants
> to resurrect these (very old now) devices, they'll probably need a drm-
> driver anyway. So for the removal
>=20
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Thanks, I've queued the patch for v4.18.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

