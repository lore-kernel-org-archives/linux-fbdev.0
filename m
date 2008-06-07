From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [RESEND] [PATCH] convert sticore.c to PCI ROM API
Date: Sat, 7 Jun 2008 13:51:26 -0700 (PDT)
Message-ID: <256247.26543.qm@web32503.mail.mud.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Grundler <grundler@parisc-linux.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org

----- Original Message ----
From: Grant Grundler <grundler@parisc-linux.org>
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>; Jon Smirl <jonsmirl@yahoo.com>; Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>; Andrew Morton <akpm@linux-foundation.org>; Helge Deller <deller@gmx.de>; linux-parisc@vger.kernel.org
Sent: Saturday, June 7, 2008 4:34:28 PM
Subject: Re: [RESEND] [PATCH] convert sticore.c to PCI ROM API

On Sat, Jun 07, 2008 at 11:08:36AM +0200, Krzysztof Helt wrote:
...
> I am forwarding it to the reporter of the bug 9425 as this bug should be 
> closed without changing the code.

Actually, we should change the code: add a comment that summarizes jejb's
feedback (and the rest of the conversation) so we don't repeat this
exercise again in 2 years.
----------------------------------------------------

The PCI ROM API was made for three main reasons:

1) Drivers,
including X, were mapping the ROMs without declaring the resource. If
you map a ROM without declaring the resource the kernel doesn't know it
is there and may map something else into the same addresses. It's been
a while but I believe the virtualization people were the ones
complaining. 

2) Error checking was not robust in the code that
was directly mapping. This was causing drivers to hang when they used
ROMs they thought the ROM was there and really wasn't. This can definitely
happen and it has happened on my own boxes while doing video driver
work. Occasionally hardware doesn't initialize right and the ROMs won't
enable.

3) It is the ground work for supporting multiple video
cards in a box. When there are multiple cards the API keeps them from
mapping on top of each other. If the location of the ROM is not flexible one has to be turned off before the other one can be turned on.

This code was not intended to be x86 specific. The PCI ROM format is cross platform and this code is used on the PowerPC. 

> 
> A very similar case is for the bug 9424. I analyzed code for the Matrox
> framebuffers and it is not worth changing. The idea behind the  pci_map_rom()
> is that it enables and maps the ROM area. The Matrox framebuffer has
> these two separated as the ROM may appear in the already mapped area.
> The ROM is always enabled but not always mapped.

This is one of the ways to get into trouble. If the ROM is enabled the kernel needs to have a resource marking it to make sure that nothing else gets enabled in the same place. When these ROM were accessed directly by the drivers, the driver code was often missing a few of the error checks needed or the resource allocation, etc. The centralize code made sure that every necessary was done to access the ROMs.

> 
> The only unification I see is to export pci_rom_enable/pci_rom_disable()
> and use them inside the Matrox and sticore drivers (so no ioremap() 
> is done but the code is shorter).
> 
> Regards,
> Krzysztof
> 
> ----------------------------------------------------------------------
> Tanie rozmowy!
> Sprawdz >>>  http://link.interia.pl/f1e22 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-parisc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



      
