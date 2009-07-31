From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch] fbcon: don't use vc_resize() on initialization
Date: Fri, 31 Jul 2009 10:09:15 +0100
Message-ID: <1249031355.29967.1.camel@pc1117.cambridge.arm.com>
References: <1248859884.2305.7.camel@pc1117.cambridge.arm.com>
	 <20090729103903.GA2175@cmpxchg.org>
	 <1248865456.2305.12.camel@pc1117.cambridge.arm.com>
	 <20090729172123.GA14192@cmpxchg.org>
	 <20090730161149.657e8e9a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751830AbZGaJJx@vger.kernel.org>
In-Reply-To: <20090730161149.657e8e9a.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, penberg@cs.helsinki.fi, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Thu, 2009-07-30 at 16:11 -0700, Andrew Morton wrote:
> On Wed, 29 Jul 2009 19:21:23 +0200
> Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > Catalin and kmemleak spotted a leak of a VC screen buffer in
> > vc_allocate() due to the following chain of events:
> > 
> > 	vc_allocate()
> > 	  visual_init(init=1)
> > 	    vc->vc_sw->con_init(init=1)
> >               fbcon_init()
> > 	        vc_resize()
> > 	          vc->screen_buf = kmalloc()
> > 	  vc->screen_buf = kmalloc()
> > 
> > The common way for the VC drivers is to set the screen dimension
> > parameters manually in the init case and only call vc_resize() for
> > !init - which allocates a screen buffer according to the new
> > dimensions.
> > 
> > fbcon instead would do vc_resize() unconditionally and afterwards set
> > the dimensions manually (again) for !init - i.e. completely upside
> > down.  The vc_resize() allocated buffer would then get lost by
> > vc_allocate() allocating a fresh one.
> > 
> > Use vc_resize() only for actual resizing to close the leak.
> > 
> > Set the dimensions manually only in initialization mode to remove the
> > redundant setting in resize mode.
> > 
> > The kmemleak trace from Catalin:
> > 
> > unreferenced object 0xde158000 (size 12288):
> 
> That's a big leak!
> 
> What sequence of user actions would cause it to occur?

In my case, I think anything that causes a tty_open() call with a
framebuffer console. I get a leak when logging in on the console and
another when starting the X server.

-- 
Catalin
