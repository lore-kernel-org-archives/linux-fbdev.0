From: Meelis Roos <mroos@linux.ee>
Date: Sat, 19 Aug 2017 05:39:40 +0000
Subject: Re: 32-bit powerpc, aty128fb: vmap allocation for size 135168 failed
Message-Id: <alpine.LRH.2.20.1708190007310.26479@math.ut.ee>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.20.1708180825590.15982@math.ut.ee>
 <87mv6xjc2g.fsf@concordia.ellerman.id.au>
In-Reply-To: <87mv6xjc2g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

> Meelis Roos <mroos@linux.ee> writes:
> 
> > I was trying 4.13.0-rc5-00075-gac9a40905a61 on my PowerMac G4 with 1G 
> > RAM and after some time of sddm respawning and X trying to restart, 
> > dmesg is full of messages about vmap allocation failures.
> 
> Did it just start happening? ie. did rc4 work?

It goes back to at least 4.0 - that's the oldest kernel I had laying 
around precompiled. The messages about ROM signature changed somewehere 
between 4.0 and 4.7 (4.7 is already like 4.13) but after some time, the 
same vmalloc errors appear.

Maybe the userspace has changed with more respawning that brings the 
problem out.

I tried to read the code but I do not understand it yet. The warning 
seems to come from generic pci_map_rom() checking ROM size, and 
returning rom pointer to aty128fb (it returns resource size too but that 
is ignored). aty128fb starts to look at the x86 PCI ROM signature again 
but does not tell that the signature is missing. How come?

-- 
Meelis Roos (mroos@linux.ee)
