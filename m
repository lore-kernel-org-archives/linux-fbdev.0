From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: radeonfb on pegasos powerpc motherboard and X endianess problem
Date: Thu, 5 Jun 2003 10:19:25 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030605081925.GA14714@iliana>
References: <20030604145423.GA22876@iliana> <1054799986.701.20.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp5.wanadoo.fr ([193.252.22.27] helo=mwinf0402.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19NpyA-0000jd-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 05 Jun 2003 01:19:34 -0700
Content-Disposition: inline
In-Reply-To: <1054799986.701.20.camel@gaston>
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
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Jun 05, 2003 at 09:59:47AM +0200, Benjamin Herrenschmidt wrote:
> On Wed, 2003-06-04 at 16:54, Sven Luther wrote:
> > Hello,
> > 
> > I finally have a working pegasos motherboard as well as a working kernel
> > with a 1.6 radeonfb. I have also installed Daniel Stone's X 4.3.0
> > debian/sid packages, and notice the following :
> > 
> >   1) radeonfb works fine in 8bpp and 32bpp but depth 15 and 16 only give
> >   me some very dark grey.
> 
> Can you try my devel tree version ?
> 
> (rsync.penguinppc.org::benh-devel)

Err, is that the same devel tree as the one in linuxppc_2_4_devel ?

And no, i cannot really try it out, i need to port the pop+pegasos
patches first.

BTW, i have some questions about this :

  1) i think the hackyiness nature of it was because they simply #if 0
  ed out code that didn't fit them, so doing proper #if CONFIG_PEGASOS
  should clean this out, or was there also other kind of hackiness.

  2) head.S has some code which i guess is for early serial logging or
  something such. I guess such a thing can never be part of the official
  tree, right ?

  3) arch/ppc/platforms/chrp_setup.c got patched about io_block_mapping,
  but this doesn't seem to exist anymore in the current
  linuxppc_2_4_devel tree. Whatever happened to it, and what replaces it ?

  4) drivers/ide/ide-pci.c also is no more to be found in the current
  tree.

> >   2) when running X with the UseFBDev option the colors are bad, i guess
> >   it is an endianess problem. (with and without accel)
> 
> What radeon card is this ?

Radeon 9000 non-pro (and thus fanless).

> >   3) When running X without the UseFBDev option, the colors are good,
> >   but i get garbage when i return to the console. Not exactly garbage,
> >   at first it is ok, but when i enter a line or somehow pan the screen,
> >   the corruption start. Doing a vt switch and back redraws a clean
> >   screen.
> 
> Known problem. This is actually a bit nasty. X doesn't fully restore the
> engine state (and it's in fact quite difficult to know in which state
> it should restore it) and there's no hook in the fbdev layer for
> restoring things like that when switching from KD_GRAPHICS back to
> KD_TEXT. I'm thinking about adding such a hook in 2.5. Usually, a VT
> switch will trigger a restore of the engine state, at least it will
> with my version of the driver.

Mmm, so is this a problem in the X server or in the fbdev driver ? I
understand that you will fix this in the fbdev since you have a more
difficult time doing it in the X driver, but this does mean that the X
driver will do a partial save/restore, and that fbdev will then do a
full save/restore ? Seems overkill to me. We can either fix it in the
fbdev driver (which will know which registers the fbdev needs to backup)
or in the X driver (which will know about which register x needs to
backup).

Maybe it would be nice if the fbdev driver could save/restore the fbdev
used registers, and tell the X driver by a information hook that it did
do the saving, and then the X driver would not need to save/restore the
registers when UseFBDev was used.

> > So, i think something is wrong. The kernel was forked around the
> > 2.4.18-rc4 time in a messy way, i am actually working on bringing the
> > patch in sync with the newer ppc trees. Matroxfb also had problems and
> > Petr told me that it probably was an endianess issue back then. I am
> > using a Radeon 9000 board.
> 
> Ok, there is a problem with older radeonfb's on these regarding
> endianness, newer driver should work.

Ok, i will test again once i have finished the porting of the pegasos
patches.

> > So, since this is a pegasos, based on the pop specification, which in
> > turn are related to the chrp ones, and i was told that most chrp
> > motherboard did endianess inversion in the northbridge or something
> > such, and i believe that the pegasos doesn't do so, is it possible that
> > this is the cause, and that XFree86 know how to program the graphic card
> > to do endianess conversion, and fbdev knows not, or maybe that the
> > XFree86 radeon driver doesn't know how to act exactly and accidentally
> > reverts the endianess conversion or something such.
> > 
> > Using the fbdev driver in xfree86, i get a seemingly working X, but the
> > background X image is yellowish and the mode is not set correctly it is
> > correct, but the image is a bit smaller than the screen, and centered or
> > moved to the right.
> > 
> > Does someone know with more exactitude what the situation is exactly
> > with regard the kernel and endianess conversion with the different
> > powerpc subarches.
> 
> Endianness shouldn't be related to the subarch at all

Ah, so it is not true that one chrp, the northbridge did the endianess
conversion transparently ?

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
