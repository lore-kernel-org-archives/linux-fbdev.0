From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 30 Jan 2017 16:39:17 +0000
Subject: Re: [PATCH 1/3] fbdev: omap/lcd: Remove no-op driver callbacks
Message-Id: <10692182.IyU6F3r5ey@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1485011783-22521-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1485011783-22521-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi,

On Saturday, January 21, 2017 04:16:21 PM Lars-Peter Clausen wrote:
> Every single one of the OMAP fbdev LCD drivers implements no-op remove,
> suspend and resume callbacks for their platform_driver. This is not
> necessary as the driver core handles the case where the callbacks are not
> set just fine. So they are just unnecessary boilerplate that can be
> removed.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Patches #1-3 queued for 4.11, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

