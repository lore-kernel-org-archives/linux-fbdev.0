From: Pavel Machek <pavel@suse.cz>
Subject: Re: [Linux-fbdev-devel] [PATCH] Framebuffer: 2nd try: client notification mecanism & PM
Date: Thu, 7 Aug 2003 22:29:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030807202908.GA413@elf.ucw.cz>
References: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org> <1060249101.1077.67.camel@gaston> <20030807100309.GB166@elf.ucw.cz> <1060267031.722.3.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1060267031.722.3.camel@gaston>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@suse.cz>, James Simmons <jsimmons@infradead.org>, linux-kernel mailing list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Pavel Machek <pavel@ucw.cz>

Hi!

> > I believe solution to this is simple: always switch to kernel-owned
> > console during suspend. (swsusp does it, there's patch for S3 to do
> > the same). That way, Xfree (or qtopia or whoever) should clean up
> > after themselves and leave the console to the kernel. (See
> > kernel/power/console.c)
> 
> I tried using it on pmac, but it causes hell with XFree. I'm not sure
> what's up yet, I suspect it may be XFree still doing things after
> calling the RELDISP ioctl but I'm not completely sure yet.

Sounds like XFree bug to me ;-).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
