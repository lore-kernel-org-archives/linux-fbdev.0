From: James Simmons <jsimmons@infradead.org>
Subject: Re: Fbdev 2.5.49 BK fixes.
Date: Wed, 27 Nov 2002 23:18:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0211272254440.30951-100000@phoenix.infradead.org>
References: <3DE50A1D.856A8706@aitel.hist.no>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <3DE50A1D.856A8706@aitel.hist.no>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


> No.  The machine froze solid. No oops, no sysrq.
> The reset button worked.

VESA fbdev did this to me. I have no trouble with neofb. Strange???
I will track it down tonight.

> > Hm. Are you using a PPC or ix86 box? I will test this tonight.
> i386.  Specifically, a pentium II, compiled for pentium II.

Hm. I have that same card and a similar machine.
 
> Perhaps. It didn't look like it ended at the bottom of the
> screen, but then it might have been panning at the wrong moment.

I have a MDA monitor and card. So I can setup mdacon and turn on 
debugging in fbcon and trace threw it. 
 
> > > 2.5.49 without this patch works.  I use devfs & preempt,
> > > the machine is UP and I use gcc-2.95.4 for compiling.
> 
> Helge Hafting
> 
