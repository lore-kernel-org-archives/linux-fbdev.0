From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 13 Nov 2011 20:00:23 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <CAMuHMdX8vP=2hjVb30CWTiWKCJh4kOjgck1SrbCLFseB1KmT3Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Hi David,

On Mon, Nov 14, 2011 at 00:57, David J Ring Jr <n1ea@arrl.net> wrote:
> Output of cat /proc/fb
>
> No output.

Hence your kernel is not using a frame buffer device.
Do you have a frame buffer device driver for your hardware in the kernel?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
