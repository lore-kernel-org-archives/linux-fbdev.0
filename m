From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Console & FBDev vs. locking
Date: 28 May 2003 15:02:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1054126978.541.3.camel@gaston>
References: <1054122360.602.197.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1054122360.602.197.camel@gaston>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

On Wed, 2003-05-28 at 13:46, Benjamin Herrenschmidt wrote:

> All printk originated console call should done with the console
> semaphore held. The console-sem is the de-facto locking mecanism for the
> console today, while not fine-grained, it's probably plenty enough for
> what we need in 2.5 and unless previous implementations which ran with
> irqs off, the console drivers can actually block and rely on HW
> interrupts.

Hrm... Of course, this is only true for things like resize/mode change,
etc... (and soon blanking once I'm done with it). The way the console
sem is used is so that normal output originating from printk can
still happen at interrupt time.

BTW. I know some people would prefer not doing so, but I'd like to
eventually disable that 'feature', or at least add a flag to the the
consw driver telling if it supports beeing called at interrupt/spinlock
time or not, and if not, defer operations to process context. ..

Ben.
