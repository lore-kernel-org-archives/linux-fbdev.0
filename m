From: James Simmons <jsimmons@infradead.org>
Subject: Re: 2.5.54: radeonfb almost works
Date: Tue, 7 Jan 2003 21:34:13 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0301072124250.17129-100000@phoenix.infradead.org>
References: <3E14315E.F80B3DFF@aitel.hist.no>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <3E14315E.F80B3DFF@aitel.hist.no>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Just booting with video=radeon gives me a 640x400
> mode.  There's some initial garbage (looks like early boot
> messages converted to graphichs at the wrong resolution)
> on the screen, but that isn't a problem.  The low resolution
> is, though.

640x480 is normal. 

 
> I first tried "fbset 1280x1024-60", which changed
> the resolution, but the console was still a
> small 640x400 thing in the upper left corner of
> the 1280x1024 display.  Not very useful.

Because fbset is only useful for setting /dev/fb. You want to use stty
to set the resolution now. The advantage of this is we don't end up
with a console mode of 80 3/4 columns by 30 1/4 rows. 
Try

stty cols 160 rows 64 

assuming you are using 8x16 fonts.
 
> So I tried booting with video=radeon:1280x1024-32@60
> That gave me a blank screen, the monitor complained
> about "no signal".
> 
> But I logged in blind, and ran fbset 1280x1024-60
> again.  This gave me the console I want.
> 1280x1024 resolution, with 160x64 characters.

Sounds like a monitor timings issue. fbset cheats by taking
times from the /etc/fb.mods file. I'm working on patch 
that was sent to me to deal with this.

> Another problem comes up when running X.  Switching
> from X to some virtual console always gives me the
> "no signal" thing, and I have to type the fbset
> command blind before the console becomes
> visible.  Switching back to X is never a problem.

Same problem again. It is a monitor timings issue. 
We are working on this.
