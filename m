From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 18 Aug 2017 12:27:19 +0000
Subject: Re: 32-bit powerpc, aty128fb: vmap allocation for size 135168 failed
Message-Id: <87mv6xjc2g.fsf@concordia.ellerman.id.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.20.1708180825590.15982@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1708180825590.15982@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Meelis Roos <mroos@linux.ee> writes:

> I was trying 4.13.0-rc5-00075-gac9a40905a61 on my PowerMac G4 with 1G 
> RAM and after some time of sddm respawning and X trying to restart, 
> dmesg is full of messages about vmap allocation failures.

Did it just start happening? ie. did rc4 work?

cheers
