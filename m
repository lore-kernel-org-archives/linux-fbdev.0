From: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: Fbdev 2.5.49 BK fixes.
Date: Wed, 27 Nov 2002 12:04:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <3DE4A6CF.F62CFF41@aitel.hist.no>
References: <Pine.LNX.4.44.0211262306070.30451-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

James Simmons wrote:

> Perfect. I found the problem and I'm about to commit to BK. I posted the
> latest patch against 2.5.49 at
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

I tried this patch, but it crashed during boot.

I have a 
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
1X/2X (rev 5c)

and use this in lilo.conf:
image=/boot/2.5.49fb
        label=2.5.49fb
        append="video=atyfb:1280x1024-16@85"

This got me a 160x64 framebuffer with yellow text on
blue background.  Nice, but only got about 10 lines before
the kernel hung. The disk light got stuck on and there were
no response to things like sysrq.  
The few lines displayed was about the fb, drm, and finally
the 3com network adapter.  Then nothing more.

2.5.49 without this patch works.  I use devfs & preempt,
the machine is UP and I use gcc-2.95.4 for compiling.

Helge Hafting
