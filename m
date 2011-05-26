From: Peter Jones <pjones@redhat.com>
Date: Thu, 26 May 2011 14:32:52 +0000
Subject: Re: [PATCH 1/4] efifb: Enable write-combining
Message-Id: <4DDE6494.7090209@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <3647a3cc4157f8c50ab719f1a7500e695cf66a05.1306418703.git.luto@mit.edu>
In-Reply-To: <3647a3cc4157f8c50ab719f1a7500e695cf66a05.1306418703.git.luto@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 05/26/2011 10:13 AM, Andy Lutomirski wrote:
> Running fbcon on an uncached framebuffer is remarkably slow.  So try
> to enable write combining in efifb.
> 
> Without this patch, it takes 5.8 seconds from efifb probe to i915
> probe (default options; no plymouth or quiet mode).  With this patch,
> it only takes 1.7 seconds.  That means we wasted over 4 seconds just
> writing to UC memory.
> 
> Signed-off-by: Andy Lutomirski <luto@mit.edu>

Looks good:

Signed-off-by: Peter Jones <pjones@redhat.com>


> ---
>  drivers/video/efifb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
> index 4eb38db..a81c944 100644
> --- a/drivers/video/efifb.c
> +++ b/drivers/video/efifb.c
> @@ -413,7 +413,7 @@ static int __devinit efifb_probe(struct platform_device *dev)
>  	info->apertures->ranges[0].base = efifb_fix.smem_start;
>  	info->apertures->ranges[0].size = size_remap;
>  
> -	info->screen_base = ioremap(efifb_fix.smem_start, efifb_fix.smem_len);
> +	info->screen_base = ioremap_wc(efifb_fix.smem_start, efifb_fix.smem_len);
>  	if (!info->screen_base) {
>  		printk(KERN_ERR "efifb: abort, cannot ioremap video memory "
>  				"0x%x @ 0x%lx\n",


-- 
        Peter

If you're not part of the solution, then you're part of the precipitate.

01234567890123456789012345678901234567890123456789012345678901234567890123456789
