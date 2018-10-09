From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 09 Oct 2018 15:13:57 +0000
Subject: Re: [PATCH v3 03/24] drivers/block/z2ram: use ioremap_wt() instead of __ioremap(_PAGE_WRITETHRU)
Message-Id: <CAMuHMdVpS2wzUniDdXKSWyyTr3Cn9NsXAxOJEKe=D9BUrpdt=w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
 <0d489a2c917d6e8528fad099023eac3d5a516787.1539092111.git.christophe.leroy@c-s.fr>
 <1539097191.64374.44.camel@acm.org>
In-Reply-To: <1539097191.64374.44.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Jens Axboe <axboe@kernel.dk>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Geoff Levand <geoff@infradead.org>, DRI Development <dri-devel@lists.freedesktop.org>, linux-block@vger.kernel.org, Kumar Gala <galak@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Leo Li <leoyang.li@nxp.com>, Scott Wood <oss@buserror.net>, Debian m68k <debian-68k@lists.debian.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Hi Bart,

CC debian-68k, linux-m68k

On Tue, Oct 9, 2018 at 5:00 PM Bart Van Assche <bvanassche@acm.org> wrote:
> On Tue, 2018-10-09 at 13:51 +0000, Christophe Leroy wrote:
> > _PAGE_WRITETHRU is a target specific flag. Prefer generic functions.
> >
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>
> Hi Geert,
>
> All patches that have been applied to this driver since 2005 are API refactoring
> patches. I haven't found any patches in the history of this driver that seem to
> have been submitted by a user of this driver. Do you perhaps know whether anyone
> is using this driver?

The z2ram is a very simple driver, used to configure (slower) Zorro II RAM as
a swap device.  So I'm not so surprised no one submitted functional patches.

I believe it's still being used.
Probably it could be modified to use mtdram.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
