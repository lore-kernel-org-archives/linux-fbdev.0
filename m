From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: 2.6.7 still garbage upon start
Date: Tue, 22 Jun 2004 21:20:22 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406222120.22405.adaplas@hotpop.com>
References: <40D21E31.5070904@winischhofer.net> <200406191413.03881.adaplas@hotpop.com> <20040622094501.GA29480@havoc.gtf.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BclAD-0007rv-4A
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Jun 2004 06:18:13 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BclAC-0000vw-Jc
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Jun 2004 06:18:12 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id 0585974E18
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 22 Jun 2004 12:16:17 +0000 (UTC)
In-Reply-To: <20040622094501.GA29480@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Garzik <garzik@havoc.gtf.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tuesday 22 June 2004 17:45, David Eger wrote:
> On Sat, Jun 19, 2004 at 02:13:03PM +0800, Antonino A. Daplas wrote:
> > On Saturday 19 June 2004 11:08, David Eger wrote:
> > > with my cirrusfb driver and your patch, the area to the right of the
> > > penguins is cleared, but the area where the text is drawn still has
> > > white rectangle crud that scrolls off the screen.
> >
> > Most probably, you are initializing your graphics card  before you
> > register the framebuffer.  You should not do it, but only on an explict
> > fb_set_par() call.
>
> You're absolutely correct.
>
> Unfortunately, removing the set_par() call from the PCI driver probe
> code uncovered another problem.  For some reason, the VGA register writes

If you can't avoid doing a set_par duing initialization, you can always memset
the fb memory to the background color.  Not sure if it's going to completely
remove the garbage as vgacon continues to write to vga memory far beyond
fbdev registration.

Note: Doing a set_par during initialization will produce an unusable display 
if you load the driver without fbcon. You can always restore by loading
fbcon or running con2fbmap.

Tony





-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
