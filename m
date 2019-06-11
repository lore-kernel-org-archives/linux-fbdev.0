From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 11 Jun 2019 14:04:35 +0000
Subject: Re: [PATCH] efifb: BGRT: Add check for new BGRT status field rotation bits
Message-Id: <CAKv+Gu8w2Vj-AS-cfaB8cms+ZJ7qppS-Du_334_xm51rz0CYsA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190529154635.2659-1-hdegoede@redhat.com>
 <CAKv+Gu8bLcDROFNFfqHaN1Z+EK5bnXMNDSJbBK-pCmq5XP_kBw@mail.gmail.com>
In-Reply-To: <CAKv+Gu8bLcDROFNFfqHaN1Z+EK5bnXMNDSJbBK-pCmq5XP_kBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-efi <linux-efi@vger.kernel.org>, "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>, Peter Jones <pjones@redhat.com>, dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Mon, 10 Jun 2019 at 17:12, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 29 May 2019 at 17:46, Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Starting with ACPI 6.2 bits 1 and 2 of the BGRT status field are no longer
> > reserved. These bits are now used to indicate if the image needs to be
> > rotated before being displayed.
> >
> > The efifb code does not support rotating the image before copying it to
> > the screen.
> >
> > This commit adds a check for these new bits and if they are set leaves the
> > fb contents as is instead of trying to use the un-rotated BGRT image.
> >
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>

BTW should we make sure that this patch and the efi-bgrt patch get
merged at the same time? I guess the net result is just that we get
rid of some error in the log, but a rotated BMP will be ignored
otherwise. Or is it relevant for userland in some other way?
