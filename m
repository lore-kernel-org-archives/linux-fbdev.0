From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [RESEND] [PATCH] convert sticore.c to PCI ROM API
Date: Sat, 7 Jun 2008 14:34:28 -0600
Message-ID: <20080607203428.GA23115@colo.lackof.org>
References: <20080605231327.af9cc9e6.krzysztof.h1@poczta.fm> <1212704814.4241.37.camel@localhost.localdomain> <20080606223507.0daf2b80.krzysztof.h1@poczta.fm> <1212794861.16182.39.camel@localhost.localdomain> <20080607110836.b2c9f48a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080607110836.b2c9f48a.krzysztof.h1@poczta.fm>
Sender: linux-parisc-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Jon Smirl <jonsmirl@yahoo.com>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org

On Sat, Jun 07, 2008 at 11:08:36AM +0200, Krzysztof Helt wrote:
...
> I am forwarding it to the reporter of the bug 9425 as this bug should be 
> closed without changing the code.

Actually, we should change the code: add a comment that summarizes jejb's
feedback (and the rest of the conversation) so we don't repeat this
exercise again in 2 years.

thanks,
grant

> 
> A very similar case is for the bug 9424. I analyzed code for the Matrox
> framebuffers and it is not worth changing. The idea behind the  pci_map_rom()
> is that it enables and maps the ROM area. The Matrox framebuffer has
> these two separated as the ROM may appear in the already mapped area.
> The ROM is always enabled but not always mapped.
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
