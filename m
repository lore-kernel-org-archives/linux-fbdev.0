From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 07 Jun 2017 13:33:53 +0000
Subject: Re: [PATCH] video: fbdev: udlfb: drop log level for blanking
Message-Id: <1655362.4sVbolFMFh@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170601202559.GA96809@google.com>
In-Reply-To: <20170601202559.GA96809@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi,

On Thursday, June 01, 2017 04:38:50 PM Mike Gerow wrote:
> It would also be far simpler (and perhaps better) to just drop the existing log
> to debug instead of this conditional nonsense. I'm mostly interested in being
> able to check a machine running for a few weeks and seeing the logs not be 95%
> "udlfb: /dev/fb1 FB_BLANK mode 0 --> 0".

Fine with me, could you please redo your patch to do this?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

