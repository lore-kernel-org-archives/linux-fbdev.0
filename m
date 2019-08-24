From: Matthew Wilcox <willy@infradead.org>
Date: Sat, 24 Aug 2019 15:34:46 +0000
Subject: Re: [PATCH 2/2] fbdev: fbmem: allow overriding the number of bootup logos
Message-Id: <20190824153446.GB28002@bombadil.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190823084725.4271-1-peda@axentia.se>
 <20190823084725.4271-3-peda@axentia.se>
In-Reply-To: <20190823084725.4271-3-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Rosin <peda@axentia.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jonathan Corbet <corbet@lwn.net>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Fri, Aug 23, 2019 at 08:47:47AM +0000, Peter Rosin wrote:
> +++ b/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -56,6 +56,9 @@ EXPORT_SYMBOL(num_registered_fb);
>  bool fb_center_logo __read_mostly;
>  EXPORT_SYMBOL(fb_center_logo);
>  
> +unsigned int fb_logo_count __read_mostly;
> +EXPORT_SYMBOL(fb_logo_count);

Why does this symbol need to be exported?  As I read the Makefile, fbcon
and fbmem are combined into the same module, so while the symbol needs
to be non-static, it doesn't need to be exported to other modules.
