From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Jan 2015 15:27:45 +0000
Subject: Re: SSD1306 OLED driver
Message-Id: <CAMuHMdUTW5gbbfK8eC3ViaTADmc+wqKzfBR=gyjU1CB8XcAKYA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Sagar,

On Wed, Jan 14, 2015 at 2:51 PM, Ssagarr Patil <hugarsagar@outlook.com> wrote:
> I am also able to run the fbtest application, but with test10 I do not see 'hello world'

Good!

> pattern. Am I missing something.

That's because that test requires 16 colors, although these aren't used.

If you change ".numcolors " to ".numcolors = 2" in tests/test010.c,
it should at least draw some text, but the colors may be of as it
failed to install
the 16-color console pallette.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
