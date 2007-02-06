From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] nvidiafb: allow ignoring EDID info
Date: Tue, 6 Feb 2007 20:37:35 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702062034380.9224@pentafluge.infradead.org>
References: <ephv35$4i3$1@sea.gmane.org> <20070128160831.fb51347f.akpm@osdl.org>
 <21d7e9970701281612q56b694edp6efd1a5556dea3fe@mail.gmail.com>
 <20070128162907.370f5476.akpm@osdl.org> <21d7e9970701281639w57edc2efw4ba620d4c1bdcee7@mail.gmail.com>
 <cb7bb73a0701290637q2ce0ff16t28f82d0c0339a2ba@mail.gmail.com>
 <20070130203301.GA15067@dreamland.darkstar.lan> <20070204201713.GA12867@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965396AbXBFUhz@vger.kernel.org>
In-Reply-To: <20070204201713.GA12867@dreamland.darkstar.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca Tettamanti <kronos@people.it>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, linux-kernel@vger.kernel.org


> > > Although solving the problem at the fb layer level is probably the
> > > correct/best way to do it, I am not aware of people having problems
> > > with broken EDIDs and non-nVidia cards. By contrast, workarounds for
> > > nVidia and broken EDIDs is a very common thing to do even on Windows.
> > 
> > Not all drivers have support for reading EDID information, so in many
> > cases it just "works". My old monitor had garbage in the EDID eeprom and
> > I had to pass "ignore_edid" to radeonfb (before I reprogrammed the
> > eeprom that is :P).
> > 
> > > Plus, providing an fb-layer-level solution is way beyond my kernel
> > > programming experience :)
> > 
> > I'll try to code something in the weekend.
> 
> I'm somewhat stuck. fbmon has the library functions to parse and
> optionally fix EDID block, but it lacks the knowledge of the source of
> the data; IOW it's not possible to ignore the EDID coming from a certain
> head, the flag would be global (which may be less that optimal with
> multi-head setups).
> So instead of adding an option I'd use the existing broken EDID db,
> adding another state (say 'unfixable') which causes the data to be
> discarded. Comments?
> 
> Giuseppe, can you send me the EDID block of your monitor?

If you can find post the manufacturer and model number we can place it on 
the backlist in fbmon. Also we should figure out what is wrong and fix it.
