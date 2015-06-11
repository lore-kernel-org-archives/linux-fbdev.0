From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 11 Jun 2015 09:32:45 +0000
Subject: Re: video, sm501: add OF binding to support SM501
Message-Id: <20150611093244.GG11734@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150610155132.GK10549@mwanda>
In-Reply-To: <20150610155132.GK10549@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Jun 11, 2015 at 11:24:41AM +0200, Heiko Schocher wrote:
>  static struct fb_videomode sm501_default_mode = {
> @@ -1963,6 +1965,11 @@ static int sm501fb_probe(struct platform_device *pdev)
>                                 if (info->edid_data)
>                                         found = 1;
>                         }
> +               } else {
> +                       if (fb_mode_cmdline)
> +                               strcpy(fb_mode, fb_mode_cmdline);

Could you make this a strncpy()?  These days strlcpy() is
unfashionable...  It's sort of pedantic and it goes over the 80 char
limit but the my static checker will complain if we don't.

				strncpy(fb_mod, fb_mode_cmdline,
					sizeof(fb_mod) - 1);

> +                       else
> +                               strcpy(fb_mode, fb_default_mode);

regards,
dan carpenter

