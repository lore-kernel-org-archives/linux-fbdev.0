From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Dec 2013 18:51:53 +0000
Subject: Re: [PATCH] video: amba-clcd: Make CLCD driver available on more platforms
Message-Id: <CAMuHMdXtyHKvpsgVMfoiJ3f0wJ5MXnji6iy7hU-jcp1kSbB4Gw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386868390-12231-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1386868390-12231-1-git-send-email-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Dec 12, 2013 at 7:07 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Dec 12, 2013 at 06:48:49PM +0100, Geert Uytterhoeven wrote:
>
>> Currently ARM_AMBA exists on arm/arm64 only.
>> Is there a patch in the pipeline to change that? Without such a change,
>
> I don't know but it's plausible given how common AMBA is.
>
>> this patch doesn't make any difference.
>
> No, it does mean that ARM64 is included - previously the dependency was

Sure.

> only on ARM so it wasn't available on ARM64.  COMPILE_TEST won't have an
> impact though.

Sorry, I meant it doesn't have any impact on COMPILE_TEST.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
