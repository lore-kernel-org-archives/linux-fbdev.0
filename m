From: Randy Dunlap <randy.dunlap@oracle.com>
Date: Wed, 07 Jul 2010 17:04:35 +0000
Subject: Re: [PATCH v2 1/2] S5PV210: FB: Add MIPI-DSI and CPU Interface
Message-Id: <20100707100435.19fa8600.randy.dunlap@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4C341FFD.6010405@samsung.com>
	<4C342127.9000900@samsung.com>
In-Reply-To: <4C342127.9000900@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 07 Jul 2010 15:39:35 +0900 InKi Dae wrote:

> this patch adds features for supportting MIPI Interface and CPU mode to
> s3c-fb.c
> 
> for this, I added following features.
> . add struct fb_cmdmode
> - this structure would be used for cpu interface.
> . add interface_mode to struct s3c_fb_platdata.
> - this variable would be used to distinguishe whether CPU or RGB mode.
> . add two functions for cpu interface.
> - s3c_fb_set_trigger would be used for to send trigger signal to FIMD.
> - s3c_fb_is_i80_frame_done would be used to check framedone status.
> . add a function for setting timing.
> - I added this function because it have to distinguishe interfaces.
> (CPU or RGB mode)
> . add register definitions for using MIPI-DSI mode.
> 
> Signed-off-by: InKi Dae <inki.dae@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Please include a diffstat summary so that reviewers can see what files are
being changed/added/removed and how large the changes are.
See Documentation/SubmittingPatches for info.



> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index 9682ecc..28d34ef 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -255,6 +255,73 @@ static int s3c_fb_align_word(unsigned int bpp, unsigned int pix)
>  }
>  
>  /**
> + * s3c_fb_set_trigger - fimd trigger based on cpu interface.

kernel-doc notation is missing the function argument line:

 * @info: <description>

> + */
> +void s3c_fb_set_trigger(struct fb_info *info)
> +{
> +	struct s3c_fb_win *win = info->par;
> +	struct s3c_fb *sfb = win->parent;
> +	void __iomem *regs = sfb->regs;
> +	u32 reg = 0;
> +
> +	reg = readl(regs + TRIGCON);
> +
> +	reg |= TRGMODE_I80_ENABLE | SWTRGCMD_I80_TRIGGER;
> +
> +	writel(reg, regs + TRIGCON);
> +}
> +
> +/**
> + * s3c_fb_is_i80_frame_done - get i80 frame done status.

Ditto.

> + */
> +int s3c_fb_is_i80_frame_done(struct fb_info *info)
> +{
> +	struct s3c_fb_win *win = info->par;
> +	struct s3c_fb *sfb = win->parent;
> +	void __iomem *regs = sfb->regs;
> +	u32 reg = 0;
> +
> +	reg =  readl(regs + TRIGCON);
> +
> +	return (((reg & SWFRSTATUS_I80) = SWFRSTATUS_I80) ? 1 : 0);
> +}
> +
> +/**
> + * s3c_fb_set_cpu_timing - set cpu timing.

Ditto.

> + */
> +static void s3c_fb_set_timing(struct s3c_fb *sfb, struct fb_info *info)
> +{
> +	struct s3c_fb_win *win = info->par;
> +	struct s3c_fb_pd_win *windata = win->windata;
> +	struct fb_var_screeninfo *var = &info->var;
> +	void __iomem *regs = sfb->regs;
> +	u32 reg = 0;
> +
> +	if (sfb->pdata->interface_mode = FIMD_VIDEO_MODE) {
> +		reg = VIDTCON0_VBPD(var->upper_margin - 1) |
> +		       VIDTCON0_VFPD(var->lower_margin - 1) |
> +		       VIDTCON0_VSPW(var->vsync_len - 1);
> +
> +		writel(reg, regs + VIDTCON0);
> +
> +		reg = VIDTCON1_HBPD(var->left_margin - 1) |
> +		       VIDTCON1_HFPD(var->right_margin - 1) |
> +		       VIDTCON1_HSPW(var->hsync_len - 1);
> +
> +		writel(reg, regs + VIDTCON1);
> +	} else if (sfb->pdata->interface_mode = FIMD_COMMAND_MODE) {
> +		reg = LCD_CS_SETUP(windata->cmd_mode.cs_setup) |
> +			LCD_WR_SETUP(windata->cmd_mode.wr_setup) |
> +			LCD_WR_ACT(windata->cmd_mode.wr_act) |
> +			LCD_WR_HOLD(windata->cmd_mode.wr_hold) |
> +			I80IFEN_ENABLE;
> +
> +		writel(reg, regs + I80IFCONA0);
> +	} else
> +		dev_warn(sfb->dev, "wrong interface type.\n");
> +}
> +
> +/**
>   * s3c_fb_set_par() - framebuffer request to set new framebuffer state.
>   * @info: The framebuffer to change.
>   *


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
