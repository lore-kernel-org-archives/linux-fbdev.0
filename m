From: David Eger <eger@havoc.gtf.org>
Subject: Re: 2.6.7 still garbage upon start
Date: Tue, 22 Jun 2004 05:45:01 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040622094501.GA29480@havoc.gtf.org>
References: <40D21E31.5070904@winischhofer.net> <200406190240.31144.adaplas@hotpop.com> <20040619030854.GB14319@havoc.gtf.org> <200406191413.03881.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bchq7-0006lk-WF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Jun 2004 02:45:16 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Bchq7-0002kz-MT
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Jun 2004 02:45:15 -0700
Content-Disposition: inline
In-Reply-To: <200406191413.03881.adaplas@hotpop.com>
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
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Garzik <garzik@havoc.gtf.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sat, Jun 19, 2004 at 02:13:03PM +0800, Antonino A. Daplas wrote:
> On Saturday 19 June 2004 11:08, David Eger wrote:
> >
> > with my cirrusfb driver and your patch, the area to the right of the
> > penguins is cleared, but the area where the text is drawn still has
> > white rectangle crud that scrolls off the screen.
> 
> Most probably, you are initializing your graphics card  before you register 
> the framebuffer.  You should not do it, but only on an explict fb_set_par() 
> call. 

You're absolutely correct.  

Unfortunately, removing the set_par() call from the PCI driver probe
code uncovered another problem.  For some reason, the VGA register writes
have to happen twice for the settings to take.  Jeff, this seems really
weird to me.  Do you have any idea why?  I sorta hate to leave in the hack:

cirrusfb_set_par_foo (info) {
	/* real register writes ... */
}

cirrusfb_set_par (info) {
	cirrusfb_set_par_foo (info);
	return cirrusfb_set_par_foo (info);
}

-dte


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
