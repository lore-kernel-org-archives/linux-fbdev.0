From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RESEND] [PATCH] convert sticore.c to PCI ROM API
Date: Fri, 6 Jun 2008 22:35:07 +0200
Message-ID: <20080606223507.0daf2b80.krzysztof.h1@poczta.fm>
References: <20080605231327.af9cc9e6.krzysztof.h1@poczta.fm>
	<1212704814.4241.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1212704814.4241.37.camel@localhost.localdomain>
Sender: linux-parisc-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org

On Thu, 05 Jun 2008 17:26:54 -0500
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> 
> I'm really not sure this is such a good idea.  pci_map_rom() can do an
> ioremap() on the region.  In that case, gsc_readl which punches through
> our virtual memory into physical I/O space will fail.  What assurance do
> we have that all STI roms are correctly set up so pci_map_rom() isn't
> inclined to ioremap them?
> 

I haven't thought about this. The ROM the Helge tested was obviously
set up correctly, otherwise reading the ROM signature would be impossible.

What is you advise for this patch James?

Regards,
Krzysztof

---------------------------------------------------------------
Sprawdz jak zdobyc zdrowy usmiech!
Kliknij >> http://link.interia.pl/f1e26

