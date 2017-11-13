From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Nov 2017 08:57:36 +0000
Subject: Re: [PATCH 12/14] nubus: Rename struct nubus_dev
Message-Id: <CAMuHMdUkMTHZA8zjky6Tmj1mdtyA0GkJXGt2QSvFd8Of63TOaA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1510377368.git.fthain@telegraphics.com.au> <e431877669099f4245c8e9ef4d0240896195c467.1510377369.git.fthain@telegraphics.com.au>
In-Reply-To: <e431877669099f4245c8e9ef4d0240896195c467.1510377369.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Linux/m68k <linux-m68k@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

Hi Finn,

On Sat, Nov 11, 2017 at 7:12 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> It is misleading to use "dev" to mean a functional resource. And
> in adopting the Linux Driver Model, struct nubus_board will embed a
> struct device. Drivers will then bind with boards, not with functional
> resources.
>
> Rename struct nubus_dev as struct nubus_functional_resource. This is
> the vendor's terminology and avoids confusion.

Isn't "struct nubus_functional_resource" a bit long?
What about "nubus_res"? "nubus_fres"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
