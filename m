From: Joe Perches <joe@perches.com>
Date: Thu, 15 Mar 2018 17:13:42 +0000
Subject: Re: rfc: remove print_vma_addr ? (was Re: [PATCH 00/16] remove eight obsolete architectures)
Message-Id: <1521134022.22221.38.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <2929.1521106970@warthog.procyon.org.uk>
 <CAMuHMdXcxuzCOnFCNm4NXDv-wfYJDO5GQpB_ECu7j=2BjMhNpA@mail.gmail.com>
 <1521133006.22221.35.camel@perches.com>
 <20180315170830.GA17574@bombadil.infradead.org>
In-Reply-To: <20180315170830.GA17574@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-block@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org, netdev <netdev@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-ide@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, DRI Development <dri-devel@lists.freedesktop.org>, linux-input@vger.kernel.org, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-rtc@vger.kernel.org

On Thu, 2018-03-15 at 10:08 -0700, Matthew Wilcox wrote:
> On Thu, Mar 15, 2018 at 09:56:46AM -0700, Joe Perches wrote:
> > I have a patchset that creates a vsprintf extension for
> > print_vma_addr and removes all the uses similar to the
> > print_symbol() removal.
> > 
> > This now avoids any possible printk interleaving.
> > 
> > Unfortunately, without some #ifdef in vsprintf, which
> > I would like to avoid, it increases the nommu kernel
> > size by ~500 bytes.
> > 
> > Anyone think this is acceptable?
[]
> This doesn't feel like a huge win since it's only called ~once per
> architecture.  I'd be more excited if it made the printing of the whole
> thing standardised; eg we have a print_fault() function in mm/memory.c
> which takes a suitable set of arguments.

Sure but perhaps that's not feasible as the surrounding output
is per-arch specific.

What could be a standardized fault message here?

