From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: [PATCH] matroxfb update to new API
Date: Tue, 27 May 2003 23:08:59 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <2BC238B14C4@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19KlhJ-0007oN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 27 May 2003 14:09:29 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Nicolas Souchu <nsouch@free.fr>, linux-fbdev-devel@lists.sourceforge.net

On 27 May 03 at 21:53, James Simmons wrote:
> > What I say... matroxfb driver & fbcon layer which supports fbset,
> 
> The mode changing only worked on a select few cards before. What we need 
> is better DDC support and start working on fbmon.c. The functions are all 
> there to support this stuff.

I'd like to see how you'll resolve my config. One CRTC drives analog
21" EIZO F764-M with no DDC at all, secondary CRTC drives 17" DFP 
1280x1024 from fujitsu, but due to some hardware strangeness both
CRTCs have to use same pixel clocks... (1024x768@100Hz on first head,
1280x1024@60Hz on DFP).
 
> > updates all visible screens, 
> 
> ???

When I switch to secondary head with stripped down matroxfb & your
fbcon, program printing something on first head stops updating screen.
Only after I switch back to the primary head picture updates. It is not
major problem as I usually run 'fbtv -k' on the background head,
but... it should work. There was problem with info->display_fg
not being properly updated when VT is moved from one fb to another
and there is only one VT on the fbdev, but I'm not sure that it is still 
root of the problem.

> > supports text mode, 
> 
> Fbcon is over kill for text hardware mode. The best approach is what the 
> STI driver does. A core set of functions shared between text mode and 
> graphics mode. 

Maybe. For now I have something integrated with kernel's fbdev, so
people will stop complaining... As only thing I need from text mode is
special hardware state, as VMware, svgalib and dosemu will all take over
hardware anyway, maybe I can just implement vga 4bpp instead of text mode -
- hardware state is same, but it will match better with pixel based core.

> > implements clear_margins as black color and not current background 
> > color.
> 
> It would look bad if the margin where a different color from the screen 
> when it was cleared.

Nope. Try running midnight commander. You'll end with cyan (or red or..
just random, depending on what was mc doing when scrolling happened) 
line at the right and bottom of screen. Do not forget that rectangle around 
the picture is always black (even on DFPs there is about 1mm margin between 
first pixel and edge), so it seems natural to me that margin should be 
always black. Besides that I received two complaints in 16hrs after I
switched matroxfb from driver's black clear margin to the generic 
implementation using background color.
                                                Petr Vandrovec
                                                



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
