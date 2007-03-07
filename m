From: DervishD <lkml@dervishd.net>
Subject: Re: tdfx framebuffer garbles display in 2.6.19.5
Date: Wed, 7 Mar 2007 11:02:58 +0100
Message-ID: <20070307100258.GA30270@DervishD>
References: <20070226144744.GA3615@DervishD> <1172503471.20842.14.camel@daplas> <20070226171334.GB13496@DervishD> <1172510654.7101.11.camel@daplas> <20070226203223.GA161@DervishD> <1172617755.13422.0.camel@daplas> <20070301160139.GA102@DervishD> <1173144817.7219.1.camel@daplas> <20070306062528.GF20292@DervishD> <1173164006.6285.8.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751605AbXCGKBm@vger.kernel.org>
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
> > > >     If you want me to test other patches, just tell :)
> > >=20
> > > Can you change the mdelay to udelay and use higher/lower delay va=
lues
> > > to see if there's any improvement?

    Regarding the delay: I've discovered a weird thing. When the displa=
y
is garbled, if I insist on outputting more text to the screen, sooner o=
r
later it de-garbles! In fact, once the display has been garbled (not
easy to do, sometimes I can work for hours in a terminal before it gets
garbled, I can't reproduce it always), a continous output makes it
de-garble and garble again, in cycles.

    Looks like an off-by-one error rather than a speed/sync error, am I
completely clueless?

    This happens with vanilla 2.6.19.5, not with the patched one, which
I haven't been able to test yet (sorry...).

    Ra=FAl N=FA=F1ez de Arenas Coronado

--=20
Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!
