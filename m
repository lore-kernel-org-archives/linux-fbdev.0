From: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: Fbdev 2.5.49 BK fixes.
Date: Wed, 27 Nov 2002 19:08:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <3DE50A1D.856A8706@aitel.hist.no>
References: <Pine.LNX.4.44.0211271747510.30951-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> > I tried this patch, but it crashed during boot.
> 
> Any oops info?
No.  The machine froze solid. No oops, no sysrq.
The reset button worked.
> 
> > I have a
> > 01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
> > 1X/2X (rev 5c)
> >
> > and use this in lilo.conf:
> > image=/boot/2.5.49fb
> >         label=2.5.49fb
> >         append="video=atyfb:1280x1024-16@85"
> 
> Hm. Are you using a PPC or ix86 box? I will test this tonight.
i386.  Specifically, a pentium II, compiled for pentium II.

> > This got me a 160x64 framebuffer with yellow text on
> > blue background.  Nice, but only got about 10 lines before
> > the kernel hung. The disk light got stuck on and there were
> > no response to things like sysrq.
> > The few lines displayed was about the fb, drm, and finally
> > the 3com network adapter.  Then nothing more.
> 
> Sounds like panning flipped put.
> 
Perhaps. It didn't look like it ended at the bottom of the
screen, but then it might have been panning at the wrong moment.

> > 2.5.49 without this patch works.  I use devfs & preempt,
> > the machine is UP and I use gcc-2.95.4 for compiling.

Helge Hafting
