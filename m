From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Jan 2015 18:02:08 +0000
Subject: Re: [PATCH][RESEND] static code analysis from cppcheck reports:
Message-Id: <CAMuHMdXXRpFM2VkEz6gGMA5tmXEKt0mpfUMbgM=SPBZgwVg3Eg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421076472-7101-1-git-send-email-colin.king@canonical.com>
In-Reply-To: <1421076472-7101-1-git-send-email-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jan 12, 2015 at 4:27 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> [drivers/video/fbdev/broadsheetfb.c:673]:
>   (error) Memory leak: sector_buffer
>
> sector_buffer is not being kfree'd on each call to
> broadsheet_spiflash_rewrite_sector(), so free it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

So you can make the box go OOM by repeatedly writing to the
loadstore_waveform device attribute file?
Do we want this applied to -stable?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
