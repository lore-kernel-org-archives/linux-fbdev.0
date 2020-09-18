From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 18 Sep 2020 12:48:08 +0000
Subject: Re: [PATCH 0/3] fbdev: stop using compat_alloc_user_space
Message-Id: <20200918124808.GD438822@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200918100812.1447443-1-arnd@arndb.de>
In-Reply-To: <20200918100812.1447443-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, "David S . Miller" <davem@davemloft.net>, hch@lst.de

On Fri, Sep 18, 2020 at 12:08:10PM +0200, Arnd Bergmann wrote:
> The fbdev code uses compat_alloc_user_space in a few of its
> compat_ioctl handlers, which tends to be a bit more complicated
> and error-prone than calling the underlying handlers directly,
> so I would like to remove it completely.
> 
> This modifies two such functions in fbdev, and removes another
> one that is completely unused.
> 
>     Arnd
> 
> Arnd Bergmann (3):
>   fbdev: simplify fb_getput_cmap()
>   fbdev: sbuslib: remove unused FBIOSCURSOR32 helper
>   fbdev: sbuslib: remove compat_alloc_user_space usage

Looks all good, but we're also kinda looking for a new volunteer for
handling fbdev patches ... drm-misc commit rights, still not interested?
-Daniel

> 
>  drivers/video/fbdev/core/fbmem.c |  44 +++++------
>  drivers/video/fbdev/sbuslib.c    | 124 ++++++++++++++++++-------------
>  2 files changed, 90 insertions(+), 78 deletions(-)
> 
> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
