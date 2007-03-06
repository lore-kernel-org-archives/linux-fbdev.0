From: DervishD <lkml@dervishd.net>
Subject: Re: tdfx framebuffer garbles display in 2.6.19.5
Date: Tue, 6 Mar 2007 12:17:03 +0100
Message-ID: <20070306111703.GD25349@DervishD>
References: <20070226144744.GA3615@DervishD> <1172503471.20842.14.camel@daplas> <20070226171334.GB13496@DervishD> <1172510654.7101.11.camel@daplas> <20070226203223.GA161@DervishD> <1172617755.13422.0.camel@daplas> <20070301160139.GA102@DervishD> <1173144817.7219.1.camel@daplas> <20070306062528.GF20292@DervishD> <1173164006.6285.8.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964944AbXCFLPq@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1173164006.6285.8.camel@daplas>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    Hi Antonino :)

 * Antonino A. Daplas <adaplas@gmail.com> dixit:
> On Tue, 2007-03-06 at 07:25 +0100, DervishD wrote:
> >  * Antonino A. Daplas <adaplas@gmail.com> dixit:
> > > On Thu, 2007-03-01 at 17:01 +0100, DervishD wrote:
> > > >  * Antonino A. Daplas <adaplas@gmail.com> dixit:
> > > > > Can you try this patch?  It might help with the screen
> > > > > corruption.
> > > >=20
> > > >     With the patch, the scroll slows to a crawl and the system =
is
> > > >     unusable. The time to scroll 30 lines is about a minute or =
so
> > > >     (probably more, I just measured for a while).
> > > >=20
> > > >     If you want me to test other patches, just tell :)
> > >=20
> > > Can you change the mdelay to udelay and use higher/lower delay va=
lues
> > > to see if there's any improvement?
> >=20
> >     Yes, as soon as I can build a new kernel and reboot. Any sugges=
ted
> > value?
>=20
> You can start with 5 and increment by 5.  So you need not reboot each
> time, compile tdfxfb as a module, and set CONFIG_HW_CONSOLE_BINDING=3D=
y
> (under drivers->char).

    I've done that for testing, but I haven't build that kernel yet (no=
t
spare time by now).

> Make sure you have vbetool, and use the attached script.

    I don't have vbetool, but I'll get it.
=20
> The script assumes vbetool is in /usr/sbin, if not just edit. Also,
> unbinding will only work if X (or any graphics app, for that matter) =
is
> not loaded.

    No problem, it will be off while I test. I'll try to make the tests
probably this friday or the weekend, as soon as I can.

    Thanks a lot for your interest :)

    Ra=FAl N=FA=F1ez de Arenas Coronado

--=20
Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!
