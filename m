From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Tue, 19 Oct 2004 23:48:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041019214818.GF1142@elf.ucw.cz>
References: <9e47339104101814166bf4cfe5@mail.gmail.com> <41740384.5783.12A07B14@localhost>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269645AbUJSWS5@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <41740384.5783.12A07B14@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Richard Smith <rsmith@bitworks.com>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Hi!

> > Its a sad fact though that we are (x86 anyway) dependant on some
> > amazingly fragile, stupid, usually binary only, legacy bloated, and
> > quite often buggy, 16-bit realmode video init code that should have
> > been put to pasture many years ago. 
> 
> Actually there is nothing wrong with the x86 BIOS from the perspective of 
> functionality and useability (or bloat for that matter). It contains all 
> the functionality we need and armed with something like the x86 emulator 
> we can use it for what we need on any platform.
> 
> Open Firmware may be a 'nicer' solution, but I guarantee that if the 
> vendors started supporting that it would be just a bug ridden as any 16-
> bit real mode BIOS code. For the Video BIOS the code always works for 
> what it is tested for. Some vendors spend more time testing the VBE BIOS 
> side of things fully (if they are smart they have licensed our VBETest 
> tools for this purpose). Unfortunatley some vendors do not test this 
> stuff thoroughly and it has problems. But the same testing issues would 
> exist whether the firmware was written as a 16-bit x86 blob or as an Open 
> Firmware blob.

Actually that 16-bit x86 blob can access any PC hardware, and that's
where the stuff gets hard.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
