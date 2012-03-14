From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 14 Mar 2012 09:29:55 +0000
Subject: Re: [PATCH] x86: export 'pcibios_enabled'
Message-Id: <20120314092955.2250a782@pyramind.ukuu.org.uk>
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

> >  
> >  int pcibios_enabled;
> > +EXPORT_SYMBOL(pcibios_enabled);
> >  
> >  /* According to the BIOS specification at:
> >   * http://members.datafast.net.au/dft0802/specs/bios21.pdf, we could
> 
> I would think this should be EXPORT_SYMBOL_GPL()... this seems like a
> symbol with a very high likelihood to be abused in strange ways.

We don't need to expose it anyway

uvesafb could look for any PCI vga class device - which I suspect is
what it *should* be doing ?

Alan
