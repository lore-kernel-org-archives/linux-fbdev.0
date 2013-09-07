From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 07 Sep 2013 13:55:37 +0000
Subject: Re: [PATCH v2] simplefb: print some info about the registered fb
Message-Id: <CAMuHMdXDAA3PgbgNrccStUZGByDXuSsMG_yJMwwUWXwMvyOfsA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CANq1E4Rxo3Az0hwCzzQyKz6z_uyVq-9bgAzNzm9StkWoAbkN_A@mail.gmail.com>
	<1378554210-943-1-git-send-email-teg@jklm.no>
In-Reply-To: <1378554210-943-1-git-send-email-teg@jklm.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom Gundersen <teg@jklm.no>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, David Herrmann <dh.herrmann@gmail.com>

On Sat, Sep 7, 2013 at 1:43 PM, Tom Gundersen <teg@jklm.no> wrote:
> +       dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%lx bytes, mapped to 0x%p\n",
> +                            info->fix.smem_start, (unsigned long) info->fix.smem_len,

Please drop the cast, and use 0x%x. __u32 is unsigned int everywhere (where it
matters --- we don't do 16-bit ints).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
