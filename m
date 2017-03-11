From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 11 Mar 2017 10:31:20 +0000
Subject: Re: [PATCH v2] staging: sm750fb: function prototype argument should have an identifier name
Message-Id: <CAMuHMdXv4YthJn3Nu6PL4wybRFkQ4-VrzYh68yyh5whKMyWWsQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170311095302.GA4037@arushi-HP-Pavilion-Notebook>
In-Reply-To: <20170311095302.GA4037@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, outreachy-kernel@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Mar 11, 2017 at 10:53 AM, Arushi Singhal
<arushisinghal19971997@gmail.com> wrote:
> --- a/drivers/staging/sm750fb/sm750.h
> +++ b/drivers/staging/sm750fb/sm750.h
> @@ -184,8 +184,8 @@ static inline unsigned long ps_to_hz(unsigned int psvalue)
>  }
>
>  int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev);
> -int hw_sm750_inithw(struct sm750_dev*, struct pci_dev *);
> -void hw_sm750_initAccel(struct sm750_dev *);
> +int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev);
> +void hw_sm750_initAccel(struct sm750_dev *hw_sm750_initAccel);

"sm750_dev", like the implementation uses.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
