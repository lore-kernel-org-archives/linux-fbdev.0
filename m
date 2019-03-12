From: Tom Li <tomli@tomli.me>
Date: Tue, 12 Mar 2019 09:19:32 +0000
Subject: Re: Is it possible to reset graphics controller on reboot in a framebuffer driver?
Message-Id: <20190312091932.GA17859@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190307051641.GA7012@localhost.localdomain>
 <871s3jm532.fsf@intel.com>
 <CAMuHMdU_+4_T4B67Z-Y-wgHQs6o1yuh9H4m82Lym+_Jno5Mgzg@mail.gmail.com>
 <20190307213759.GA14798@localhost.localdomain>
 <CAMuHMdVnkdrUTL_3UaoaOondGxCB_FpEYOTDmLeh1C0W5j0-Hw@mail.gmail.com>
 <20190308103536.GA17258@localhost.localdomain>
In-Reply-To: <20190308103536.GA17258@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>

On Fri, Mar 08, 2019 at 06:35:36PM +0800, Tom Li wrote:
> On Fri, Mar 08, 2019 at 10:13:58AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Mar 7, 2019 at 10:38 PM Tom Li <tomli@tomli.me> wrote:
> > > Nevertheless, does it mean there's no way to prevent it from happening if the
> > > user issues a emergency reboot? Like an automatic reboot after a kernel panic,
> > > or a SysRq-B reboot.
> > 
> > If Linux performs a reboot, it calls the shutdown handlers.
> > I think that includes reboot on panic, or SysRq-B, but I'd have to check to
> > be 100% sure.
> 
> Okay, glad to hear that. If it works for SysRq-B or panic reboot, I think
> it would be enough. After all, hard kernel crashes are rare nowadays, and
> most crashes are hard lockups. In case it happens, the user just presses
> the power button to halt.

As I suspected, emergency reboot via SysRq-B is a hard reboot and none of the
reboot handler will be called. I've put a for (;;) {} loop in .shutdown(), the
kernel would hang during a normal reboot, but a SysRq-B reboot will reset the
machine immediately.

Fortunately, I've found a way to stop trigger the bug in the driver, so no
shutdown handler is needed anymore.

Cheers,
Tom Li
