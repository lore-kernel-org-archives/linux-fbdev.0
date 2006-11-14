From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005 with radeonfb enabled
Date: Wed, 15 Nov 2006 00:12:56 +0100
Message-ID: <20061114231256.GC2676@elf.ucw.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	<200611142247.55137.chrmhoffmann@gmail.com>
	<20061114225629.GA2676@elf.ucw.cz> <200611142358.00616.rjw@sisk.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gk7T0-0007lN-6U for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 15:13:22 -0800
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=amd.ucw.cz)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gk7Sr-0006tg-JE
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Nov 2006 15:13:22 -0800
Content-Disposition: inline
In-Reply-To: <200611142358.00616.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, LKML <linux-kernel@vger.kernel.org>, Solomon Peachy <pizza@shaftnet.org>


On Tue 2006-11-14 23:57:59, Rafael J. Wysocki wrote:
> On Tuesday, 14 November 2006 23:56, Pavel Machek wrote:
> > Hi!
> > 
> > > > > I tried netconsole, and it somehow works, but when suspending it says in
> > > > > an "infinite" loop:
> > > > >
> > > > > unregister_netdevice: waiting for eth2 to become free. Usage count = 1
> > > >
> > > > Hm.  Is your kernel compiled with CONFIG_DISABLE_CONSOLE_SUSPEND set?
> > > >
> > > > Rafael
> > > 
> > > I tried that patch, but the last message I see over netconsole (using tg3) is:
> > > Suspending console(s)
> > > and then nothing. Nothing on resume at all :(
> > > 
> > > Adding some printks in the radeonfb_pci_suspend and radeonfb_pci_resume 
> > > (radeon_pm.c) didn't help: I don't see them. But I am not a kernel programmer 
> > > at all, so I might do something wrong or in the wrong place.
> > 
> > Linus has crazy "write some info to CMOS" hack... which should be
> > usable here.
> 
> No, it's i386-only.

Ok, so you could debug it on i386 kernel :-). Actually trying if s2ram
works in 32-bit mode _would_ be interesting.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
