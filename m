From: Andreas Schwab <schwab@linux-m68k.org>
Date: Tue, 22 Aug 2017 16:17:07 +0000
Subject: Re: 32-bit powerpc, aty128fb: vmap allocation for size 135168 failed
Message-Id: <87378ja870.fsf@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.20.1708180825590.15982@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1708180825590.15982@math.ut.ee> (Meelis Roos's
 message of "Fri, 18 Aug 2017 08:37:46 +0300 (EEST)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Aug 18 2017, Meelis Roos <mroos@linux.ee> wrote:

> Aug 17 23:53:57 pohl kernel: [ 2940.146546] aty128fb 0000:00:10.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x1111
> Aug 17 23:54:02 pohl kernel: [ 2944.804838] aty128fb 0000:00:10.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x1110

I think these messages are harmless and expected.  This device has no
x86 option ROM but a OpenFirmware one.  This is likely unrelated to the
sddm crash.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
