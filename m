From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] backlight: do not power off backlight when unregistering
Date: Tue, 21 Nov 2006 01:01:46 -0200
Message-ID: <20061121030146.GA31304@khazad-dum.debian.net>
References: <20061105225429.GE14295@khazad-dum.debian.net> <1162773394.5473.18.camel@localhost.localdomain> <20061110000829.GA9021@khazad-dum.debian.net> <Pine.LNX.4.64.0611201928310.17639@pentafluge.infradead.org>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611201928310.17639@pentafluge.infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Richard Purdie <rpurdie@rpsys.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, Lennart Poettering <mzxreary@0pointer.de>, Andriy Skulysh <askulysh@image.kiev.ua>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Antonino Daplas <adaplas@pol.net>, Holger Macht <hmacht@suse.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 20 Nov 2006, James Simmons wrote:
> > The following in-tree (latest linux-2.6 git tree) drivers are desktop/laptop
> > devices and likely do not want the "dim and power off backlight on
> > backlight_device_unregister" behavior:
> > 
> > drivers/video/aty/*
> > drivers/video/riva/fbdev.c
> > drivers/video/nvidia/nv_backlight.c
> > drivers/misc/msi-laptop.c
> 
> ...
>  
> > I have CC'ed the relevant people (please forgive me any ommissions) for the
> > drivers listed above, so they can chime in if their driver should retain the
> > "dim and power off backlight on backlight_device_unregister" behaviour.
> 
> Hm. In the case of some drivers the hardware state on x86 is set back to 
> text mode in some cases. So do we in that case dim the backlight?

I would very much *hate* that happening on any x86 box of mine.  I won't
presume I understand enough of the usage pattern on weird devices, and it
would make some sense to power off the display if you are removing the
*only* way to talk to the video device (but I still think this is naively
assuming the local admin don't want to just leave the display as-is).

But as you said yourself, in regular desktop/laptops (at least x86 ones)
textmode is there, and works just fine, so killing the display on module
removal is wrong IMO.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
