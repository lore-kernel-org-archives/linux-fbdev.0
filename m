From: Pavel Machek <pavel@ucw.cz>
Date: Tue, 04 Aug 2015 20:32:50 +0000
Subject: Re: [PATCH] fbcon: unconditionally initialize cursor blink interval
Message-Id: <20150804203250.GA655@amd>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.11.1508041215100.1151@local>
In-Reply-To: <alpine.DEB.2.11.1508041215100.1151@local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scot Doyle <lkml14@scotdoyle.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue 2015-08-04 12:33:32, Scot Doyle wrote:
> A sun7i-a20-olinuxino-micro fails to boot when kernel parameter
> vt.global_cursor_default=0. The value is copied to vc->vc_deccm
> causing the initialization of ops->cur_blink_jiffies to be skipped.
> Unconditionally initialize it.
> 
> Reported-and-tested-by: Jonathan Liu <net147@gmail.com>
> Signed-off-by: Scot Doyle <lkml14@scotdoyle.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> index 658c34b..1aaf893 100644
> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -1306,10 +1306,11 @@ static void fbcon_cursor(struct vc_data *vc, int mode)
>  	int y;
>   	int c = scr_readw((u16 *) vc->vc_pos);
>  
> +	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
> +
>  	if (fbcon_is_inactive(vc, info) || vc->vc_deccm != 1)
>  		return;
>  
> -	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
>  	if (vc->vc_cursor_type & 0x10)
>  		fbcon_del_cursor_timer(info);
>  	else

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
