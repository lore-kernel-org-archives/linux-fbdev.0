From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK FBDEV] A few more updates.
Date: Tue, 25 Mar 2003 20:14:11 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0303252011360.6228-100000@phoenix.infradead.org>
References: <1048623026.10476.17.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1048623026.10476.17.camel@zion.wanadoo.fr>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> > > Well, actually, creating a workqueue would be overhead since
> > > it involves one kernel thread per CPU. After more thinking &
> > > discussion, I beleive you shall rather use keventd existing
> > > workqueue (schedule_work() will do that)
> > 
> > Done. Can you look over this patch and test it. I tested it and it worked 
> > fine.
> 
> I don't have a test config at hand right now. The patch looks better,
> though you didn't remove the spinlock and replace it with some
> "softer" sync. primitives.

I didn't get around to removing the spinlock. That is next on the list.
I just wanted to fix the big problem.  

> Note that if fbcon is ever to be rmmod'ed, you need to properly
> remove the timer and make sure all pending work queues have completed
> (and make sure the timer won't be re-scheduled by one).

Note support for rmmod fbcon is incomplete. The function giveup_console is 
really sad but none one ever imagine that the console system would become 
powerful enough to switch from one driver to another. 
