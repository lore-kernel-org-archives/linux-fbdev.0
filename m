From: Helge Hafting <helgehaf@aitel.hist.no>
Subject: 2.5.54: radeonfb almost works
Date: Thu, 02 Jan 2003 13:32:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <3E14315E.F80B3DFF@aitel.hist.no>
References: <Pine.LNX.4.33.0211010937050.6296-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Radeonfb almost works now, but there are some problems
with setting (and resetting) the resolution.

I use a flat screen so anything except 1280x1024 is
hopeless to look at.  So I want that from the start.

Just booting with video=radeon gives me a 640x400
mode.  There's some initial garbage (looks like early boot
messages converted to graphichs at the wrong resolution)
on the screen, but that isn't a problem.  The low resolution
is, though.


I first tried "fbset 1280x1024-60", which changed
the resolution, but the console was still a
small 640x400 thing in the upper left corner of
the 1280x1024 display.  Not very useful.

So I tried booting with video=radeon:1280x1024-32@60
That gave me a blank screen, the monitor complained
about "no signal".

But I logged in blind, and ran fbset 1280x1024-60
again.  This gave me the console I want.
1280x1024 resolution, with 160x64 characters.

I could put fbset in a init script, but that is
fragile if I get some error before that init
script runs. I should really see the
console all the time.

Another problem comes up when running X.  Switching
from X to some virtual console always gives me the
"no signal" thing, and I have to type the fbset
command blind before the console becomes
visible.  Switching back to X is never a problem.

This is a UP machine, P4 processor, using preempt.
I use a radeon 7500 in an AGP slot.

Helge Hafting
