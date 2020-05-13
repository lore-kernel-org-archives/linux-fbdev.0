From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 May 2020 07:09:24 +0000
Subject: Re: [PATCH 2/3] video: fbdev: ssd1307fb: Support to pixel inversion
Message-Id: <CAMuHMdWiNhpEbXbTcYVJ2gP5X++gwmP5Wb2n9VYchTBFyi07GA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1589316769-13277-1-git-send-email-alencar.fmce@imbel.gov.br> <1589316769-13277-2-git-send-email-alencar.fmce@imbel.gov.br>
In-Reply-To: <1589316769-13277-2-git-send-email-alencar.fmce@imbel.gov.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, alencar.fmce@imbel.gov.br

Hi Rodrigo,

On Tue, May 12, 2020 at 10:53 PM Rodrigo Rolim Mendes de Alencar
<455.rodrigo.alencar@gmail.com> wrote:
> Pixel inversion in hardware is performed by issuing the
> command 0xa7. This patch adds a boolean  property to control
> color inversion.
>
> Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
> +++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
> @@ -22,6 +22,7 @@ Optional properties:
>    - solomon,com-seq: Display uses sequential COM pin configuration
>    - solomon,com-lrremap: Display uses left-right COM pin remap
>    - solomon,com-invdir: Display uses inverted COM pin scan direction
> +  - solomon,color-inv: Set Inverse display mode (invert pixel color)

Isn't that software configuration instead of hard description?
DT describes the hardware, not software configuration, so this may not
belong here?

>    - solomon,com-offset: Number of the COM pin wired to the first display line
>    - solomon,col-offset: Offset of columns (SEG) that the screen is mapped to.
>    - solomon,prechargep1: Length of deselect period (phase 1) in clock cycles.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
