From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 22 Jan 2019 09:22:34 +0000
Subject: Re: [PATCH v9 00/22] Re-use nvram module
Message-Id: <20190122092234.GA15813@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Michael Schmitz <schmitzmic@gmail.com>, linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "Martin K. Petersen" <martin.petersen@oracle.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Joshua Thompson <funaho@jurai.org>

On Tue, Jan 15, 2019 at 03:18:56PM +1100, Finn Thain wrote:
> The "generic" NVRAM module, drivers/char/generic_nvram.c, implements a
> /dev/nvram misc device. This module is used only by 32-bit PowerPC
> platforms.
> 
> The RTC "CMOS" NVRAM module, drivers/char/nvram.c, also implements a
> /dev/nvram misc device. This module is now used only by x86 and m68k
> thanks to commit 3ba9faedc180 ("char: nvram: disable on ARM").
> 
> The "generic" module cannot be used by x86 or m68k platforms because it
> cannot co-exist with the "CMOS" module. One reason for that is the
> CONFIG_GENERIC_NVRAM kludge in drivers/char/Makefile. Another reason is
> that automatically loading the appropriate module would be impossible
> because only one module can provide the char-major-10-144 alias.
> 
> A multi-platform kernel binary needs a single, generic module. With this
> patch series, drivers/char/nvram.c becomes more generic and some of the
> arch-specific code gets moved under arch/. The nvram module is then
> usable by all m68k, powerpc and x86 platforms.
> 
> This allows for removal of drivers/char/generic_nvram.c as well as a
> duplicate in arch/powerpc/kernel/nvram_64.c. By reducing the number of
> /dev/nvram char misc device implementations, the number of bugs and
> inconsistencies is also reduced.
> 
> This approach reduces inconsistencies between PPC32 and PPC64 and also
> between PPC_PMAC and MAC. A uniform API has benefits for userspace.
> 
> For example, some error codes for some ioctl calls become consistent
> across PowerPC platforms. The uniform API can potentially benefit any
> bootloader that works across the various platforms having XPRAM
> (e.g. Emile).
> 
> This patch series was tested on Atari, Mac, PowerMac (both 32-bit and
> 64-bit) and ThinkPad hardware. AFAIK, it has not yet been tested on
> pSeries or CHRP.
> 
> I think there are two possible merge strategies for this patch series.
> The char misc maintainer could take the entire series. Alternatively,
> the m68k maintainer could take patches 1 thru 16 (though some of these
> have nothing to do with m68k) and after those patches reach mainline
> the powerpc maintainer could take 17 thru 22.

I just took the whole series, thanks for doing this, looks good.

greg k-h
