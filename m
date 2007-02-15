From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 1/4] ps3fb: thread updates
Date: Fri, 16 Feb 2007 08:43:37 +1100
Message-ID: <1171575817.5644.44.camel@localhost.localdomain>
References: <20070215152301.573853000@sonycom.com>
	<20070215152432.264415000@sonycom.com> <20070215175007.GA10817@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20070215175007.GA10817@lst.de>
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
To: Christoph Hellwig <hch@lst.de>
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

On Thu, 2007-02-15 at 18:50 +0100, Christoph Hellwig wrote:
> On Thu, Feb 15, 2007 at 04:23:02PM +0100, Geert.Uytterhoeven@sonycom.com wrote:
> > +	do {
> > +		try_to_freeze();
> > +		error = down_interruptible(&ps3fb.sem);
> > +		if (!error && !atomic_read(&ps3fb.ext_flip))
> >  			ps3fb_sync(0);	/* single buffer */
> 
> this still can deadlock when calling kthread_stop.  You really want
> to use wake_up_process to kick this thread or use a workqueue.

kthread_stop does wake_up_process no ? However, that might not get you
out of interruptible if you don't also have signal_pending...

Ben.
