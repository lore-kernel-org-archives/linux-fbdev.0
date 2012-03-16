From: Wang YanQing <udknight@gmail.com>
Date: Fri, 16 Mar 2012 00:41:42 +0000
Subject: Re: [PATCH] x86: export 'pcibios_enabled'
Message-Id: <20120316004142.GA3897@udknight>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120313204114.e160849af7dbe5a4b4e5c0ad@canb.auug.org.au>
 <4F5FAE63.3090908@xenotime.net>
 <4F5FE9AD.7000204@zytor.com>
In-Reply-To: <4F5FE9AD.7000204@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Michal Januszewski <spock@gentoo.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Tue, Mar 13, 2012 at 05:43:25PM -0700, H. Peter Anvin wrote:
> On 03/13/2012 01:30 PM, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > Export 'pcibios_enabled' so that when uvesafb is built as a
> > loadable module (on X86_32), the build will succeed.
> > 
> > ERROR: "pcibios_enabled" [drivers/video/uvesafb.ko] undefined!
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > Cc:	Michal Januszewski <spock@gentoo.org>
> > Cc:	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> > Cc:	linux-fbdev@vger.kernel.org
> > Cc:	x86@kernel.org
> > ---
> > Applies to mainline; found in linux-next.
> > 
> >  arch/x86/pci/pcbios.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > --- linux-next-20120313.orig/arch/x86/pci/pcbios.c
> > +++ linux-next-20120313/arch/x86/pci/pcbios.c
> > @@ -27,6 +27,7 @@
> >  #define PCIBIOS_HW_TYPE2_SPEC		0x20
> >  
> >  int pcibios_enabled;
> > +EXPORT_SYMBOL(pcibios_enabled);
> >  
> >  /* According to the BIOS specification at:
> >   * http://members.datafast.net.au/dft0802/specs/bios21.pdf, we could
> 
> I would think this should be EXPORT_SYMBOL_GPL()... this seems like a
> symbol with a very high likelihood to be abused in strange ways.
> 
> 	-hpa
> 
Yes, I think EXPORT_SYMBOL_GPL is better. Indeed, there is another issue I 
meet about the pcibios NX protection code.
If I set "pcibios_enable = 1" forcely no matter whether set_bios_x had been executed, then
the BIOS code is not NX. The problem is,  if set_bios_x had not been executed, of course set_memory_x 
for the bios code page has no chance to execute, then why the BIOS code is not NX? Any comment?
Or because the default set for the BIOS range is X, if so we should set_memory_nx if pcibios_enable = 0.
