From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Mar 2012 19:22:34 +0000
Subject: Re: [Linux-fbdev-devel] [uclinux-dist-devel] [PATCH] [#7001] framebuffer: old image of last app woul
Message-Id: <CAMuHMdUuY32MAfQoVacZMP1OA8y2Lg=uvOPSMtT=O+sL=Tb7wA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201203151508.04564.vapier@gentoo.org>
In-Reply-To: <201203151508.04564.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

[ Corrected obsolete linux-fbdev-devel address ]

On Thu, Mar 15, 2012 at 20:08, Mike Frysinger <vapier@gentoo.org> wrote:
> On Thursday 15 March 2012 05:23:50 Wu, Aaron wrote:
>> Old image of last application would retain for a while when starting a new
>> application, this patch clear the frambuffer before displaying every time
>> the fb is opened.
>
> i'm not sure the behavior you describe is wrong.  in fact, i'm pretty sure it
> sounds correct.  if an app writes an image to the framebuffer and then quits,
> that image should stay there indefinitely until something else opens the
> framebuffer and draws their own image.

Indeed. Else can you no longer make a screenshot using "cat /dev/fb0 > file".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
