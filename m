From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 05/16] viafb: Determine type of 2D engine and store it
 in chip_info
Date: Sun, 18 Apr 2010 11:34:30 -0600
Message-ID: <20100418113430.53760f99@bike.lwn.net>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>
	<1270746946-12467-6-git-send-email-corbet@lwn.net>
	<4BBE9CFC.2020804@gmx.de>
	<20100409141127.42e4e1fa@bike.lwn.net>
	<4BBF8F48.2070902@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BBF8F48.2070902@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

[Getting back to the older stuff...]

On Fri, 09 Apr 2010 22:34:16 +0200
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> >> Just a minor nit:
> >> Could we change the default so that if someone adds support for a new 
> >> IGP (and misses this function) we default to either the newest or 
> >> preferably to none? I've just seen too much poorly maintained code in 
> >> this driver and defaulting to the oldest is hence a bad idea.
> >> Otherwise it's fine.  
> > 
> > That would require making an exhaustive list of older chipset types.
> > It could probably be inferred through inspection of the code, but I
> > worry about making assumptions in this area...  
> 
> Such list already exists. gfx_chip_name = pdi->driver_data in hw.c (and 
> only there) so what is needed is the list viafb_pci_table in viafbdev.c 
> (relatively at the end) of all chips:

I've spent a bit of time looking at this.  What's really needed is a
better way of abstracting the chip types so that we can maybe get rid
of all those switch statements throughout the driver.  For the purposes
of getting this work in, I'm not quite prepared to make that change,
though I could certainly consider doing it in the future.

In the absence of that, the only course of action which makes sense is
to simply fail the initialization if an unknown chip type shows up
there.  That's easy, and I can do it.  But, given that this was a
"minor nit," can we leave it as-is for now?  There's a *lot* of things
to clean up in this driver, I'd like to make it better a step at a time
rather than trying to do the whole thing at once.

Thanks,

jon
