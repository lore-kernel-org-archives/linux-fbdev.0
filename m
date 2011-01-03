From: Alex Buell <alex.buell@munted.org.uk>
Date: Mon, 03 Jan 2011 20:33:21 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <1294086801.17576.14.camel@lithium>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294072336.17576.7.camel@lithium>
	 <20110103.105827.112602895.davem@davemloft.net>
	 <1294083541.17576.11.camel@lithium>
	 <20110103.114301.102556157.davem@davemloft.net>
In-Reply-To: <20110103.114301.102556157.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2011-01-03 at 11:43 -0800, David Miller wrote:
> From: Alex Buell <alex.buell@munted.org.uk>
> Date: Mon, 03 Jan 2011 19:39:01 +0000
> 
> > Secondly, is Linux fully capable of handling different graphic cards
> > simultaneously? For example, plug in a pair of monitors and have
> > consoles on both with disparate graphic cards i.e. XVR-500 and S3ViRGE
> > etc? 
> 
> Technically I don't think it can do it currently.  Maybe just for
> kernel message logging, but not for actual login consoles.
> 
> One TTY device is marked as the "console" and that's where all
> tty[0-9]+ devices get instantiated upon.

Hmm, maybe it would be nice to introduce that capability. How doable
would it be? I understand the BKL is going away, perhaps it would now be
easier to introduce such a facility?

I've just started digging into the innards of the s3fb driver, my first
attempt provoked this, simply by commenting out the check to see if it's
not the primary device and exits with -ENODEV: 

Jan  3 20:16:29 sodium kernel: ERROR(1): Cheetah error trap taken
afsr[0030100000000000] afar[00000000000003d0] TL1(0)
Jan  3 20:16:29 sodium kernel: ERROR(1): TPC[105918d8] TNPC[105918dc]
O7[10591884] TSTATE[4411001606]
Jan  3 20:16:29 sodium kernel: ERROR(1): TPC<s3_pci_probe+0x194/0x63c
[s3fb]>
Jan  3 20:16:29 sodium kernel: ERROR(1): M_SYND(0),  E_SYND(0), Multiple
Errors, Privileged
Jan  3 20:16:29 sodium kernel: ERROR(1): Highest priority error
(0000100000000000) "Unmapped error from system bus"
Jan  3 20:16:29 sodium kernel: ERROR(1): D-cache idx[0]
tag[0000000000000000] utag[0000000000000000] stag[0000000000000000]
Jan  3 20:16:29 sodium kernel: ERROR(1): D-cache data0[0000000000000000]
data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
Jan  3 20:16:29 sodium kernel: ERROR(1): I-cache idx[0]
tag[0000000000000000] utag[0000000000000000] stag[0000000000000000]
u[0000000000000000] l[0000000000000000]
Jan  3 20:16:29 sodium kernel: ERROR(1): I-cache INSN0[0000000000000000]
INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000]
Jan  3 20:16:29 sodium kernel: ERROR(1): I-cache INSN4[0000000000000000]
INSN5[0000000000000000] INSN6[0000000000000000] INSN7[0000000000000000]
Jan  3 20:16:29 sodium kernel: ERROR(1): E-cache idx[3c0]
tag[000000000b040000]
Jan  3 20:16:29 sodium kernel: ERROR(1): E-cache data0[000c5aa000000011]
data1[000f43d800000040] data2[0000000000000109] data3[0000000000000000]
Jan  3 20:16:29 sodium kernel: Kernel panic - not syncing: Irrecoverable
deferred error trap.

Heh. ;)
-- 
Tactical Nuclear Kittens
