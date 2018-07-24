From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 15:56:25 +0000
Subject: Re: [PATCH] omapfb: Mark expected switch fall-throughs
Message-Id: <5148330.xZP60O7hy1@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180709220440epcas1p4327d007d1f871a8bf3767d1f88a7be7f@epcas1p4.samsung.com>
 <20180709220436.GA10751@embeddedor.com>
In-Reply-To: <20180709220436.GA10751@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Monday, July 09, 2018 05:04:36 PM Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

