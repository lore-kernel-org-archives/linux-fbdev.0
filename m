From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Fix crash in viafb due to 4k stack overflow
Date: Sun, 9 Nov 2008 12:55:22 -0800
Message-ID: <20081109125522.b5266352.akpm@linux-foundation.org>
References: <20081109202537.33ead0a2@neptune.home>
	<20081109113603.d45361ad.akpm@linux-foundation.org>
	<20081109122515.1deb9ec2@infradead.org>
	<20081109213811.4b85adc6@neptune.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756729AbYKIUz4@vger.kernel.org>
In-Reply-To: <20081109213811.4b85adc6@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Arjan van de Ven <arjan@infradead.org>, JosephChan@via.com.tw, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sun, 9 Nov 2008 21:38:11 +0100 Bruno Pr__mont <bonbons@linux-vserver.org> wrote:

> On Sun, 09 November 2008 Arjan van de Ven wrote:
> > On Sun, 9 Nov 2008 Andrew Morton wrote:
> > > On Sun, 9 Nov 2008 Bruno Pr__mont wrote:
> > > 
> > > > The function viafb_cursor() uses 2 stack-variables of CURSOR_SIZE
> > > > bits; CURSOR_SIZE is defined as (8 * 1024). Using up twice 1k on
> > > > stack is too much for 4k-stack (though it works with 8k-stacks).
> > > 
> > > >  
> > > >  	if (viacursor.enable)
> > > 
> > > Is the ->fb_cursor handler allowed to perform GFP_KERNEL memory
> > > allocations?  It's never called from atomic contexts?
> > 
> > if it's allowed to do GFP_KERNEL memory allocations the statement that
> > it works with 8k stacks is a bit overstated... since irq's can come in
> > and take several KB of stack as well ;)
> I don't know if it can be called from atomic contexts or not :(
> 
> 
> In addition I get panics some time after start-up which I'm not sure
> what to associate them with (apparently unrelated)
> It could be some stack overflow by calling fbset (I will to more testing
> in order to find out)
> 
> First attempt: calling fbset via ssh:
> 
> [ 1806.952151] BUG: unable to handle kernel NULL pointer dereference at 00000123
> [ 1806.952601] IP: [<c03d2737>] icmpv6_send+0x387/0x580
> 
> ...
>
> Second attempt, delayed after calling fbset from console:
> 
> [  217.260426] BUG: unable to handle kernel NULL pointer dereference at 000000c7
> [  217.260915] IP: [<c0380b46>] rt_worker_func+0xb6/0x160

gack.  Your kernel was destroyed.

Stack overflow might well explain this.  Does it work OK with 8k stacks?

scripts/checkstack.pl should help find the problems.
