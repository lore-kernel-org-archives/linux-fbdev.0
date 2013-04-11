From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Apr 2013 10:42:29 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <CAMuHMdWFVi=AFR8prins0mees4BFUUXirCC2swyQPwGs7Tt8uQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Apr 4, 2013 at 4:39 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> +       { "r5g6b5", 16, {11, 5}, {5, 6}, {0, 5}, {0, 0} },

Why "r5g6b5" instead of "rgb565", which is what's commonly used?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
