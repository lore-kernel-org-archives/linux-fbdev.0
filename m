From: Wang YanQing <udknight@gmail.com>
Date: Sun, 01 Apr 2012 01:05:30 +0000
Subject: Re: [PATCH] video:uvesafb: Fix oops that uvesafb try to execute NX-protected page
Message-Id: <20120401010530.GA4431@udknight>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120327100136.GA3829@udknight>
 <20120327143243.015ecff6@pyramind.ukuu.org.uk>
 <20120328005238.GA3844@udknight>
In-Reply-To: <20120328005238.GA3844@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, spock@gentoo.org

On Wed, Mar 28, 2012 at 08:52:38AM +0800, Wang YanQing wrote:
> On Tue, Mar 27, 2012 at 02:32:43PM +0100, Alan Cox wrote:
> > On Tue, 27 Mar 2012 18:01:36 +0800
> > Wang YanQing <udknight@gmail.com> wrote:
> > 
> > > 
> > > Ok! I try to check pcibios_enabled first, but get some opposition by Alan Cox,
> > > but I want to make thing work and fix the oops, so I choice the simple way to
> > > check the (__supported_pte_mask & _PAGE_NX) instead of to check this variable plus
> > > pci kernel boot parameter, pci mmconfig works or not, and more, and more. It is not
> > > the best method, but it works and maybe all will feel happy.
> > 
> > Okay let me ask the obvious question - why is it not the best method ?
> > 
> > Apart from adding a helper in the includes for the arch code of
> > 
> > 	static inline is_nx_enabled(void)
> > 	{
> > 		return !!(__supported_pte_mask & _PAGE_NX);
> > 	}
> > 
> > is there anything else it lacks ?
> > 
> > Yes ideally we'd set the relevant ROM areas executable, but for a simple
> > fix is there anything else that's a problem with it ?
> Ok! Maybe you had missed my previous reply
> http://permalink.gmane.org/gmane.linux.kernel/1272433
> It is not the best method, because the check is not enough.
> I means when NX is actively, the pci bios is NX or not also depend on
> the code path in pci_arch_init which will be influenced by the acpi on or off, pci kernel boot
> parameter, even kernel config like pci access method PCI_GOANY, PCI_GOMMCONFIG, or PCI_GODIRECT,
> but if I check the pcibios_enabled, all the above can be ignored.
> 
> if uvesafb use the PMI when PCI BIOS is X, it can get the better work efficience then use the redraw 
> method as a fallback when do the panning.
Alan

I am just curious, I want to know what I describe above is right a little,
or wrong about all the aspect.
thanks.

