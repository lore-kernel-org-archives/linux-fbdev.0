From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 04 Nov 2013 19:01:41 +0000
Subject: Re: [PATCHv4][ 1/6] fbdev: Add the lacking FB_SYNC_* for matching the DISPLAY_FLAGS_*
Message-Id: <CAMuHMdVmQCeYd5=r6zqmKRTbTFhh_5RHmeVVhaoq0BVwXoFgsA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383581724-14817-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1383581724-14817-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 4, 2013 at 5:15 PM, Denis Carikli <denis@eukrea.com> wrote:
> --- a/include/uapi/linux/fb.h
> +++ b/include/uapi/linux/fb.h

> +#define FB_SYNC_DE_HIGH_ACT    64      /* data enable high active */
> +#define FB_SYNC_PIXDAT_HIGH_ACT        128     /* data enable high active */

copy and paste of the comment above?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
