From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 22 Aug 2011 12:22:25 +0000
Subject: Re: [PATCH 05/10] OMAP: DSS2: string parsing cleanups
Message-Id: <1314015745.2168.41.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
	 <1314001671-18123-6-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1314001671-18123-6-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org

On Mon, 2011-08-22 at 11:27 +0300, Tomi Valkeinen wrote:
> Use strtobool and kstrto* functions when parsing sysfs inputs.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/dss/display.c |   21 +++++++++------------
>  drivers/video/omap2/dss/manager.c |   37 +++++++++++++++++++------------------
>  drivers/video/omap2/dss/overlay.c |    7 +++----
>  3 files changed, 31 insertions(+), 34 deletions(-)

<snip>

> diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
> index a95f25e..b2a5685 100644
> --- a/drivers/video/omap2/dss/overlay.c
> +++ b/drivers/video/omap2/dss/overlay.c
> @@ -211,17 +211,16 @@ static ssize_t overlay_enabled_show(struct omap_overlay *ovl, char *buf)
>  static ssize_t overlay_enabled_store(struct omap_overlay *ovl, const char *buf,
>  		size_t size)
>  {
> -	int r, enable;
> +	int r;
> +	bool enable;
>  	struct omap_overlay_info info;
>  
>  	ovl->get_overlay_info(ovl, &info);
>  
> -	r = kstrtoint(buf, 0, &enable);
> +	r = strtobool(buf, &enable);
>  	if (r)
>  		return r;
>  
> -	info.enabled = !!enable;
> -
>  	r = ovl->set_overlay_info(ovl, &info);
>  	if (r)
>  		return r;

Oops. This removes the lines that write the new value to overlay_info,
thus making it impossible to change the enable-status. I'll fix this.

 Tomi


