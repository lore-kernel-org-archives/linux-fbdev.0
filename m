From: Jonathan Corbet <corbet@lwn.net>
Date: Thu, 23 Jul 2020 19:58:29 +0000
Subject: Re: [PATCH -resend] Documentation: fb, fix path to modedb.c
Message-Id: <20200723135829.35b44922@lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200723103454.26167-1-jslaby@suse.cz>
In-Reply-To: <20200723103454.26167-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org

On Thu, 23 Jul 2020 12:34:54 +0200
Jiri Slaby <jslaby@suse.cz> wrote:

> modedb.c was moved twice since the modedb documentation was written.
> Update the path to the current one.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/fb/modedb.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/fb/modedb.rst b/Documentation/fb/modedb.rst
> index 624d08fd2856..4d2411e32ebb 100644
> --- a/Documentation/fb/modedb.rst
> +++ b/Documentation/fb/modedb.rst
> @@ -152,7 +152,7 @@ To specify a video mode at bootup, use the following boot options::
>      video=<driver>:<xres>x<yres>[-<bpp>][@refresh]
>  
>  where <driver> is a name from the table below.  Valid default modes can be
> -found in linux/drivers/video/modedb.c.  Check your driver's documentation.
> +found in drivers/video/fbdev/core/modedb.c.  Check your driver's documentation.
>  There may be more modes::

"resend" but I've never seen it before...in any case I've applied it now.

Thanks,

jon
