From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] uvesafb: Fix warnings about unused
	variables on non-x86
Date: Fri, 9 Nov 2007 16:47:13 -0800
Message-ID: <20071109164713.f31c6cd1.akpm@linux-foundation.org>
References: <1194563299-19768-1-git-send-email-frank@lichtenheld.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IqeVZ-0000GD-IT for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Nov 2007 16:47:33 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IqeVZ-0006kQ-Ab
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Nov 2007 16:47:33 -0800
In-Reply-To: <1194563299-19768-1-git-send-email-frank@lichtenheld.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Cc: spock@gentoo.org, frank@lichtenheld.de, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Fri,  9 Nov 2007 00:08:19 +0100
Frank Lichtenheld <frank@lichtenheld.de> wrote:

> Variables that are only used in #ifdef CONFIG_X86 should also
> only be declared there.
> 
> Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> ---
>  drivers/video/uvesafb.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
> index b983d26..d1d6c0f 100644
> --- a/drivers/video/uvesafb.c
> +++ b/drivers/video/uvesafb.c
> @@ -926,8 +926,10 @@ static int uvesafb_setpalette(struct uvesafb_pal_entry *entries, int count,
>  		int start, struct fb_info *info)
>  {
>  	struct uvesafb_ktask *task;
> +#ifdef CONFIG_X86
>  	struct uvesafb_par *par = info->par;
>  	int i = par->mode_idx;
> +#endif
>  	int err = 0;
>  
>  	/*
> @@ -1103,11 +1105,11 @@ static int uvesafb_pan_display(struct fb_var_screeninfo *var,
>  
>  static int uvesafb_blank(int blank, struct fb_info *info)
>  {
> -	struct uvesafb_par *par = info->par;
>  	struct uvesafb_ktask *task;
>  	int err = 1;
> -
>  #ifdef CONFIG_X86
> +	struct uvesafb_par *par = info->par;
> +
>  	if (par->vbe_ib.capabilities & VBE_CAP_VGACOMPAT) {
>  		int loop = 10000;
>  		u8 seq = 0, crtc17 = 0;

OK, but ug.  That's some quite nasty code you've found there.

it would come out better if that x86-specific code was pulled out into
separate functions like

#ifdef CONFIG_X86
static int do_x86_stuff(...)
{
	...
	return 1;
}
#else
static int do_x86_stuff(...)
{
	return 0;
}
#endif


static int uvesafb_setpalette(...)
{
	if (do_x86_stuff(...) == 0) {
		<do non-x86-specific-stuff>
	}
}


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
