From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 1/4] ps3fb: thread updates
Date: Thu, 15 Feb 2007 16:59:16 -0800
Message-ID: <20070215165916.de546f0d.akpm@linux-foundation.org>
References: <20070215152301.573853000@sonycom.com>
	<20070215152432.264415000@sonycom.com>
	<20070215175007.GA10817@lst.de>
	<1171575817.5644.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <1171575817.5644.44.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net

On Fri, 16 Feb 2007 08:43:37 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2007-02-15 at 18:50 +0100, Christoph Hellwig wrote:
> > On Thu, Feb 15, 2007 at 04:23:02PM +0100, Geert.Uytterhoeven@sonycom.com wrote:
> > > +	do {
> > > +		try_to_freeze();
> > > +		error = down_interruptible(&ps3fb.sem);
> > > +		if (!error && !atomic_read(&ps3fb.ext_flip))
> > >  			ps3fb_sync(0);	/* single buffer */
> > 
> > this still can deadlock when calling kthread_stop.  You really want
> > to use wake_up_process to kick this thread or use a workqueue.
> 
> kthread_stop does wake_up_process no ? However, that might not get you
> out of interruptible if you don't also have signal_pending...
> 

No, it won't get you out of down_interruptible().  But the code would have
failed trivial testing so perhaps we're missing something.

It seems crufty to use semaphores in this manner.  afaict all we're doing
here is poking a kernel thread and asking it to do a bit of work.  The
standard way of doing this is to go to sleep on a waitqueue_head.

	DEFINE_WAIT(wait);

	while (!kthread_should_stop()) {
		prepare_to_wait(&wq, &wait, TASK_INTERRUPTIBLE);
		if (!atomic_read(&ps3fb.ext_flip))
			schedule();
		finish_wait(&wq, &wait);
		if (!atomic_read(&ps3fb.ext_flip))
			WARN_ON(1);
		else
			ps3fb_sync(0);
	}

and, elsewhere,

	atomic_inc(&ps3fb.ext_flip);
	wake_up_process(my_kernel_therad);
