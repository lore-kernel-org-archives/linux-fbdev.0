From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 22 Nov 2015 21:16:27 +0000
Subject: Re: [PATCH] fbdev: sm712fb: avoid unused function warnings
Message-Id: <3884293.N93RQ5y3N9@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4240710.SWINpxTKzN@wuerfel>
 <CAMuHMdXCAG0N1KgqVeLvfCM_JgJYpLQXp8zkJPKEiN4YW6jthQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXCAG0N1KgqVeLvfCM_JgJYpLQXp8zkJPKEiN4YW6jthQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sunday 22 November 2015 21:51:54 Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Fri, Nov 20, 2015 at 10:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The sm712fb framebuffer driver encloses the power-management
> > functions in #ifdef CONFIG_PM, but the smtcfb_pci_suspend/resume
> > functions are only really used when CONFIG_PM_SLEEP is also
> > set, as a frequent gcc warning shows:
> >
> > fbdev/sm712fb.c:1549:12: warning: 'smtcfb_pci_suspend' defined but not used
> > fbdev/sm712fb.c:1572:12: warning: 'smtcfb_pci_resume' defined but not used
> >
> > The driver also avoids using the SIMPLE_DEV_PM_OPS macro when
> > CONFIG_PM is unset, which is redundant.
> 
> Is it? AFAIK there's no dummy of SIMPLE_DEV_PM_OPS() for the !CONFIG_PM case
> yet. May be a good idea to have, though.

The idea of the macro seems to be that the assignment of the pointers
is left out, but the structure is still there. We could fix that, but
I'd rather try to fix the macro in a way that creates an unused
reference to the functions, so we never need any #ifdef or __maybe_unused
annotation. We could also come up with a way to remove the structure
from the binary in that case, but I can't think of an obvious solution
for that at the moment.

	Arnd
