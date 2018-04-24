From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Apr 2018 16:02:11 +0000
Subject: Re: [PATCH 58/61] video: fbdev: omap2: omapfb: displays: simplify getting .drvdata
Message-Id: <1726457.eauaWiscAe@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <CGME20180419140716epcas2p3dd25b3be301017affaef3908823c5ace@epcas2p3.samsung.com>
 <20180419140641.27926-59-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180419140641.27926-59-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

On Thursday, April 19, 2018 04:06:28 PM Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Patch queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

