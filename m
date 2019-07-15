From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Mon, 15 Jul 2019 10:40:49 +0000
Subject: Re: [PATCH v3 24/24] video: fbdev-MMP: Remove call to memset after dma_alloc_coherent
Message-Id: <20190715104049.GC20839@arch-x1c3>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190715032017.7311-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190715032017.7311-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 2019/07/15, Fuqian Huang wrote:
> In commit 518a2f1925c3
> ("dma-mapping: zero memory returned from dma_alloc_*"),
> dma_alloc_coherent has already zeroed the memory.
> So memset is not needed.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> Changes in v3:
>   - Use actual commit rather than the merge commit in the commit message
> 
>  drivers/video/fbdev/mmp/fb/mmpfb.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
