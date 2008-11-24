From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Fix FB console blanking
Date: Mon, 24 Nov 2008 17:41:31 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0811241740390.12405@anakin>
References: <1227542850-25928-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@linux-m68k.org>) id 1L4eVL-0006sa-2W
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Nov 2008 16:41:43 +0000
Received: from monty.telenet-ops.be ([195.130.132.56])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L4eVI-00056Z-Dx for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Nov 2008 16:41:43 +0000
In-Reply-To: <1227542850-25928-1-git-send-email-dbaryshkov@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

On Mon, 24 Nov 2008, Dmitry Baryshkov wrote:
> The commit aef7db4bd5a3b6068dfa05919a3d685199eed116 fixed the problem
> with recursive locking in fb blanking code if blank is caused by user
> setting the /sys/class/graphics/fb*/blank. However this broke the fbcon
> timeout blanking.

Can you please explain a bit more about what `broken' means? What happens, how
can I reproduce it?

Thanks!

> Restore fbcon blanking and at the same time apply the proper fix for the
> above problem: if fbcon_blank is called with FBINFO_FLAG_USEREVENT, we
> are already called through notification from fb_blank, thus we don't
> have to blank the fb again.

Is it just an issue of blanking again if the display is already blanked?

> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
> ---
>  drivers/video/console/fbcon.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
> index 9cbff84..2f2f0f9 100644
> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -2400,16 +2400,13 @@ static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
>  
>   	if (!fbcon_is_inactive(vc, info)) {
>  		if (ops->blank_state != blank) {
> -			int ret = 1;
> -
>  			ops->blank_state = blank;
>  			fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
>  			ops->cursor_flash = (!blank);
>  
> -			if (info->fbops->fb_blank)
> -				ret = info->fbops->fb_blank(blank, info);
> -			if (ret)
> -				fbcon_generic_blank(vc, info, blank);
> +			if (!(info->flags & FBINFO_MISC_USEREVENT))
> +				if (fb_blank(info, blank))
> +					fbcon_generic_blank(vc, info, blank);
>  		}
>  
>  		if (!blank)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
