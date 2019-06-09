From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 09 Jun 2019 07:54:29 +0000
Subject: Re: [PATCH v3 10/33] docs: fb: convert docs to ReST and rename to *.rst
Message-Id: <CAMuHMdUyvZ89=P4GOY-BkyS45cj66STgZe9gN3q0L+sj-Wc+wg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
 <f7f9c692a870f836e5657b8a763d751b6ac0e86e.1560045490.git.mchehab+samsung@kernel.org>
In-Reply-To: <f7f9c692a870f836e5657b8a763d751b6ac0e86e.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Thomas Winischhofer <thomas@winischhofer.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Bernie Thompson <bernie@plugable.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maik Broemme <mbroemme@libmpq.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Michal Januszewski <spock@gentoo.org>, Jiri Slaby <jslaby@suse.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>

Hi Mauro,

On Sun, Jun 9, 2019 at 4:29 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> The conversion is actually:
>   - add blank lines and identation in order to identify paragraphs;
>   - fix tables markups;
>   - add some lists markups;
>   - mark literal blocks;
>   - adjust title markups.
>
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Thanks!

> --- a/Documentation/fb/framebuffer.txt
> +++ b/Documentation/fb/framebuffer.rst
> @@ -1,5 +1,6 @@
> -                       The Frame Buffer Device
> -                       -----------------------
> +===========> +The Frame Buffer Device
> +===========>
>  Maintained by Geert Uytterhoeven <geert@linux-m68k.org>

I'm happy to see this line dropped ;-)

>  Last revised: May 10, 2001


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
