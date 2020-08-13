From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Aug 2020 07:50:55 +0000
Subject: Re: [PATCH] dt-bindings: Whitespace clean-ups in schema files
Message-Id: <CAMuHMdVXvSRF-G_TYu4P+Bqa2FZJWsUCyzqFur3Rb-tBExfbsw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200812203618.2656699-1-robh@kernel.org>
In-Reply-To: <20200812203618.2656699-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-iio@vger.kernel.org, "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" <linux-remoteproc@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, DRI Development <dri-devel@lists.freedesktop.org>, MTD Maling List <linux-mtd@lists.infradead.org>, Linux I2C <linux-i2c@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, linux-rtc@vger.kernel.org, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, linux-input@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-hwmon@vger.kernel.org, netdev <netdev@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>

Hi Rob,

On Wed, Aug 12, 2020 at 10:36 PM Rob Herring <robh@kernel.org> wrote:
> Clean-up incorrect indentation, extra spaces, long lines, and missing
> EOF newline in schema files. Most of the clean-ups are for list
> indentation which should always be 2 spaces more than the preceding
> keyword.
>
> Found with yamllint (which I plan to integrate into the checks).

> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-clocks.yaml
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-clocks.yaml
> @@ -24,9 +24,9 @@ properties:
>        - const: renesas,r8a7778-cpg-clocks # R-Car M1
>        - const: renesas,r8a7779-cpg-clocks # R-Car H1
>        - items:
> -        - enum:
> -            - renesas,r7s72100-cpg-clocks # RZ/A1H
> -        - const: renesas,rz-cpg-clocks    # RZ/A1
> +          - enum:
> +              - renesas,r7s72100-cpg-clocks # RZ/A1H
> +          - const: renesas,rz-cpg-clocks    # RZ/A1

This change breaks alignment of the comments at the end of each line.

>        - const: renesas,sh73a0-cpg-clocks  # SH-Mobile AG5

(I only checked the files I care about)

If you don't update commit  e0fe7fc6f2ca0781 ("dt-bindings: Whitespace
clean-ups in schema files"), I can send a patch after v5.9-rc1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
