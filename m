From: DervishD <lkml@dervishd.net>
Subject: Re: tdfx framebuffer garbles display in 2.6.19.5
Date: Mon, 26 Feb 2007 18:04:41 +0100
Message-ID: <20070226170441.GA13496@DervishD>
References: <20070226144744.GA3615@DervishD> <Pine.LNX.4.64.0702261520420.27244@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030346AbXBZRXN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702261520420.27244@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    Hi James :)

 * James Simmons <jsimmons@infradead.org> dixit:
> >     From time to time, the tdfxfb driver from 2.6.19.5 (sorry, I ca=
nnot
> > test in 2.6.20.x because it doesn't compile, the infamous BDF negat=
ive
> > offset problem) garbles the display, leaving only a lot of thin lin=
es,
> > just like sync was lost. The display can be repaired by switching t=
o
> > another console, but this is annoying. This happens with a Voodoo 3
> > 3000, using 800x600x8@100 mode.
> >=20
> >     Anyone has this problem? Can it be solved changing anything?
>=20
> Does not compile? Can you post the compile error. For my setup it doe=
s=20
> compile.=20

    I think I didn't explain it well: the tdfxfb driver compiles, but
the *kernel* doesn't. At link time the linker warns about a negative
offset being used and building stops. The driver itself builds perfectl=
y
as far as I can tell.

    Ra=FAl N=FA=F1ez de Arenas Coronado

--=20
Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!
