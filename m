From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Mon, 27 May 2013 14:43:13 +0000
Subject: Re: [PATCH 1/3] video: display_timing: add doubleclk flag
Message-Id: <20130527144313.GC23825@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369658015-11743-1-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1369658015-11743-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, kernel@pengutronix.de, dri-devel@lists.freedesktop.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On 14:33 Mon 27 May     , Lucas Stach wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

If you want to take it via dri I'm fine otherwise via fbdev

Best Regards,
J.
> ---
>  include/video/display_timing.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/video/display_timing.h b/include/video/display_timing.h
> index 5d0259b..28d9d0d 100644
> --- a/include/video/display_timing.h
> +++ b/include/video/display_timing.h
> @@ -27,6 +27,7 @@ enum display_flags {
>  	DISPLAY_FLAGS_PIXDATA_NEGEDGE	= BIT(7),
>  	DISPLAY_FLAGS_INTERLACED	= BIT(8),
>  	DISPLAY_FLAGS_DOUBLESCAN	= BIT(9),
> +	DISPLAY_FLAGS_DOUBLECLK		= BIT(10),
>  };
>  
>  /*
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
