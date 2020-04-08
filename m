From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 08 Apr 2020 20:01:41 +0000
Subject: Re: [PATCH] fbdev: mx3fb: const pointer to ipu_di_signal_cfg
Message-Id: <20200408200141.GM4881@pendragon.ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200408162551.3928330-1-arnd@arndb.de> <87pnchhp2s.fsf@intel.com>
 <20200408180216.GC24828@ravnborg.org>
 <20200408182926.GA21997@ravnborg.org>
In-Reply-To: <20200408182926.GA21997@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Enrico Weigelt <info@metux.net>

Hi Sam,

Thank you for the patch.

On Wed, Apr 08, 2020 at 08:29:26PM +0200, Sam Ravnborg wrote:
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> and
> Jani Nikula <jani.nikula@intel.com> both
> suggested to make the pointer to struct ipu_di_signal_cfg const.
> 
> Fix this.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Fixes: 3f6c93ec9254 ("fbdev: mx3fb: avoid warning about psABI change")
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Enrico Weigelt <info@metux.net>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-fbdev@vger.kernel.org

Assuming this is compile-tested,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Again, sorry. I should have waited a day before applying.
> 
> 	Sam
> 
>  drivers/video/fbdev/mx3fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
> index e13fea3a292f..603731a5a72e 100644
> --- a/drivers/video/fbdev/mx3fb.c
> +++ b/drivers/video/fbdev/mx3fb.c
> @@ -509,7 +509,7 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
>  			  uint16_t h_start_width, uint16_t h_sync_width,
>  			  uint16_t h_end_width, uint16_t v_start_width,
>  			  uint16_t v_sync_width, uint16_t v_end_width,
> -			  struct ipu_di_signal_cfg *sig)
> +			  const struct ipu_di_signal_cfg *sig)
>  {
>  	unsigned long lock_flags;
>  	uint32_t reg;

-- 
Regards,

Laurent Pinchart
