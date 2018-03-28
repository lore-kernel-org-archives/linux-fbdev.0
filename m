From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 28 Mar 2018 13:19:05 +0000
Subject: Re: [PATCH] fbdev: aty: fix missing indentation in if statement
Message-Id: <3386391.UTD4dglipH@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180315181633epcas2p19407707285ccc33c3fcd2c8c0d071a57@epcas2p1.samsung.com>
 <20180315181624.18684-1-colin.king@canonical.com>
In-Reply-To: <20180315181624.18684-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>

On Thursday, March 15, 2018 06:16:24 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a missing indentation following an if statement, fix this.
> 
> Detected by Coccinelle:
> drivers/video/fbdev/aty/mach64_ct.c:183:2-15: code aligned with
> following code on line 184
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

