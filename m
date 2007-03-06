From: DervishD <lkml@dervishd.net>
Subject: Re: tdfx framebuffer garbles display in 2.6.19.5
Date: Tue, 6 Mar 2007 07:25:28 +0100
Message-ID: <20070306062528.GF20292@DervishD>
References: <20070226144744.GA3615@DervishD> <1172503471.20842.14.camel@daplas> <20070226171334.GB13496@DervishD> <1172510654.7101.11.camel@daplas> <20070226203223.GA161@DervishD> <1172617755.13422.0.camel@daplas> <20070301160139.GA102@DervishD> <1173144817.7219.1.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933966AbXCFGYL@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1173144817.7219.1.camel@daplas>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    Hi Antonino :)

 * Antonino A. Daplas <adaplas@gmail.com> dixit:
> On Thu, 2007-03-01 at 17:01 +0100, DervishD wrote:
> >  * Antonino A. Daplas <adaplas@gmail.com> dixit:
> > > Can you try this patch?  It might help with the screen
> > > corruption.
> >=20
> >     With the patch, the scroll slows to a crawl and the system is
> >     unusable. The time to scroll 30 lines is about a minute or so
> >     (probably more, I just measured for a while).
> >=20
> >     If you want me to test other patches, just tell :)
>=20
> Can you change the mdelay to udelay and use higher/lower delay values
> to see if there's any improvement?

    Yes, as soon as I can build a new kernel and reboot. Any suggested
value?

    Ra=FAl N=FA=F1ez de Arenas Coronado

--=20
Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!
