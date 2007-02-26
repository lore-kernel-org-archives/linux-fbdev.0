From: DervishD <lkml@dervishd.net>
Subject: Re: tdfx framebuffer garbles display in 2.6.19.5
Date: Mon, 26 Feb 2007 18:13:34 +0100
Message-ID: <20070226171334.GB13496@DervishD>
References: <20070226144744.GA3615@DervishD> <1172503471.20842.14.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030344AbXBZRMP@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1172503471.20842.14.camel@daplas>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    Hi Antonino :)

 * Antonino A. Daplas <adaplas@gmail.com> dixit:
> On Mon, 2007-02-26 at 15:47 +0100, DervishD wrote:
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
>=20
> Try fbset -a -vyres 600 first and let us know of the result.

    After doing this, I no longer can garble the display (before, just =
a
"ls -lR /" was enough to do it, in fact, any big output garbled the
display). The only problem with this solution is that the scroll speed
has decreased a bit. In fact, the scroll speed is affected by the vyres
parameter a lot! The highter the vyres, the faster the scroll, and I
cannot reproduce the problem anymore after changing it once!

    I'm really confused :?

    Thanks a lot for the fix :)

    Ra=FAl N=FA=F1ez de Arenas Coronado

--=20
Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!
