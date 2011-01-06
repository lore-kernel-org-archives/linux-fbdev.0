From: Alex Buell <alex.buell@munted.org.uk>
Date: Thu, 06 Jan 2011 22:24:11 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <1294352651.24378.17.camel@lithium>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294086801.17576.14.camel@lithium>
	 <20110103.123939.02282416.davem@davemloft.net>
	 <1294090573.17576.16.camel@lithium>
	 <20110105.110705.104043006.davem@davemloft.net>
	 <1294262022.24378.2.camel@lithium> <1294274029.24378.11.camel@lithium>
	 <20110106204240.GA6361@electric-eye.fr.zoreil.com>
	 <1294347036.24378.13.camel@lithium>
In-Reply-To: <1294347036.24378.13.camel@lithium>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: David Miller <davem@davemloft.net>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2011-01-06 at 20:50 +0000, Alex Buell wrote:
> > Sorry for the obvious but you modified s3_identification() so that
> it
> > stops emitting vga_rcrt(NULL, ...), right ? 
> 
> I must have missed that one - thank you for pointing that one out to
> me! 

Sweet smell of success: 

Jan  6 22:09:20 sodium kernel: fb1: S3 Virge/GX on 0000:00:03.0, 6 MB
RAM, 14 MHz MCLK

s3fb now loads OK and correctly identifies the graphic adapter, now that
I fixed s3_identification and others. 

It now crashes elsewhere when the framebuffer device is opened, the logs
shows that:

ERROR(0): Cheetah error trap taken afsr[0010100000000000] afar[00000000000003c0] TL1(0)
Jan  6 22:10:05 sodium kernel: ERROR(0): TPC[10575140] TNPC[10575144] O7[105750e8] TSTATE[4411001604]
Jan  6 22:10:05 sodium kernel: ERROR(0): TPC<save_vga+0x8c/0xf90 [vgastate]>
Jan  6 22:10:05 sodium kernel: ERROR(0): M_SYND(0),  E_SYND(0), Privileged
Jan  6 22:10:05 sodium kernel: ERROR(0): Highest priority error (0000100000000000) "Unmapped error from system bus"
Jan  6 22:10:05 sodium kernel: ERROR(0): D-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000]
Jan  6 22:10:05 sodium kernel: ERROR(0): D-cache data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
Jan  6 22:10:05 sodium kernel: ERROR(0): I-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000] u[0000000000000000] l[0000000000000000]
Jan  6 22:10:05 sodium kernel: ERROR(0): I-cache INSN0[0000000000000000] INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000]
Jan  6 22:10:05 sodium kernel: ERROR(0): I-cache INSN4[0000000000000000] INSN5[0000000000000000] INSN6[0000000000000000] INSN7[0000000000000000]
Jan  6 22:10:05 sodium kernel: ERROR(0): E-cache idx[3c0] tag[0000000313924924]
Jan  6 22:10:05 sodium kernel: ERROR(0): E-cache data0[6c6f6e672e682069] data1[6e636c7564652f6c] data2[696e75782f706f73] data3[69785f7479706573]
Jan  6 22:10:05 sodium kernel: Kernel panic - not syncing: Irrecoverable deferred error trap.

Looks like there's a bug in save_vga which is in
drivers/video/vgastate.c. I'll be sprinkling printk()s through
save_vga() to find the offending line of code.

Still, I'm pleased the module loads.
-- 
Tactical Nuclear Kittens
