From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] matroxfb update to new API
Date: Wed, 28 May 2003 10:07:01 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0305281005240.10948-100000@vervain.sonytel.be>
References: <2BC238B14C4@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19KvzP-0001So-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 May 2003 01:08:52 -0700
In-Reply-To: <2BC238B14C4@vcnet.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: James Simmons <jsimmons@infradead.org>, Nicolas Souchu <nsouch@free.fr>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 27 May 2003, Petr Vandrovec wrote:
> On 27 May 03 at 21:53, James Simmons wrote:
> > > implements clear_margins as black color and not current background 
> > > color.
> > 
> > It would look bad if the margin where a different color from the screen 
> > when it was cleared.
> 
> Nope. Try running midnight commander. You'll end with cyan (or red or..
> just random, depending on what was mc doing when scrolling happened) 
> line at the right and bottom of screen. Do not forget that rectangle around 
> the picture is always black (even on DFPs there is about 1mm margin between 
> first pixel and edge), so it seems natural to me that margin should be 
> always black. Besides that I received two complaints in 16hrs after I
> switched matroxfb from driver's black clear margin to the generic 
> implementation using background color.

The implementation using the background color is due to the SPARC guys. Suns
boot with a black on white console, and the border is white. Personally I don't
care making it black.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
