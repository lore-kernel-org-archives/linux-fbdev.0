From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] two warning fixes
Date: Wed, 18 Jul 2007 18:50:28 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707181848060.27353@woody.linux-foundation.org>
References: <20070718235504.GA9601@havoc.gtf.org> <200707190159.22654.ak@suse.de>
 <469EAABD.4010504@garzik.org> <1184807945.25235.289.camel@localhost.localdomain>
 <20070718184101.1d31db9c.akpm@linux-foundation.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S936366AbXGSBvB@vger.kernel.org>
In-Reply-To: <20070718184101.1d31db9c.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>, adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net



On Wed, 18 Jul 2007, Andrew Morton wrote:
> 
> The only reason why the sysfs creation would fail is a kernel bug,
> so the consequence of your proposal is in fact unfixed kernel bugs.

Well, the thing is, I suspect we have created way more bugs by having that 
stupid "you must check the return value even if you don't care", than by 
just letting it go.

> Now, we can talk about making those sysfs core functions generate warnings
> themselves, and we can talk about generating new wrappers around them which
> generate warnings and which return void, then migrating code over to use
> those.

If the only valid reason to fail is a kernel bug, it damn well should be 
that sysfs function itself that should complain. It's the only thing that 
knows and cares.

> And we can also talk about blithely ignoring these errors and not telling
> anyone about our bugs, but nobody should listen to such scandalous ideas.

Here's a question: do you always check the return value of "printf()"?

Nobody does. It's not worth it. Trying to do so just creates messy code, 
and MORE BUGS.

So yes, I think we should ignore return values when they have absolutely 
zero interest level to us.

		Linus
