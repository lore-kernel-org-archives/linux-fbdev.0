From: krzysztof.h1@poczta.fm
Subject: Re: [PATCH] fix scrolling after logo is cleared
Date: 31 Jul 2008 11:48:59 +0200
Message-ID: <20080731094859.C898945B81B@f49.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOUmN-0006go-Rm for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 02:49:03 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KOUmM-00023n-An
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 02:49:03 -0700
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
To: Andrew Morton <akpm@linux-foundation.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

> On Wed, 28 May 2008 22:53:37 +0200 Krzysztof Helt <krzysztof.h1@poczta.fm>
> wrote:
> 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > If the 'clear' command is used on the frame buffer
> > with a logo the upper area is filled by few lines but
> > not scrolled anymore.
> > Fix this by removing the protected area for the logo
> > if any part of the logo is cleared.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > ---
> > 
> > diff -urp linux-rc2/drivers/video/console/fbcon.c
> linux-new/drivers/video/console/fbcon.c
> > --- linux-rc2/drivers/video/console/fbcon.c	2008-05-12
> 18:16:23.193553990 +0200
> > +++ linux-new/drivers/video/console/fbcon.c	2008-05-26
> 21:10:17.592997192 +0200
> > @@ -1312,6 +1310,9 @@ static void fbcon_clear(struct vc_data *
> >  	if (!height || !width)
> >  		return;
> >  
> > +	if (sy < vc->vc_top && vc->vc_top == logo_lines)
> > +		vc->vc_top = 0;
> > +
> >  	/* Split blits that cross physical y_wrap boundary */
> >  
> >  	y_break = p->vrows - p->yscroll;
> > 
> 
> So I'm trolling linux-fbdev-devel for lost patches and I come across
> this one.
> 
> It is still good?  If so, do you think it should be in 2.6.27?  And
> earlier?
> 

I forgot this one. I sent it to get a feedback from other fbdev devs but forgot to resend it with cc to you.

Yes, it is  still good.  It is side effect of the tridentfb testing.

Regards,
Krzysztof

----------------------------------------------------------------------
Najciekawsze miejsca w Polsce i na swiecie!
Zobacz >>> http://link.interia.pl/f1e60


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
