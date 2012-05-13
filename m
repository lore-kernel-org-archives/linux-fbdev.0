From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 13 May 2012 21:00:39 +0000
Subject: Re: [PATCH] drivers/video: fsl-diu-fb: don't initialize the THRESHOLDS registers
Message-Id: <4FB020F7.504@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1336687048-16519-1-git-send-email-timur@freescale.com>
In-Reply-To: <1336687048-16519-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 05/10/2012 09:57 PM, Timur Tabi wrote:
> The THRESHOLDS register configures thresholds for two interrupts, but
> these interrupts are not used in the DIU driver.  An early version of the
> driver may have used the "lines before vsync" interrupt, which requires
> the LS_BF_VS of THRESHOLDS to be initialized.
> 
> Unfortunately, the initialization of this register does not do a
> read-modify-write to set only LS_BF_VS.  On the MPC8610, the value
> written is correct.  On other chips, like the P1022, the value overwrites
> some reserved bits.  This results in a performance drop on the P1022.
> 
> Since the default value is acceptable as-is on all SOCs, we should just
> avoid touching this register.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/fsl-diu-fb.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index 6af3f16..458c006 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -834,7 +834,6 @@ static void update_lcdc(struct fb_info *info)
>  	diu_ops.set_pixel_clock(var->pixclock);
>  
>  	out_be32(&hw->syn_pol, 0);	/* SYNC SIGNALS POLARITY */
> -	out_be32(&hw->thresholds, 0x00037800); /* The Thresholds */
>  	out_be32(&hw->int_status, 0);	/* INTERRUPT STATUS */
>  	out_be32(&hw->plut, 0x01F5F666);
>  

