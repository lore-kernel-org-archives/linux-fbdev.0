From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Comments on fbgen.c and fbcon-accel.c
Date: Tue, 7 May 2002 10:00:22 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0205070953520.14470-100000@vervain.sonytel.be>
References: <1020735317.761.1.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.sonytel.be ([193.74.243.200])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 174ztw-0000PN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 May 2002 01:00:48 -0700
In-Reply-To: <1020735317.761.1.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: Antonino Daplas <adaplas@pol.net>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On 7 May 2002, Antonino Daplas wrote:
> On Tue, 2002-05-07 at 06:24, Michel D=E4nzer wrote:
> > On Sat, 2002-05-04 at 20:01, Antonino Daplas wrote:=20
> > > On Sat, 2002-05-04 at 05:47, James Simmons wrote:
> > > >=20
> > > > > I have a few observations on fbgen and fbcon-accel.
> > >=20
> > > One more thing I've noticed with gen_set_var.  Basically, gen_set_v=
ar
> > > will proceed if it satisfies 2 conditions -- during initialization =
(con
> > > < 0) and if the new var is different from the old var. =20
> > >=20
> > > The above is fine if everything is done in the console.  However,
> > > problems may arise if an app that touches the graphics hardware (ie=
 X)
> > > is launched.  From the point of view of fbcon, the hardware state h=
asn't
> > > changed (compare of newvar with oldvar is false) when display is
> > > switched back to console.  And if that app did not fully restore th=
e
> > > hardware state,  we will be left with a corrupted display.
> > >=20
> > > So, it's probably better if set_par() and pan_display() are allowed=
 to
> > > proceed unconditionally within gen_set_var.  It might take a few mo=
re
> > > milliseconds to switch consoles each time, but we are assured that =
the
> > > hardware state is always coherent with the current var.

Which can be visible, especially if you reprogram the PLL...

> > > What do you think?
> >=20
> > I think this is giving away an advantage. The X server is a bad examp=
le
> > as it can use the framebuffer device fine.

Indeed.

> I was talking of X running with it's own accelerated drivers.  I have
> checked most of the X accelerated drivers, and most will just attempt t=
o
> restore the VGA registers and some when switching to the console.  I
> think this is not just enough, since fb drivers require more than that.=
=20

If you run an application that's not fbdev aware, behavior has always bee=
n
undefined.

> Simiarly, I have also looked at some of the fbdev drivers that are not
> using the gen_* interface (nvidia, ati, matrox), and they will also
> unconditially set the hardware during switches/set_var. The
> fbgen_switch() function also calls fbhw->set_par() within do_set_var().

And set_par() could do some optimizations based on a shadow map of the re=
gister
contents, also to avoid artefacts when switching to a different VC with t=
he
same video timings. Like:

  write_reg(reg, val)
  {
      if (shadow[reg] !=3D val) {
	shadow[reg] =3D val;
	hardware[reg] =3D val;
      }
  }

> > If it's really a problem, maybe we could figure out a way to detect w=
hen
> > it's safe to optimize stuff away or as a last resort make it an optio=
n?
> >=20
> I think if the gen_* interface is to be adopted, it will become a
> problem. Detection is the best solution, but right now X and DRI do not
> know that fb even exist so we can't get X to detect fb unless we
> persuade the X people to do that.  I have tried X detection before by
> checking the previous console number.  If the previous number is not a
> valid console, we can presume that a non-console app used that.  But
> this is not clean and there are too many conditions where this check
> will fail. But then, I really don't understand the underlying console
> interface, so an easier and more effective way may exist that I don't
> know about.

The problem is that most drivers in XFree86 don't _want_ to be fbdev comp=
liant.
The solution is to convince the hardcode anti-fbdev XFree86 guys to use t=
he
fbdev if it's present. Fbdev is part of the kernel API. Circumventing the=
 API
is bad behavior.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something like=
 that.
							    -- Linus Torvalds


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
