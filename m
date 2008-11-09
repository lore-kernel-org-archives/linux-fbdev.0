From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] Fix crash in viafb due to 4k stack overflow
Date: Sun, 9 Nov 2008 12:25:15 -0800
Message-ID: <20081109122515.1deb9ec2@infradead.org>
References: <20081109202537.33ead0a2@neptune.home>
	<20081109113603.d45361ad.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756575AbYKIUZW@vger.kernel.org>
In-Reply-To: <20081109113603.d45361ad.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>, JosephChan@via.com.tw, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sun, 9 Nov 2008 11:36:03 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 9 Nov 2008 20:25:37 +0100 Bruno Pr__mont
> <bonbons@linux-vserver.org> wrote:
> 
> > The function viafb_cursor() uses 2 stack-variables of CURSOR_SIZE
> > bits; CURSOR_SIZE is defined as (8 * 1024). Using up twice 1k on
> > stack is too much for 4k-stack (though it works with 8k-stacks).
> 
> >  
> >  	if (viacursor.enable)
> 
> Is the ->fb_cursor handler allowed to perform GFP_KERNEL memory
> allocations?  It's never called from atomic contexts?

if it's allowed to do GFP_KERNEL memory allocations the statement that
it works with 8k stacks is a bit overstated... since irq's can come in
and take several KB of stack as well ;)

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
