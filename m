From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: radeonfb on pegasos powerpc motherboard and
 X endianess problem
Date: Fri, 6 Jun 2003 07:58:54 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0306060757230.864-100000@vervain.sonytel.be>
References: <20030605081925.GA14714@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19OAGo-0002Em-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 05 Jun 2003 23:00:11 -0700
In-Reply-To: <20030605081925.GA14714@iliana>
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
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 5 Jun 2003, Sven Luther wrote:
> On Thu, Jun 05, 2003 at 09:59:47AM +0200, Benjamin Herrenschmidt wrote:
> > On Wed, 2003-06-04 at 16:54, Sven Luther wrote:
> > > So, since this is a pegasos, based on the pop specification, which in
> > > turn are related to the chrp ones, and i was told that most chrp
> > > motherboard did endianess inversion in the northbridge or something
> > > such, and i believe that the pegasos doesn't do so, is it possible that
> > > this is the cause, and that XFree86 know how to program the graphic card
> > > to do endianess conversion, and fbdev knows not, or maybe that the
> > > XFree86 radeon driver doesn't know how to act exactly and accidentally
> > > reverts the endianess conversion or something such.
> > > 
> > > Using the fbdev driver in xfree86, i get a seemingly working X, but the
> > > background X image is yellowish and the mode is not set correctly it is
> > > correct, but the image is a bit smaller than the screen, and centered or
> > > moved to the right.
> > > 
> > > Does someone know with more exactitude what the situation is exactly
> > > with regard the kernel and endianess conversion with the different
> > > powerpc subarches.
> > 
> > Endianness shouldn't be related to the subarch at all
> 
> Ah, so it is not true that one chrp, the northbridge did the endianess
> conversion transparently ?

No, PCI is little endian. And fortunately the VLSI Golden Gate II in my
Longtrail doesn't try to outsmart the user, unlike some PCI host bridges in
some MIPS SoCs...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
