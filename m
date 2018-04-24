From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Apr 2018 15:59:40 +0000
Subject: Re: [PATCH 57/61] video: fbdev: simplify getting .drvdata
Message-Id: <2148068.ySUABWLNhf@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <CGME20180419140717epcas3p4240e2c1bf23b1fa7dc3cf9b3a1d1251b@epcas3p4.samsung.com>
 <20180419140641.27926-58-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180419140641.27926-58-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Thursday, April 19, 2018 04:06:27 PM Wolfram Sang wrote:
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

