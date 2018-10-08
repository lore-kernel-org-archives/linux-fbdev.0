From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 08 Oct 2018 10:54:21 +0000
Subject: Re: [PATCH -next] pxa168fb: remove set but not used variables 'mi'
Message-Id: <20181008105422eucas1p18b288e2ad2561b2d3442f120d3379fda~bnMPZmjIx2288722887eucas1p1I@eucas1p1.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180928020755epcas2p32d1fda65c5a3547a62c34b982a42a6ee@epcas2p3.samsung.com>
 <1538101007-160417-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1538101007-160417-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: YueHaibing <yuehaibing@huawei.com>
Cc: Lubomir Rintel <lkundrak@v3.sk>, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org


On 09/28/2018 04:16 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/video/fbdev/pxa168fb.c: In function 'pxa168fb_set_par':
> drivers/video/fbdev/pxa168fb.c:408:29: warning:
>  variable 'mi' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
