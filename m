From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] Framebuffer: 2nd try: client
 notification mecanism & PM
Date: Thu, 7 Aug 2003 18:23:12 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0308071822270.13973-100000@phoenix.infradead.org>
References: <20030807100309.GB166@elf.ucw.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030807100309.GB166@elf.ucw.cz>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@suse.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel mailing list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Pavel Machek <pavel@ucw.cz>


> I believe solution to this is simple: always switch to kernel-owned
> console during suspend. (swsusp does it, there's patch for S3 to do
> the same). That way, Xfree (or qtopia or whoever) should clean up
> after themselves and leave the console to the kernel. (See
> kernel/power/console.c)

Not very helpful on embedded systems that use the framebuffer without the 
VT console. 
