From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [Linux-fbdev-devel] Re: rotation.
Date: 08 Jan 2003 12:25:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <yw1xu1gj51ep.fsf@tiptop.e.kth.se>
References: <Pine.LNX.4.44.0301072240530.17129-100000@phoenix.infradead.org>
	<Pine.GSO.4.21.0301081120540.21171-100000@vervain.sonytel.be>
	<20030108104817.GA10165@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: Sven Luther's message of "Wed, 8 Jan 2003 11:48:17 +0100"
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Sven Luther <luther@dpt-info.u-strasbg.fr> writes:

> > > I'm about to implement rotation which is needed for devices like =
the ipaq.=20
> > > The question is do we flip the xres and yres values depending on =
the=20
> > > rotation or do we just alter the data that will be drawn to make =
the=20
> > > screen appear to rotate. How does hardware rotate view the x and =
y axis?
> > > Are they rotated or does just the data get rotated?=20
> >=20
> > Where are you going to implement the rotation? At the fbcon or fbde=
v level?
> >=20
> > Fbcon has the advantage that it'll work for all frame buffer device=
s.
>=20
> But you could also provide driver hooks for the chips which have such=
 a
> rotation feature included (don't know if such exist, but i suppose th=
ey
> do, or may in the future).

I heard of someone have problems with the display getting rotated in
Windows.  I don't know what chip it was.

--=20
M=E5ns Rullg=E5rd
mru@users.sf.net
