From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 03 Jul 2017 06:20:40 +0000
Subject: Re: [PATCH v2] staging: sm750fb: refactor method and fix potential type inconsistence
Message-Id: <20170703062040.GB13523@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170702144033.GA5784@lynnl.wit>
In-Reply-To: <20170702144033.GA5784@lynnl.wit>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lynn Lei <lynnl.wit@gmail.com>
Cc: sudipm.mukherjee@gmail.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, teddy.wang@siliconmotion.com, linux-kernel@vger.kernel.org

On Sun, Jul 02, 2017 at 10:40:33PM +0800, Lynn Lei wrote:
> include PANEL_DISPLAY_CTRL_FPVDDEN control mask


Does the subject match this?

> Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
> index 0f666dc2729a..c68367e6cdeb 100644
> --- a/drivers/staging/sm750fb/ddk750_display.c
> +++ b/drivers/staging/sm750fb/ddk750_display.c
> @@ -89,7 +89,7 @@ static void swPanelPowerSequence(int disp, int delay)
>  	u32 reg;
>  	u32 opt[] = {
>  		PANEL_DISPLAY_CTRL_FPEN, PANEL_DISPLAY_CTRL_DATA,
> -		PANEL_DISPLAY_CTRL_VBIASEN, PANEL_DISPLAY_CTRL_FPEN,
> +		PANEL_DISPLAY_CTRL_VBIASEN, PANEL_DISPLAY_CTRL_FPVDDEN,

Are you sure this is allowed?  Why is this patch correct?

And again, it doesn't match the subject line :(

greg k-h
