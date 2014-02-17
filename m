From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 17 Feb 2014 07:02:05 +0000
Subject: Re: [PATCH 1/5] video: imxfb: Remove dead declaration of set_imx_fb_info()
Message-Id: <20140217070205.GE24917@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1392443786-30527-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1392443786-30527-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, Feb 15, 2014 at 09:56:22AM +0400, Alexander Shiyan wrote:
> Function set_imx_fb_info() is missing in the kernel code,
> so remove the dead declaration.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Nice cleanup to this driver!

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
