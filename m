From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] Sysfs for framebuffer
Date: Tue, 23 Mar 2004 17:58:47 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0403231722330.2419-100000@phoenix.infradead.org>
References: <200403231211.09334.lkml@kcore.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200403231211.09334.lkml@kcore.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kronos <kronos@kronoz.cjb.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>


> > I'll hold off forwarding this patch to Linus until after 2.6.5 is out,
> > so that gives everyone a few days in which to argue the name a bunch and
> > then send me a patch that changes it to the decided apon name (if it is
> > to be changed.)
> 
> - From a users point of view: if there are only to be framebuffer devices listed 
> in this class, why not call it just what it is: "Framebuffer" ? Naming it 
> after something it is only in a broad sense makes no sense to me. I'd be 
> looking in /sys/.../framebuffer instead of /sys/.../graphics or /display.
> 
> Display would be the EDID info of my screen (physical), and graphics... 
> well... I'd half expect something like capture cards to be there...
> 
> Just my 0.02EUR.

   Ug!!!! This is insane. Okay there is a few reason for why I called it 
graphics. The number one thing to straighten out is video vs graphics.
There is a big difference between the two. Video cards are meant to 
decode or/and encode program or transport streams. Usually that is 
mpeg streams. This is what I do for a living. Graphics cards are meant 
to display raster or vector graphics objects. It just today alot of
hardware are both so the terms have become mixed up. On the hardware 
boards we have at work the video and graphics chip are physically 
seperate chips. 
   Now for the issue of display, framebuffer, or graphics. A framebuffer
is a chunk of memory that is used to create what is displayed. Now that
the fbdev layer has moved to a accelerated framework it is possible to use
non framebuffer devices for fbcon. So it doesn't make sense to call it 
that. The name graphics covers the idea best. Especially since fbcon is
meant for "graphical" consoles. As for display. That is just apart of 
that. I plan to create a display directory in /sys/graphics so we can 
get monitor data. 
   So lets leave the patch with name graphics alone.
