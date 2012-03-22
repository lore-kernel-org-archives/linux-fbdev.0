From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Mar 2012 12:15:20 +0000
Subject: Re: usage of height and width in fb_var_screeninfo
Message-Id: <CAMuHMdW1nm02pu_+SE_3SSu+0qaK-OcynAxj20NUxSK_VCDxZg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAGA24ML642uOP1tEp+VOTe0OZQ9S3HnP8Zi+N1n8X-QsjP9P2w@mail.gmail.com>
In-Reply-To: <CAGA24ML642uOP1tEp+VOTe0OZQ9S3HnP8Zi+N1n8X-QsjP9P2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Thu, Mar 22, 2012 at 12:52, Jun Nie <niej0001@gmail.com> wrote:
> Does anyone happen to know the usage of below member in
> fb_var_screeninfo? I do not know whether mm stand for geometry size or
> memory, can not find its usage in any driver neither. We considering
> to use it as zoomed size.
>
> struct fb_var_screeninfo {
>        __u32 height;                   /* height of picture in mm    */
>        __u32 width;                    /* width of picture in mm     */

They are both geometry sizes in millimeters.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
