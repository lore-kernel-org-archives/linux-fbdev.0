From: James Simmons <jsimmons@infradead.org>
Subject: Re: Fbdev 2.5.49 BK fixes.
Date: Wed, 27 Nov 2002 17:49:28 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0211271747510.30951-100000@phoenix.infradead.org>
References: <3DE4A6CF.F62CFF41@aitel.hist.no>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <3DE4A6CF.F62CFF41@aitel.hist.no>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


> I tried this patch, but it crashed during boot.

Any oops info? 

> I have a 
> 01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
> 1X/2X (rev 5c)
> 
> and use this in lilo.conf:
> image=/boot/2.5.49fb
>         label=2.5.49fb
>         append="video=atyfb:1280x1024-16@85"

Hm. Are you using a PPC or ix86 box? I will test this tonight.
 
> This got me a 160x64 framebuffer with yellow text on
> blue background.  Nice, but only got about 10 lines before
> the kernel hung. The disk light got stuck on and there were
> no response to things like sysrq.  
> The few lines displayed was about the fb, drm, and finally
> the 3com network adapter.  Then nothing more.

Sounds like panning flipped put.
 
> 2.5.49 without this patch works.  I use devfs & preempt,
> the machine is UP and I use gcc-2.95.4 for compiling.
