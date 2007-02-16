From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 1/4] ps3fb: thread updates
Date: Fri, 16 Feb 2007 16:58:33 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0702161657080.8263@pademelon.sonytel.be>
References: <20070215152301.573853000@sonycom.com>
	<20070215152432.264415000@sonycom.com>
	<20070215175007.GA10817@lst.de>
	<1171575817.5644.44.camel@localhost.localdomain>
	<20070215165916.de546f0d.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HI5UH-0000FP-Ed for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 07:59:05 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HI5UG-0000nh-TK
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Feb 2007 07:59:05 -0800
In-Reply-To: <20070215165916.de546f0d.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net, Christoph Hellwig <hch@lst.de>, linuxppc-dev@ozlabs.org

On Thu, 15 Feb 2007, Andrew Morton wrote:
> On Fri, 16 Feb 2007 08:43:37 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > On Thu, 2007-02-15 at 18:50 +0100, Christoph Hellwig wrote:
> > > On Thu, Feb 15, 2007 at 04:23:02PM +0100, Geert.Uytterhoeven@sonycom.com wrote:
> > > > +	do {
> > > > +		try_to_freeze();
> > > > +		error = down_interruptible(&ps3fb.sem);
> > > > +		if (!error && !atomic_read(&ps3fb.ext_flip))
> > > >  			ps3fb_sync(0);	/* single buffer */
> > > 
> > > this still can deadlock when calling kthread_stop.  You really want
> > > to use wake_up_process to kick this thread or use a workqueue.
> > 
> > kthread_stop does wake_up_process no ? However, that might not get you
> > out of interruptible if you don't also have signal_pending...
> 
> No, it won't get you out of down_interruptible().  But the code would have
> failed trivial testing so perhaps we're missing something.

As modular ps3fb is not yet supported, this trivial testing is not that
trivial...

> It seems crufty to use semaphores in this manner.  afaict all we're doing
> here is poking a kernel thread and asking it to do a bit of work.  The
> standard way of doing this is to go to sleep on a waitqueue_head.
> 
> 	DEFINE_WAIT(wait);
> 
> 	while (!kthread_should_stop()) {
> 		prepare_to_wait(&wq, &wait, TASK_INTERRUPTIBLE);
> 		if (!atomic_read(&ps3fb.ext_flip))
> 			schedule();
> 		finish_wait(&wq, &wait);
> 		if (!atomic_read(&ps3fb.ext_flip))
> 			WARN_ON(1);
> 		else
> 			ps3fb_sync(0);
> 	}
> 
> and, elsewhere,
> 
> 	atomic_inc(&ps3fb.ext_flip);
> 	wake_up_process(my_kernel_therad);

Thanks! We don't wait on ext_flip, though, but I see your point. Updated patch
will follow.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
