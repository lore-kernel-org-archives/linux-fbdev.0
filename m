From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 14 Apr 2017 11:39:50 +0000
Subject: Re: [PATCH] fbdev: omapfb: delete check_required_callbacks()
Message-Id: <3527837.jmLdPIAKUs@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170407191340epcas4p11d5a19fff9d86cae47195552421a3ae0@epcas4p1.samsung.com>
        <20170407190407.30265-1-aaro.koskinen@iki.fi>
In-Reply-To: <20170407190407.30265-1-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Friday, April 07, 2017 10:04:07 PM Aaro Koskinen wrote:
> Commit 561eb9d09a93 ("fbdev: omap/lcd: Make callbacks optional") made
> panel callbacks optional but forgot to update check_required_callbacks().
> As a result many (all?) OMAP systems using omapfb will crash at boot.
> Fix by deleting the whole function.
> 
> Fixes: 561eb9d09a93 ("fbdev: omap/lcd: Make callbacks optional")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Patch queued for 4.11, thanks!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

