From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Mon, 27 Feb 2017 20:36:05 +0000
Subject: Re: [PATCH 1/2] video: fbdev: imxfb: support AUS mode
Message-Id: <20170227203605.7ptrmcbzrmufvxa5@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1488193030-13064-1-git-send-email-martin@kaiser.cx>
In-Reply-To: <1488193030-13064-1-git-send-email-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Martin Kaiser <martin@kaiser.cx>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hello,

given fbdev is orphaned
(http://git.kernel.org/linus/238600783d7470bec19350b0ee79e01825d3c84f)
I think it would be nice to move the imxfb driver over to drm.
I don't know much about drm, so I cannot say if that is easy or not, but
long term I think this is more robust than fbdev.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
