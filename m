From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch] fbcon: Fix workqueue shutdown
Date: Sat, 6 Dec 2008 23:16:42 -0800
Message-ID: <20081206231642.e685d7f0.akpm@linux-foundation.org>
References: <4909EB41.40100@am.sony.com>
	<493722F0.5070707@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1L9Dsp-0004Xv-Pb
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 07 Dec 2008 07:16:51 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L9Dsn-00008k-2H
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 07 Dec 2008 07:16:51 +0000
In-Reply-To: <493722F0.5070707@am.sony.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.netGeert, adaplas@gmail.com

On Wed, 3 Dec 2008 16:23:12 -0800 Geoff Levand <geoffrey.levand@am.sony.com> wrote:

> Add a call to cancel_work_sync() in fbcon_exit() to cancel
> any pending work in the fbcon workqueue.  Also, change the
> assignment of the workqueue function info->queue.func from
> NULL to fb_flashcursor(),

OK.

> and add a corresponding check in
> fb_flashcursor() to exit immediately if the variable
> fbcon_has_exited is set.

Why was this second part added?

> The current implementation of fbcon_exit() sets the fbcon
> workqueue function info->queue.func to NULL, but does not
> assure that there is no work pending when it does so.  On
> occasion, depending on system timing, there will still be
> pending work in the queue when fbcon_exit() is called.
> This results in a null pointer deference when
> run_workqueue() tries to call the queue's work function.
> 
> Fixes errors on shutdown similar to these:
> 
>   Console: switching to colour dummy device 80x25
>   Unable to handle kernel paging request for data at address 0x00000000
> 
> ...
>
> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -394,13 +394,19 @@ static void fbcon_update_softback(struct
>  
>  static void fb_flashcursor(struct work_struct *work)
>  {
> -	struct fb_info *info = container_of(work, struct fb_info, queue);
> -	struct fbcon_ops *ops = info->fbcon_par;
> +	struct fb_info *info;
> +	struct fbcon_ops *ops;
>  	struct display *p;
>  	struct vc_data *vc = NULL;
>  	int c;
>  	int mode;
>  
> +	if (fbcon_has_exited)
> +		return;

This whole fbcon_has_exited thing has big red "wrong" lights flashing
all over it.

If drivers get all their refcounting, locking and synchronisation
correct, such things are unneeded.


------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
