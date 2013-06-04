From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 04 Jun 2013 01:21:38 +0000
Subject: Re: [PATCH] video: display_timing: make parameter const
Message-Id: <22104130.xMhTPUUMF8@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369657985-11703-1-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1369657985-11703-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, kernel@pengutronix.de

Hi,

On Monday 27 May 2013 14:33:05 Lucas Stach wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> As the device_node pointer is not changed in of_get_display_timing and
> parse_timing_property it can be a const pointer.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/video/of_display_timing.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/of_display_timing.c
> b/drivers/video/of_display_timing.c index 56009bc..85c1a41 100644
> --- a/drivers/video/of_display_timing.c
> +++ b/drivers/video/of_display_timing.c
> @@ -23,7 +23,7 @@
>   * Every display_timing can be specified with either just the typical value
> or * a range consisting of min/typ/max. This function helps handling this
> **/
> -static int parse_timing_property(struct device_node *np, const char *name,
> +static int parse_timing_property(const struct device_node *np, const char
> *name, struct timing_entry *result)
>  {
>  	struct property *prop;
> @@ -56,7 +56,8 @@ static int parse_timing_property(struct device_node *np,
> const char *name, * of_get_display_timing - parse display_timing entry from
> device_node * @np: device_node with the properties
>   **/
> -static struct display_timing *of_get_display_timing(struct device_node *np)
> +static struct display_timing *of_get_display_timing(const struct
> device_node +						    *np)
>  {
>  	struct display_timing *dt;
>  	u32 val = 0;
-- 
Regards,

Laurent Pinchart

