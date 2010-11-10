From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 10 Nov 2010 01:03:34 +0000
Subject: Re: [PATCH] sisfb: limit POST memory test according to PCI resource length
Message-Id: <20101110010334.GA28852@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289341504-1038-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1289341504-1038-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Thomas Winischhofer <thomas@winischhofer.net>

On Wed, Nov 10, 2010 at 12:25:04AM +0200, Aaro Koskinen wrote:
> diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
> index b52f8e4..8a528aa 100644
> --- a/drivers/video/sis/sis_main.c
> +++ b/drivers/video/sis/sis_main.c
> @@ -4514,7 +4514,7 @@ sisfb_post_sis300(struct pci_dev *pdev)
>  	} else {
>  #endif
>  		/* Need to map max FB size for finding out about RAM size */
> -		mapsize = 64 << 20;
> +		mapsize = ivideo->video_size;
>  		sisfb_post_map_vram(ivideo, &mapsize, 4);
>  
>  		if(ivideo->video_vbase) {
> @@ -4680,7 +4680,7 @@ sisfb_post_xgi_ramsize(struct sis_video_info *ivideo)
>  	orSISIDXREG(SISSR, 0x20, (0x80 | 0x04));
>  
>  	/* Need to map max FB size for finding out about RAM size */
> -	mapsize = 256 << 20;
> +	mapsize = ivideo->video_size;
>  	sisfb_post_map_vram(ivideo, &mapsize, 32);
>  
>  	if(!ivideo->video_vbase) {
> 
sisfb_post_map_vram() expects that the mapsize >= min, and falls back on
the default aperture size otherwise. If you're going to pass in a
variable size for video_size then this expectation may no longer hold
true, and you've then changed the behaviour if an invalid size succeeds
on the initial ioremap() attempt.

Simply inserting a:

	if (*mapsize < min)
		return;

sanity check prior to the ioremap() should preserve the existing
behaviour.
