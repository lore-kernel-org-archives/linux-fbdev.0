From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 21 Jun 2019 11:07:21 +0000
Subject: Re: [PATCH] video: fbdev: imxfb: fix sparse warnings about using incorrect types
Message-Id: <af111901-1fdb-a2d5-dcf7-aa2fd14c2ac5@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <33fc4837-599d-0d5c-c530-58b283c4c095@samsung.com>
        <8520d744-cebc-c76a-e51a-ff6a471af57d@samsung.com>
        <CGME20190621110724eucas1p280d182bc57d444db561561fd62384c60@eucas1p2.samsung.com>
In-Reply-To: <8520d744-cebc-c76a-e51a-ff6a471af57d@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, kbuild test robot <lkp@intel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


On 6/14/19 1:53 PM, Bartlomiej Zolnierkiewicz wrote:
> Use ->screen_buffer instead of ->screen_base to fix sparse warnings.
>=20
> [ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
>   pointer") for details. ]
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
