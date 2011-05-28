From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Date: Sat, 28 May 2011 17:48:12 +0000
Subject: Re: [TRIVIAL PATCH next 12/15] video: Convert vmalloc/memset to vzalloc
Message-Id: <201105281948.12941.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1306603968.git.joe@perches.com> <77538de911b8af99f68b7bcfbaaedce8e40db04f.1306603968.git.joe@perches.com>
In-Reply-To: <77538de911b8af99f68b7bcfbaaedce8e40db04f.1306603968.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Jaya Kumar <jayalk@intworks.biz>, Paul Mundt <lethal@linux-sh.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jiri Kosina <trivial@kernel.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org

Am Samstag 28 Mai 2011, 19:36:32 schrieb Joe Perches:
> diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
> index 3ec4923..86573e2 100644
> --- a/drivers/video/arcfb.c
> +++ b/drivers/video/arcfb.c
> @@ -515,11 +515,10 @@ static int __devinit arcfb_probe(struct
> platform_device *dev)
> 
>  	/* We need a flat backing store for the Arc's
>  	   less-flat actual paged framebuffer */
> -	if (!(videomemory = vmalloc(videomemorysize)))
> +	videomemory = vmalloc(videomemorysize);
> +	if (!videomemory)
>  		return retval;
shouldn't this be vzalloc too?

> -	memset(videomemory, 0, videomemorysize);
> -
>  	info = framebuffer_alloc(sizeof(struct arcfb_par), &dev->dev);
>  	if (!info)
>  		goto err;


Heiko
