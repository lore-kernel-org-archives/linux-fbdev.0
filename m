From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbcon scrolling madness + fbset corruption
Date: Wed, 12 Feb 2003 20:26:10 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0302122024310.31435-100000@phoenix.infradead.org>
References: <20030202195744.C32007@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030202195744.C32007@flint.arm.linux.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Kernel List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> So it looks like something isn't limiting the yoffset in the generic
> console layer; an xoffset of 2392 when the maximum virtual Y is 1632
> is just nonsense.

I'm going to need to do some heavy cleaning in the next few days.

> I also noticed an additional problem with fbcon: if I change the
> resolution using fbset, the change occurs, except I end up with
> corrupted mess on the screen (the reminents of the original display.)
> The shell prompt is nowhere to be seen.
>
> Hitting ^L clears the screen and then the shell prompt is visiable.

The method to use now is stty to change the console mode. It works :-)
fbset is used to change the variable the vt terminals are not familiar 
with such as bpp.
