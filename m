From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] Type confusion in fbcon
Date: Fri, 20 Dec 2002 18:10:17 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0212201808070.6471-100000@phoenix.infradead.org>
References: <20021219231415.A25145@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021219231415.A25145@flint.arm.linux.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net


> I'm in the midst of porting sa1100fb over to the new fb API, and I stumbled
> across an apparant confusion over the type of fb_info->pseudo_palette.
> 
> Some code appears to think its an unsigned long, others think its u32.
> This doesn't make much difference when sizeof(unsigned long) == sizeof(u32)
> but this isn't always the case (eg, 64-bit architectures).

It show be u32 instead of unsinged long in color_imageblit. Thanks. Fixed.
 
> I'll get back to bashing the sa1100fb driver to work out why fbcon is
> producing a _completely_ blank display, despite characters being written
> to it.

Did you figure out what was wrong?
