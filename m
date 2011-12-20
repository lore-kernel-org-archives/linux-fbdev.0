From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Dec 2011 13:48:33 +0000
Subject: Re: linux-next: build warning after merge of the fbdev tree
Message-Id: <CAMuHMdU5iRf4HUS5i_ibJxvHGcszdF+ZXmwMCWsXvr4k8DjPHQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20111220163214.351b13b464c46f506f329b30@canb.auug.org.au>
	<201112201137.12003.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201112201137.12003.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Dec 20, 2011 at 11:37, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 20 December 2011 06:32:14 Stephen Rothwell wrote:
>> After merging the fbdev tree, today's linux-next build (powerpc
>> ppc64_defconfig) produced this warning:
>>
>> drivers/video/matrox/matroxfb_base.c:150:2: warning: braces around scalar
>> initializer [enabled by default]
>> drivers/video/matrox/matroxfb_base.c:150:2: warning: (near initialization
>> for 'vesafb_defined.colorspace') [enabled by default]
>> drivers/video/matrox/matroxfb_base.c:150:2: warning: excess elements in
>> scalar initializer [enabled by default]
>> drivers/video/matrox/matroxfb_base.c:150:2: warning: (near initialization
>> for 'vesafb_defined.colorspace') [enabled by default]
>> drivers/video/matrox/matroxfb_crtc2.c:596:3: warning: braces around scalar
>> initializer [enabled by default]
>> drivers/video/matrox/matroxfb_crtc2.c:596:3: warning: (near initialization
>> for 'matroxfb_dh_defined.colorspace') [enabled by default]
>> drivers/video/matrox/matroxfb_crtc2.c:596:3: warning: excess elements in
>> scalar initializer [enabled by default]
>> drivers/video/matrox/matroxfb_crtc2.c:596:3: warning: (near initialization
>> for 'matroxfb_dh_defined.colorspace') [enabled by default]
>>
>> Introduced by commit fb21c2f42879 ("fbdev: Add FOURCC-based format
>> configuration API").
>
> The following patch should fix the issue. Florian, are you fine with it, or
> would you rather modify the initializers to be name-based ?
>
> From 078987fc14dba806fc1bc628e3e5c371db3cf1b8 Mon Sep 17 00:00:00 2001
> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Date: Tue, 20 Dec 2011 11:30:53 +0100
> Subject: [PATCH] fbdev: matroxfb: Fix compilation after fb_var_screeninfo change
>
> Commit fb21c2f42879 ("fbdev: Add FOURCC-based format configuration API")
> modified the layout of the fb_var_screeninfo structure. Update the
> static initializers in the matroxfb driver accordingly.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/video/matrox/matroxfb_base.c  |    2 +-
>  drivers/video/matrox/matroxfb_crtc2.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
> index 44bf8d4..f98aad5 100644
> --- a/drivers/video/matrox/matroxfb_base.c
> +++ b/drivers/video/matrox/matroxfb_base.c
> @@ -147,7 +147,7 @@ static struct fb_var_screeninfo vesafb_defined = {
>        39721L,48L,16L,33L,10L,
>        96L,2L,~0,      /* No sync info */
>        FB_VMODE_NONINTERLACED,
> -       0, {0,0,0,0,0}
> +       0, 0, {0,0,0,0}

All these zeroes should not be specified, the compiler will do the
right thing for
static variables anyway.

Else they have to be updated manually everytime one of the reserved fields
is consumed for a new feature.

>  };
>
>
> diff --git a/drivers/video/matrox/matroxfb_crtc2.c b/drivers/video/matrox/matroxfb_crtc2.c
> index d7112c3..d0c1abc 100644
> --- a/drivers/video/matrox/matroxfb_crtc2.c
> +++ b/drivers/video/matrox/matroxfb_crtc2.c
> @@ -593,7 +593,7 @@ static struct fb_var_screeninfo matroxfb_dh_defined = {
>                39721L,48L,16L,33L,10L,
>                96L,2,0,        /* no sync info */
>                FB_VMODE_NONINTERLACED,
> -               0, {0,0,0,0,0}
> +               0, 0, {0,0,0,0}

Same here.

>  };
>
>  static int matroxfb_dh_regit(const struct matrox_fb_info *minfo,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
