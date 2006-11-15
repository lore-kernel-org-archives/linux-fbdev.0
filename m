From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005 with radeonfb enabled
Date: Wed, 15 Nov 2006 11:09:05 +0100
Message-ID: <200611151109.06956.rjw@sisk.pl>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	<200611150154.39499.chrmhoffmann@gmail.com>
	<1163555308.5940.177.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GkHkS-0001YR-Ol for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Nov 2006 02:12:05 -0800
Received: from ogre.sisk.pl ([217.79.144.158])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GkHkR-0002Gn-UM
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Nov 2006 02:12:04 -0800
In-Reply-To: <1163555308.5940.177.camel@localhost.localdomain>
Content-Disposition: inline
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>, LKML <linux-kernel@vger.kernel.org>, Solomon Peachy <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>

On Wednesday, 15 November 2006 02:48, Benjamin Herrenschmidt wrote:
> On Wed, 2006-11-15 at 01:54 +0100, Christian Hoffmann wrote:
> > On Tuesday 14 November 2006 23:07, Benjamin Herrenschmidt wrote:
> > > > I tried that patch, but the last message I see over netconsole (using
> > > > tg3) is: Suspending console(s)
> > > > and then nothing. Nothing on resume at all :(
> > > >
> > > > Adding some printks in the radeonfb_pci_suspend and radeonfb_pci_resume
> > > > (radeon_pm.c) didn't help: I don't see them. But I am not a kernel
> > > > programmer at all, so I might do something wrong or in the wrong place.
> > >
> > > Does it resume if you make radeon_pci_resume() a nop ?
> > >
> > > Of course, the fbdev will not come back, but will the machine overall
> > > resume ?
> > >
> > > Ben.
> > Yes, if i make radeon_pci_resume a nop, the machine resumes if i do a return 0 
> > immediately.
> > I think I tracked it down to the call to acquire_console_sem() as the 
> > following code makes the machine hang again:
> > 
> > int radeonfb_pci_resume(struct pci_dev *pdev)
> > {
> >         struct fb_info *info = pci_get_drvdata(pdev);
> >         struct radeonfb_info *rinfo = info->par;
> >         int rc = 0;
> >         if (pdev->dev.power.power_state.event == PM_EVENT_ON)
> >                 return 0;
> >         if (rinfo->no_schedule) {
> >         /*      if (try_acquire_console_sem())*/
> >                         return 0;
> >         } else
> >                 acquire_console_sem();
> > 
> >         return 0;
> > ...
> 
> Well, if you acquire the console sem you need to release it too :-)

Or the console semaphore is acquired too many times.

Christian, could you please add release_console_sem() before 'return 0'
and see if that makes the code work again?  If not, could you add a printk()
in kernel/printk.c/acquire_console_sem() to see how many times it is called?

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
