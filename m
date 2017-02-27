From: Martin Kaiser <martin@kaiser.cx>
Date: Mon, 27 Feb 2017 22:33:36 +0000
Subject: Re: [PATCH 1/2] video: fbdev: imxfb: support AUS mode
Message-Id: <20170227223336.GA28519@botnar.kaiser.cx>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1488193030-13064-1-git-send-email-martin@kaiser.cx>
 <20170227203605.7ptrmcbzrmufvxa5@pengutronix.de>
In-Reply-To: <20170227203605.7ptrmcbzrmufvxa5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hello Uwe,

Thus wrote Uwe Kleine-K=F6nig (u.kleine-koenig@pengutronix.de):

> given fbdev is orphaned
> (http://git.kernel.org/linus/238600783d7470bec19350b0ee79e01825d3c84f)

fbdev is no longer orphaned, Bartlomiej is the new maintainer.

> I think it would be nice to move the imxfb driver over to drm.
> I don't know much about drm, so I cannot say if that is easy or not, but
> long term I think this is more robust than fbdev.

I am aware that fbdev is in maintenance mode. However, I hope that small
modifications like the one I submitted are still possible.

In the long run, I agree that we should move imxfb to drm.

Best regards,
Martin
