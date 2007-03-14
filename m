From: DervishD <lkml@dervishd.net>
Subject: Re: [TESTED] tdfx framebuffer garbles display
	in 2.6.19.5
Date: Wed, 14 Mar 2007 10:06:55 +0100
Message-ID: <20070314090655.GA2466@DervishD>
References: <20070226144744.GA3615@DervishD> <1172503471.20842.14.camel@daplas>
	<20070226171334.GB13496@DervishD> <1172510654.7101.11.camel@daplas>
	<20070226203223.GA161@DervishD> <1172617755.13422.0.camel@daplas>
	<20070301160139.GA102@DervishD> <1173144817.7219.1.camel@daplas>
	<20070306062528.GF20292@DervishD> <1173164006.6285.8.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HRPQR-0001Vh-L4 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Mar 2007 02:05:39 -0700
Received: from smtp01.cdmon.com ([86.109.99.230])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HRPQQ-0003ar-44
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Mar 2007 02:05:39 -0700
Content-Disposition: inline
In-Reply-To: <1173164006.6285.8.camel@daplas>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux-kernel <linux-kernel@vger.kernel.org>

    Hi Antonino :)

    NEW INFORMATION ABOUT THE PROBLEM

 * Antonino A. Daplas <adaplas@gmail.com> dixit:
> On Tue, 2007-03-06 at 07:25 +0100, DervishD wrote:
> > > >     With the patch, the scroll slows to a crawl and the system is
> > > >     unusable. The time to scroll 30 lines is about a minute or so
> > > >     (probably more, I just measured for a while).
> > > > =

> > > >     If you want me to test other patches, just tell :)
> > > =

> > > Can you change the mdelay to udelay and use higher/lower delay values
> > > to see if there's any improvement?
> > =

> >     Yes, as soon as I can build a new kernel and reboot. Any suggested
> > value?
> =

> You can start with 5 and increment by 5.  So you need not reboot each
> time, compile tdfxfb as a module, and set CONFIG_HW_CONSOLE_BINDING=3Dy
> (under drivers->char).

    Until I discovered how to reproduce the bug, I had to reboot for
each test. But I discovered the real problem...

    The garbling doesn't happen, no matter the udelay, until I start X.
Once X is started, even with an udelay(100) (which for me makes the
display untolerably slow) the problem happens.

    This doesn't happen in latest 2.4.x, but I remember that some
characters "dissappeared" from the screen at some 2.4.x when X was
running. That was a known bug in the X driver of this card, so I'm not
sure if the last X.Org driver has this problem or not. Unfortunately, I
cannot test this directly, the most I can do is to test under Ubuntu,
which uses an older 2.6.x kernel.

    If this new discovery doesn't ring any bell for you, I'll make a
test under Ubuntu and after that I'll just wait until I can upgrade X
(which I cannot do now) to latest X.Org (I'm now using 7.0.22).

    Thanks for all your help. I'll keep you informed of any change I
notice, and (although I won't be very fast doing it...) you can count on
me to test any patch you want.

    Ra=FAl N=FA=F1ez de Arenas Coronado

-- =

Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
