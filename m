From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005 with radeonfb enabled
Date: Thu, 16 Nov 2006 23:44:40 +0100
Message-ID: <200611162344.41622.rjw@sisk.pl>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	<200611151109.06956.rjw@sisk.pl>
	<200611162317.30880.chrmhoffmann@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gkq1W-0001KL-MX for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Nov 2006 14:47:58 -0800
Received: from ogre.sisk.pl ([217.79.144.158])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gkq1V-0008Nc-WF
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Nov 2006 14:47:58 -0800
In-Reply-To: <200611162317.30880.chrmhoffmann@gmail.com>
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
To: Christian Hoffmann <chrmhoffmann@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, LKML <linux-kernel@vger.kernel.org>, Solomon Peachy <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>

On Thursday, 16 November 2006 23:17, Christian Hoffmann wrote:
> 
> > >
> > > Well, if you acquire the console sem you need to release it too :-)
> >
> > Or the console semaphore is acquired too many times.
> >
> > Christian, could you please add release_console_sem() before 'return 0'
> > and see if that makes the code work again?  If not, could you add a
> > printk() in kernel/printk.c/acquire_console_sem() to see how many times it
> > is called?
> 
> Ok, I did that and the machine resumes OK. Now I have the impression that 
> accessing the rinfo struct here:
> 
> if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
>                 /* Wakeup chip. Check from config space if we were powered off
>                  * (todo: additionally, check CLK_PIN_CNTL too)
>                  */
>                 if ((rinfo->pm_mode & radeon_pm_off) &&
>                         radeon_restore_pci_cfg(rinfo)) {

I think the call to radeon_restore_pci_cfg(rinfo) causes the problem to happen.

>                         if (rinfo->reinit_func != NULL) {
>                                 rinfo->reinit_func(rinfo);
>                                 }
>                         else {
>                                 goto bail;
>                         }
>                 }
>                 /* If we support D2, try to resume... we should check what was 
> our
>                  * state though... (were we really in D2 state ?). Right now, 
> this code
>                  * is only enable on Macs so it's fine.
>                  */
>                 else if (rinfo->pm_mode & radeon_pm_d2){
>                         radeon_set_suspend(rinfo, 0);
>                 }
>                 rinfo->asleep = 0; ////makes it crash
>         } else {
>                 radeon_engine_idle();
>         }
> 
> makes the resume fail. The machine locks up. I started xorg without drm/dri 
> and then it goes a little further and locks up in the next steps:        
> 
> /* Restore display & engine */
> radeon_write_mode (rinfo, &rinfo->state, 1);
> 
> But it starts to get too complicated for me :(

Unfortunately for me too.  Someone who knows the radeonfb code is needed.

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
