From: Stuart Young <sgy-lkml@amc.com.au>
Subject: Re: Re: fbdv/fbcon pending problems
Date: Wed, 25 Feb 2004 18:14:50 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200402251812.26624.sgy-lkml@amc.com.au>
References: <1077497593.5960.28.camel@gaston> <200402241657.37382.sgy-lkml@amc.com.au> <Pine.GSO.4.58.0402240935390.3187@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvtOo-00042L-Gx
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 23:24:06 -0800
Received: from mail1.amc.com.au ([203.15.175.2])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Avt3O-00066q-2d
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 23:01:58 -0800
In-Reply-To: <Pine.GSO.4.58.0402240935390.3187@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Tue, 24 Feb 2004 07:36 pm, Geert Uytterhoeven wrote:
> On Tue, 24 Feb 2004, Stuart Young wrote:
> > On Mon, 23 Feb 2004 11:53 am, Benjamin Herrenschmidt wrote:
> > >  - Logo problems. When booting with a logo, then going to getty, the
> > > logo doesn't get erased until we actually switch to another console (or
> > > reset the console). At this point, using things like vi & scrolling up
> > > doesn't work properly. Actually, last time I tried, I had to switch
> > > back & forth twice before my console that had the logo got fully
> > > working with vi.
> >
> > If it's possible to unlock this region so that it scrolls again from
> > userspace (ie: not resetting/clearing it, just unlocking it), then it's
> > just a simple matter of checking wether the current console is an fb
> > device, and if it is, making it unlock the scrolling region. In Debian,
> > this could be done in /etc/init.d/rmnologin, or even in /etc/profile if
> > someone would rather it done after login.
>
> There should be an ANSI escape sequence for resetting the scroll region.
> Just send that to the console.

Yup there is. It's Esc [r , however this also returns the cursor to the top of 
the screen. You can use Esc [s & Esc [u to save and restore the current 
cursor position, so it's just a matter of putting them around it thus:
 Esc [s Esc [r Esc [u

Or with echo (in a bash script - \\'s to escape it from the shell):
 echo -ne \\033[s\\033[r\\033[u

Now there is a problem with this solution: This leaves the logo (and any 
boot-time drawn graphics in the unscrollable region) on the screen. When text 
scrolls up the screen, these graphics do not scroll, and are only removed 
when a character overwrites the graphics position on the screen. If you have 
a number of graphics on the screen (or a machine with a number of processors, 
and therefore a number of tux logos), you'll find that you end up with 
spurious graphical artifacts left on the display where the text hasn't 
directly overwritten the image.

Now you'd think that you could easily just wipe (n) lines off the screen, 
probably using ansi escape sequences. Well it sort of works, but then you 
need to know how big the logo is, how big the font is (as you're working with 
an ascii to graphical representation), and just how much of the screen to 
wipe, to get it right for all the various fbcon display arrangements. While 
the info might be available to userspace to figure this out, it stops being 
simple.

Probably could just talk to the fb driver directly (from the shell) and wipe 
that section of screen. Fun fun fun... Hrm.. Time to look into it.

Of course, you could just clear the screen.....

Note: Fixing this in a binary is pretty much a no-no. How many dists will want 
to add another binary to their systems, or patch something like getty simply 
to fix a display artifact? I'm guessing pretty close to the 0 mark.

--
 Stuart Young - sgy-lkml@amc.com.au is specifically for LKML and related email



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
