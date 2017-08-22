From: Meelis Roos <mroos@linux.ee>
Date: Tue, 22 Aug 2017 16:29:51 +0000
Subject: Re: 32-bit powerpc, aty128fb: vmap allocation for size 135168 failed
Message-Id: <alpine.LRH.2.20.1708221925270.23061@math.ut.ee>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.20.1708180825590.15982@math.ut.ee>
 <87378ja870.fsf@linux-m68k.org>
In-Reply-To: <87378ja870.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

> > Aug 17 23:53:57 pohl kernel: [ 2940.146546] aty128fb 0000:00:10.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x1111
> > Aug 17 23:54:02 pohl kernel: [ 2944.804838] aty128fb 0000:00:10.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x1110
> 
> I think these messages are harmless and expected.  This device has no
> x86 option ROM but a OpenFirmware one.  This is likely unrelated to the
> sddm crash.

Yes, but after these crashes have happened for a while, vmalloc 
problems appear.

sddm crash might be related to X server dying under it, or it crashes 
for it own problems (varying signals and addresses beacuse of some 
ASLR?) and causes X server restart that triggers another ROM allocation 
round.

I did read the kernel code and I do not see how the dmesg lines are 
possible without corresponding aty128fb lines about the same ROM 
signature, or why the ROM signature is sometimes 0x1111 and sometimes 
0x1110 instead of x86 ROM signature (that clearly is not there, 
but this is expected).

-- 
Meelis Roos (mroos@linux.ee)
