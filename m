From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 16:48:52 +0000
Subject: Re: [PATCH] fbdev: omapfb: off by one in omapfb_register_client()
Message-Id: <8615162.0D3GuDQfVx@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180713145615epcas3p4e584128beb220b339552ad92fe2eb3b4@epcas3p4.samsung.com>
 <20180713145555.sprrr4rl6eqspirz@kili.mountain>
In-Reply-To: <20180713145555.sprrr4rl6eqspirz@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-fbdev@vger.kernel.org, Imre Deak <imre.deak@solidboot.com>, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org

On Friday, July 13, 2018 05:55:55 PM Dan Carpenter wrote:
> The omapfb_register_client[] array has OMAPFB_PLANE_NUM elements so the
> > should be >= or we are one element beyond the end of the array.
> 
> Fixes: 8b08cf2b64f5 ("OMAP: add TI OMAP framebuffer driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

