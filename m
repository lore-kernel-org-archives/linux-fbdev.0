From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 19 Oct 2020 15:56:19 +0000
Subject: Re: [PATCH 2/2 RESEND] docs: fb: Add font_6x8 to available built-in fonts
Message-Id: <20201019155619.GH401619@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <717bb41dda8e2ed615f3faadfbc3e215de726d38.1603037079.git.yepeilin.cs@gmail.com>
 <20201018205401.698242-1-yepeilin.cs@gmail.com>
In-Reply-To: <20201018205401.698242-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peilin Ye <yepeilin.cs@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sven Schneider <s.schneider@arkona-technologies.de>

On Sun, Oct 18, 2020 at 04:54:01PM -0400, Peilin Ye wrote:
> Recently we added a new 6x8 font in commit e2028c8e6bf9 ("lib/fonts: add
> font 6x8 for OLED display"). Add its name to the "compiled-in fonts"
> list.
> 
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> ---
> Resending +Cc: dri-devel, sorry if I spammed.

Both this and patch 1/2 with the actual bugfix merged to
drm-misc-next-fixes, should still make it into the merge window before
-rc1.

Thanks, Daniel

> 
>  Documentation/fb/fbcon.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
> index 9aad964b767c..57f66de2f7e1 100644
> --- a/Documentation/fb/fbcon.rst
> +++ b/Documentation/fb/fbcon.rst
> @@ -81,7 +81,7 @@ C. Boot options
>  1. fbcon=font:<name>
>  
>  	Select the initial font to use. The value 'name' can be any of the
> -	compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
> +	compiled-in fonts: 10x18, 6x10, 6x8, 7x14, Acorn8x8, MINI4x6,
>  	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, TER16x32, VGA8x16, VGA8x8.
>  
>  	Note, not all drivers can handle font with widths not divisible by 8,
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
