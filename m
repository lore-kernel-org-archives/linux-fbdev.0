From: DervishD <lkml@dervishd.net>
Subject: Re: tdfx framebuffer garbles display in 2.6.19.5
Date: Mon, 26 Feb 2007 21:32:23 +0100
Message-ID: <20070226203223.GA161@DervishD>
References: <20070226144744.GA3615@DervishD> <1172503471.20842.14.camel@daplas> <20070226171334.GB13496@DervishD> <1172510654.7101.11.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161015AbXBZUbA@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1172510654.7101.11.camel@daplas>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    Hi Antonino :)

 * Antonino A. Daplas <adaplas@gmail.com> dixit:
> On Mon, 2007-02-26 at 18:13 +0100, DervishD wrote:
> > > Try fbset -a -vyres 600 first and let us know of the result.
> >=20
> > After doing this, I no longer can garble the display (before, just =
a
> > "ls -lR /" was enough to do it, in fact, any big output garbled the
> > display). The only problem with this solution is that the scroll
> > speed has decreased a bit. In fact, the scroll speed is affected by
> > the vyres parameter a lot! The highter the vyres, the faster the
> > scroll, and I cannot reproduce the problem anymore after changing i=
t
> > once!
>=20
> Display panning is what makes scrolling fast which is the default
> scroll method if vyres > yres.  Unfortunately, tdfxfb occasionally
> have problems with this method, the higher the vyres, the greater the
> likelihood of screen corruption.

    Then I'll try with 4096 and will diminish the number until the
display is stable.

> That's why tdfxb limits the vyres to a maximum of 4096. As to why the
> problem disappeared just by changing this parameter, that I too don't
> know.

    Probably setting it back to 4096 will make the problem reappear.
Right now I cannot test, but I'll make some experiments.

    Thanks a lot!

    Ra=FAl N=FA=F1ez de Arenas Coronado

--=20
Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!
