From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/4] fbdev: make fb_find_mode
	look	for a mode with the highest refresh rate
Date: Thu, 12 Jul 2007 16:34:53 +0800
Message-ID: <1184229293.4504.33.camel@daplas>
References: <20070623105046.GB12623@spock.one.pl>
	<20070623110424.9a68d82d.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I8u8k-0000zI-3z for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 01:35:10 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I8u8g-000416-LV
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 01:35:07 -0700
Received: by py-out-1112.google.com with SMTP id a25so152346pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jul 2007 01:35:05 -0700 (PDT)
In-Reply-To: <20070623110424.9a68d82d.akpm@linux-foundation.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, spock@gentoo.org, linux-kernel@vger.kernel.org

On Sat, 2007-06-23 at 11:04 -0700, Andrew Morton wrote:
> On Sat, 23 Jun 2007 12:50:46 +0200 Michal Januszewski <spock@gentoo.org> wrote:
> 
> > If the refresh rate hasn't been explicitly specified, fd_find_mode
> > currently returns the first mode with the requested resolution. Change
> > it so that it returns a mode with the requested resolution and the
> > highest refresh rate.
> > 
> > Also export fb_destroy_modelist, which is used in uvesafb.
> > 
> > Signed-off-by: Michal Januszewski <spock@gentoo.org>
> > ---
> > drivers/video/modedb.c |    7 +++++--
> >  1 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
> > index 3741ad7..98ee77b 100644
> > --- a/drivers/video/modedb.c
> > +++ b/drivers/video/modedb.c
> > @@ -606,16 +606,18 @@ done:
> >  	DPRINTK("Trying specified video mode%s %ix%i\n",
> >  	    refresh_specified ? "" : " (ignoring refresh rate)", xres, yres);
> >  
> > +	if (!refresh_specified)
> > +		refresh = 200;
> >  	diff = refresh;
> >  	best = -1;
> >  	for (i = 0; i < dbsize; i++) {
> >  		if (name_matches(db[i], name, namelen) ||
> >  		    (res_specified && res_matches(db[i], xres, yres))) {
> >  			if(!fb_try_mode(var, info, &db[i], bpp)) {
> > -				if(!refresh_specified || db[i].refresh == refresh)
> > +				if (refresh_specified && db[i].refresh == refresh)
> >  					return 1;
> >  				else {
> > -					if(diff > abs(db[i].refresh - refresh)) {
> > +					if (diff > abs(db[i].refresh - refresh)) {
> >  						diff = abs(db[i].refresh - refresh);
> >  						best = i;
> >  					}
> > @@ -938,6 +940,7 @@ void fb_destroy_modelist(struct list_head *head)
> >  		kfree(pos);
> >  	}
> >  }
> > +EXPORT_SYMBOL_GPL(fb_destroy_modelist);
> >  
> 
> fbdev ignoramus asks: isn't this pretty risky?  People who were previously
> relying upon (or at least using) the kernel's default resolution will find
> their displays coming up in a quite different resolution.

It's only the refresh rate that will change.  The current behavior is
that a user can get near random results in terms of the vertical refresh
rates.  At least with this patch, we know what we get.

> 
> This change seems to be quite unrelated to the uvesafb stuff and should be
> in a separate patch from the export, which _is_ uvesafb-related.  I think. 
> If that's wrong then the changelog could do with some attention.
> 

Tony


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
