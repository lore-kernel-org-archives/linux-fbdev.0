From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: 2.6.7 still garbage upon start
Date: Sat, 19 Jun 2004 14:13:03 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406191413.03881.adaplas@hotpop.com>
References: <40D21E31.5070904@winischhofer.net> <200406190240.31144.adaplas@hotpop.com> <20040619030854.GB14319@havoc.gtf.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbZ6j-0005iZ-3r
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 23:13:41 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbZ6i-0001dH-PM
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 23:13:40 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 666706227D5
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Jun 2004 05:34:54 +0000 (UTC)
In-Reply-To: <20040619030854.GB14319@havoc.gtf.org>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: David Eger <eger@havoc.gtf.org>, adaplas@pol.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, John Zielinski <grim@undead.cc>, Thomas Winischhofer <thomas@winischhofer.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Saturday 19 June 2004 11:08, David Eger wrote:
> On Sat, Jun 19, 2004 at 02:40:31AM +0800, Antonino A. Daplas wrote:
> > Actually, to eliminate the white rectangle, we just need to initialize
> > fbdev _after_ vgacon.  Currently, there is a set_par call in
> > fbcon_startup()) which is called prior to vgacon_deinit.
> >
> >  [snip]
> >
> > I've include a patch that incorporates all of the above.  (It also has
> > some fixes for problems with creation of logo space -- the code does not
> > consider that the new VC window size is different or even smaller than
> > the old VC window size). Please test, and if it works for you, I'll push
> > it upstream.
>
> with my cirrusfb driver and your patch, the area to the right of the
> penguins is cleared, but the area where the text is drawn still has
> white rectangle crud that scrolls off the screen.

Most probably, you are initializing your graphics card  before you register 
the framebuffer.  You should not do it, but only on an explict fb_set_par() 
call. If that cannot be avoided, we can extend the rectangle for fillrect() 
in fb_show_logo() - fbmem.c.  So instead of rect.height = 
fb_logo.logo->height, use info->var.xres (or info->var.yres_virtual). You 
might lose some of the text messages though, not sure.

Tony





-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
