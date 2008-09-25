From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] fbdev: ignore VESA modes if framebuffer does not	support
 them
Date: Thu, 25 Sep 2008 02:12:48 -0700
Message-ID: <48DB5610.4020208@zytor.com>
References: <20080924190832.GA19141@spock.one.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754182AbYIYJSp@vger.kernel.org>
In-Reply-To: <20080924190832.GA19141@spock.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: spock@gentoo.org
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, krzysztof.h1@poczta.fm, Andrew Morton <akpm@linux-foundation.org>, bonbons@linux-vserver.org

Michal Januszewski wrote:
> Currently, it is possible to set a graphics VESA mode at boot time via
> the vga= parameter even when no framebuffer driver supporting this is
> configured.  This could lead to the system booting with a black screen,
> without a usable console.
> diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
> index 1ee2c05..20fdc2f 100644
> --- a/include/linux/screen_info.h
> +++ b/include/linux/screen_info.h
> @@ -76,6 +76,10 @@ extern struct screen_info screen_info;
>  #define ORIG_VIDEO_LINES	(screen_info.orig_video_lines)
>  #define ORIG_VIDEO_ISVGA	(screen_info.orig_video_isVGA)
>  #define ORIG_VIDEO_POINTS       (screen_info.orig_video_points)
> +
> +#define FB_SUPPORTS_BOOT_VESA (defined(CONFIG_FB_VESA) || \
> +		defined(CONFIG_FB_SIS) || defined(CONFIG_FB_IMAC) || \
> +		defined(CONFIG_FB_INTEL))
>  #endif /* __KERNEL__ */
>  
>  #endif /* _SCREEN_INFO_H */

I'm *REALLY* skeptical to burying this in screen_info like this, it 
would probably be better to put it in Kconfig, or it is unlikely to get 
updated properly.

	-hpa
