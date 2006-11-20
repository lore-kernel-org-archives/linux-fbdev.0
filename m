From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] backlight: do not power off backlight when unregistering
Date: Mon, 20 Nov 2006 19:31:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611201928310.17639@pentafluge.infradead.org>
References: <20061105225429.GE14295@khazad-dum.debian.net>
 <1162773394.5473.18.camel@localhost.localdomain> <20061110000829.GA9021@khazad-dum.debian.net>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20061110000829.GA9021@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Richard Purdie <rpurdie@rpsys.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, Lennart Poettering <mzxreary@0pointer.de>, Andriy Skulysh <askulysh@image.kiev.ua>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Antonino Daplas <adaplas@pol.net>, Holger Macht <hmacht@suse.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> The following in-tree (latest linux-2.6 git tree) drivers are desktop/laptop
> devices and likely do not want the "dim and power off backlight on
> backlight_device_unregister" behavior:
> 
> drivers/video/aty/*
> drivers/video/riva/fbdev.c
> drivers/video/nvidia/nv_backlight.c
> drivers/misc/msi-laptop.c

...
 
> I have CC'ed the relevant people (please forgive me any ommissions) for the
> drivers listed above, so they can chime in if their driver should retain the
> "dim and power off backlight on backlight_device_unregister" behaviour.

Hm. In the case of some drivers the hardware state on x86 is set back to 
text mode in some cases. So do we in that case dim the backlight?

