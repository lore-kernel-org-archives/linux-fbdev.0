From: Wang YanQing <udknight@gmail.com>
Date: Wed, 21 Mar 2012 04:37:21 +0000
Subject: Re: [PATCH v2] x86: export 'pcibios_enabled' as GPL
Message-Id: <20120321043721.GA927@udknight>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120313204114.e160849af7dbe5a4b4e5c0ad@canb.auug.org.au>
 <4F5FAE63.3090908@xenotime.net>
 <20120319003044.GA3744@udknight>
 <4F6685ED.7040000@xenotime.net>
In-Reply-To: <4F6685ED.7040000@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Michal Januszewski <spock@gentoo.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com

On Sun, Mar 18, 2012 at 06:03:41PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Export 'pcibios_enabled' so that when uvesafb is built as a
> loadable module (on X86_32), the build will succeed.
> 
> ERROR: "pcibios_enabled" [drivers/video/uvesafb.ko] undefined!
> 
> Patch v2 uses EXPORT_SYMBOL_GPL() as requested.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> Cc:	Michal Januszewski <spock@gentoo.org>
> Cc:	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc:	linux-fbdev@vger.kernel.org
> Cc:	x86@kernel.org
> ---
>  arch/x86/pci/pcbios.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20120313.orig/arch/x86/pci/pcbios.c
> +++ linux-next-20120313/arch/x86/pci/pcbios.c
> @@ -27,6 +27,7 @@
>  #define PCIBIOS_HW_TYPE2_SPEC		0x20
>  
>  int pcibios_enabled;
> +EXPORT_SYMBOL_GPL(pcibios_enabled);
>  
>  /* According to the BIOS specification at:
>   * http://members.datafast.net.au/dft0802/specs/bios21.pdf, we could
Acked-by: Wang YanQing <udknight@gmail.com>
