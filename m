From: Wang YanQing <udknight@gmail.com>
Date: Mon, 19 Mar 2012 00:30:44 +0000
Subject: Re: [PATCH] x86: export 'pcibios_enabled'
Message-Id: <20120319003044.GA3744@udknight>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120313204114.e160849af7dbe5a4b4e5c0ad@canb.auug.org.au>
 <4F5FAE63.3090908@xenotime.net>
In-Reply-To: <4F5FAE63.3090908@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Michal Januszewski <spock@gentoo.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Tue, Mar 13, 2012 at 01:30:27PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Export 'pcibios_enabled' so that when uvesafb is built as a
> loadable module (on X86_32), the build will succeed.
> 
> ERROR: "pcibios_enabled" [drivers/video/uvesafb.ko] undefined!
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> Cc:	Michal Januszewski <spock@gentoo.org>
> Cc:	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc:	linux-fbdev@vger.kernel.org
> Cc:	x86@kernel.org
> ---
> Applies to mainline; found in linux-next.
> 
>  arch/x86/pci/pcbios.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20120313.orig/arch/x86/pci/pcbios.c
> +++ linux-next-20120313/arch/x86/pci/pcbios.c
> @@ -27,6 +27,7 @@
>  #define PCIBIOS_HW_TYPE2_SPEC		0x20
>  
>  int pcibios_enabled;
> +EXPORT_SYMBOL(pcibios_enabled);
>  
>  /* According to the BIOS specification at:
>   * http://members.datafast.net.au/dft0802/specs/bios21.pdf, we could
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Hi, could you resend this patch as EXPORT_SYMBOL_GPL to x86 architecture maintainer?
Looks at the MAINTAINERS for the below:

X86 ARCHITECTURE (32-BIT AND 64-BIT)
M:	Thomas Gleixner <tglx@linutronix.de>
M:	Ingo Molnar <mingo@redhat.com>
M:	"H. Peter Anvin" <hpa@zytor.com>
M:	x86@kernel.org
