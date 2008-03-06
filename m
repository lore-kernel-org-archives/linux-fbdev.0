From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] uvesafb: don't treat valid modes
 returned by fb_find_mode() as errors
Date: Wed, 5 Mar 2008 22:54:12 -0800
Message-ID: <20080305225412.ad1d3bb5.akpm@linux-foundation.org>
References: <20080127113456.GA17976@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JXA0E-0001pd-W5 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Mar 2008 22:54:55 -0800
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JXA0D-0002eR-PL
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Mar 2008 22:54:55 -0800
In-Reply-To: <20080127113456.GA17976@spock.one.pl>
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
Cc: Michal Januszewski <spock@gentoo.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sun, 27 Jan 2008 12:34:56 +0100 Michal Januszewski <spock@gentoo.org> wrote:

> From: Michal Januszewski <spock@gentoo.org>
> 
> Don't treat valid modes returned by fb_find_mode() (best-fit modes,
> default modes or the first valid mode) as errors.
> 

This changelog is too brief.

> ---
> diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
> index a14ef89..fc68b3e 100644
> --- a/drivers/video/uvesafb.c
> +++ b/drivers/video/uvesafb.c
> @@ -885,7 +885,7 @@ static int __devinit uvesafb_vbe_init_mode(struct fb_info *info)
>  	}
>  
>  	/* fb_find_mode() failed */
> -	if (i == 0 || i >= 3) {
> +	if (i == 0) {
>  		info->var.xres = 640;
>  		info->var.yres = 480;
>  		mode = (struct fb_videomode *)
> 

Because I cannot tell what are the consequences of the bug which you're
fixing, hence I cannot tell whether we need this fix in 2.6.25 or even
2.6.24.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
