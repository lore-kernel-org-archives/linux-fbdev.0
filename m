From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Jun 2017 09:11:47 +0000
Subject: Re: [PATCH] staging: sm750fb: always take the lock
Message-Id: <CAMuHMdUp2JQAYz3Smb4bH=SSc6tCb2iLQG1-5uQguz_wxyybfQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1498455936-2108-1-git-send-email-abdallah.meziti.pro@gmail.com>
In-Reply-To: <1498455936-2108-1-git-send-email-abdallah.meziti.pro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 26, 2017 at 7:45 AM, AbdAllah-MEZITI
<abdallah.meziti.pro@gmail.com> wrote:
> This patch
> - will always take the lock

Why?

"The current code only takes the lock if multiple instances are in use.
 This is error-prone, and confuses static analyzers.
 As taking the lock in case of a single instance is harmful and cheap,
 change the code to always take the lock."

> - fix the sparse warning:
> drivers/staging/sm750fb/sm750.c:159:13: warning: context imbalance in 'lynxfb_ops_fillrect' - different lock contexts for basic block
> drivers/staging/sm750fb/sm750.c:231:9: warning: context imbalance in 'lynxfb_ops_copyarea' - different lock contexts for basic block
> drivers/staging/sm750fb/sm750.c:235:13: warning: context imbalance in 'lynxfb_ops_imageblit' - different lock contexts for basic block

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
