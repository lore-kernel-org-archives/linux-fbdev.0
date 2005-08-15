From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] intelfb/fbdev: Save info->flags in a local variable
Date: Mon, 15 Aug 2005 09:58:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508150957230.3553@g5.osdl.org>
References: <430098A7.1080102@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E4iIK-0008G4-Cx
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Aug 2005 09:58:40 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1E4iIJ-0004a5-AD
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Aug 2005 09:58:40 -0700
In-Reply-To: <430098A7.1080102@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, Pavel Kysilka <goldenfish@bsys.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>



On Mon, 15 Aug 2005, Antonino A. Daplas wrote:
>
> @@ -697,7 +697,7 @@ fb_set_var(struct fb_info *info, struct 
>  			    !list_empty(&info->modelist))
>  				err = fb_add_videomode(&mode, &info->modelist);
>  
> -			if (!err && info->flags & FBINFO_MISC_USEREVENT) {
> +			if (!err && flags & FBINFO_MISC_USEREVENT) {
>  				struct fb_event event;
>  				int evnt = (var->activate & FB_ACTIVATE_ALL) ?
>  					FB_EVENT_MODE_CHANGE_ALL :

This doesn't match my tree - I assume we're talking about the -mm tree 
here.

I can/will fix up the thing by hand, but somebody should check it.

		Linus


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
