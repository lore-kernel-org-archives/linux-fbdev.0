From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: radeonfb on pegasos powerpc motherboard and X endianess problem
Date: Thu, 5 Jun 2003 13:58:21 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030605115821.GA17301@iliana>
References: <20030604145423.GA22876@iliana> <1054799986.701.20.camel@gaston> <20030605081925.GA14714@iliana> <1054813350.701.38.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp6.wanadoo.fr ([193.252.22.28] helo=mwinf0301.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19NtO2-0004an-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 05 Jun 2003 04:58:30 -0700
Content-Disposition: inline
In-Reply-To: <1054813350.701.38.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Jun 05, 2003 at 01:42:30PM +0200, Benjamin Herrenschmidt wrote:
> On Thu, 2003-06-05 at 10:19, Sven Luther wrote:
>=20
> > Err, is that the same devel tree as the one in linuxppc_2_4_devel ?
>=20
> No, it's linuxppc_2_4_benh bk, though you can use rsync to extract
> just radeonfb from rsync.penguinppc.org::benh-devel.

Mmm, i think i am just a bit lost with all the ppc kernel trees ...
Which one should i work on.


> > And no, i cannot really try it out, i need to port the pop+pegasos
> > patches first.
> >=20
> > BTW, i have some questions about this :
> >=20
> >   1) i think the hackyiness nature of it was because they simply #if 0
> >   ed out code that didn't fit them, so doing proper #if CONFIG_PEGASOS
> >   should clean this out, or was there also other kind of hackiness.
>=20
> =CC don't have it all in mind now, send me your patches when you are
> done and I'll tell you more.

Ok.

> >   2) head.S has some code which i guess is for early serial logging or
> >   something such. I guess such a thing can never be part of the official
> >   tree, right ?
>=20
> That depends... It can be done cleanly without hacking head.S I beleive,
> but I need to look at the code to tell you exactly

Mmm, anyway, once it work well, it is not needed that much anymore. I
will look into this once i have booted a more recent tree, and start
cleaning up patches.

> >   3) arch/ppc/platforms/chrp_setup.c got patched about io_block_mapping,
> >   but this doesn't seem to exist anymore in the current
> >   linuxppc_2_4_devel tree. Whatever happened to it, and what replaces i=
t ?
>=20
> You probably don't need it. Just ioremap what need to be ioremap'ed and
> avoid any hard coded virtual addresses and things should be just fine.

Ok, will do that.

> > > >   2) when running X with the UseFBDev option the colors are bad, i =
guess
> > > >   it is an endianess problem. (with and without accel)
> > >=20
> > > What radeon card is this ?
> >=20
> > Radeon 9000 non-pro (and thus fanless).
> >=20
> > > >   3) When running X without the UseFBDev option, the colors are goo=
d,
> > > >   but i get garbage when i return to the console. Not exactly garba=
ge,
> > > >   at first it is ok, but when i enter a line or somehow pan the scr=
een,
> > > >   the corruption start. Doing a vt switch and back redraws a clean
> > > >   screen.
> > >=20
> > > Known problem. This is actually a bit nasty. X doesn't fully restore =
the
> > > engine state (and it's in fact quite difficult to know in which state
> > > it should restore it) and there's no hook in the fbdev layer for
> > > restoring things like that when switching from KD_GRAPHICS back to
> > > KD_TEXT. I'm thinking about adding such a hook in 2.5. Usually, a VT
> > > switch will trigger a restore of the engine state, at least it will
> > > with my version of the driver.
> >=20
> > Mmm, so is this a problem in the X server or in the fbdev driver ? I
> > understand that you will fix this in the fbdev since you have a more
> > difficult time doing it in the X driver, but this does mean that the X
> > driver will do a partial save/restore, and that fbdev will then do a
> > full save/restore ? Seems overkill to me. We can either fix it in the
> > fbdev driver (which will know which registers the fbdev needs to backup)
> > or in the X driver (which will know about which register x needs to
> > backup).
>=20
> Not exactly. I'm not sure X can restore the engine state exactly
> (maybe it can, but imho, it's a bit overkill). I tend to think that
> the fbdev shall do it as it's very much easier. On one side, X would
> have to backup & restore an insane amount of registers, on the other
> side, fbdev can just re-init the engine to the state it wants in a few
> dozen lines of code.

I don't know about the radeon driver exactly but the glint driver i did
work on did a mode setup when comming from the VT switch, after having
saved the registers it touches for the consoles benefit. It then
proceeded to reinitialize the accel pipeline, complete with a sync and
all. I guess newer hardware have easier way to do this, and this doesn't
speak about the DRI case, but probably all the X driver do it such. When
switching back, they restore the registers they have touched, more
probably only the mode setting registers, and don't care about the accel
regs, since text mode don't touch them.

> So my idea was to fix the fbdev interface so that fbdev's in general
> have a hook when a console switch from KD_GRAPHICS to KD_TEXT (that
> is basically when fbcon gets back control) so things can be reset
> properly. =20

Yep.

> > Maybe it would be nice if the fbdev driver could save/restore the fbdev
> > used registers, and tell the X driver by a information hook that it did
> > do the saving, and then the X driver would not need to save/restore the
> > registers when UseFBDev was used.
>=20
> X already save/restore things related to mode setting. The accel engine
> is another problem (and not related to use of UseFBDev or not, the
> problem is the same in both cases).

Not really, because when the card is in vga text mode, it couldn't care
less about accel engine, right ?

> I don't think any of such 'hooks' in the fbdev<->X interface will be
> ever accepted by X folks like Marc Aurele ;) (He never allowed fbdev
> support to be added to the mach64 driver for example)

Well, There are fbdev specific Enter/Leave VT functions, which could be
different, but i also understand what you mean. Not all developpers
think like that though, and David even told me he was not against fbdev.

And then, there will be chance to change things for 5.0, if we have
specific needs.

> > Ah, so it is not true that one chrp, the northbridge did the endianess
> > conversion transparently ?
>=20
> No. There are strict rules on how endianess has to be dealt between=20
> a BE CPU and the PCI bus, and afaik, all PPCs do it properly.

Ok, so it must be another kind of problems, but then, my matrox board,
which Geert (or someone else) said did run on his chrp board, did not
work well for me.

Thanks,

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
