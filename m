From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Framebuffers and VC setup (via fbcon.c)
Date: Thu, 11 Mar 2004 09:46:21 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0403110944430.14618@waterleaf.sonytel.be>
References: <20040309143950.GS17857@lug-owl.de>
 <Pine.LNX.4.44.0403101806460.24760-100000@phoenix.infradead.org>
 <20040310220222.GG17857@lug-owl.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1M7F-0002NA-7A
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 01:04:33 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1Lpi-00077n-2l
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 00:46:26 -0800
In-Reply-To: <20040310220222.GG17857@lug-owl.de>
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
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 10 Mar 2004, Jan-Benedict Glaw wrote:
> On Wed, 2004-03-10 18:15:57 +0000, James Simmons <jsimmons@infradead.org>
> wrote in message <Pine.LNX.4.44.0403101806460.24760-100000@phoenix.infradead.org>:
> > > 	- Despite the fact that (quite late in the boot process)
> > > 	  vc_init() is called (with correct looking arguments), I think
> > > 	  it should have been called quite some time earlier. With other
> > > 	  (PC based) graphic cards, the machine just switches to FB mode
> > > 	  after the FB driver is initialized. All further output is put
> > > 	  there. But not here...
> > >
> > > I haven't yet really understood how FB and console code work together,
> > > so it would be nice to have some hints there :)
>
> In the meantime, another VAX hacker (who initially worked on the 2.4.x
> code base) hinted me: in the arch_setup function, I was missing a
>
> 	conswitchp = &dummy_con;

Yep, you need that, since fb is initialized later than the console (requested
by people with vgacon hardware).

> After adding these, I got a penguin and a login prompt. However, the
> console output (during further boot-up) didn't show up. But I'll get
> there:)

CONFIG_FRAMEBUFFER_CONSOLE=y?

> Thanks for these valuable hints! Oh, just another question: the largest
> of theses framebuffer devices can handle four CRTs. Just need to
> register four framebuffers, then?

Indeed.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
