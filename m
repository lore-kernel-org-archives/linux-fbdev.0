From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Nov 2010 06:56:05 +0000
Subject: Re: [patch 2/2] fbcmap: integer overflow bug
Message-Id: <AANLkTin0T5FN6WhUj0csypR=j0UPRbeHN+HC3N9xnk7E@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101027093716.GD6062@bicker>
	<20101105134018.2c11f283.akpm@linux-foundation.org>
	<20101113100718.GB1795@bicker>
	<20101115044820.GA8489@linux-sh.org>
In-Reply-To: <20101115044820.GA8489@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Dan Carpenter <error27@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, Nov 15, 2010 at 05:48, Paul Mundt <lethal@linux-sh.org> wrote:
> On Sat, Nov 13, 2010 at 01:07:18PM +0300, Dan Carpenter wrote:
>> @@ -256,8 +264,12 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
>>       int rc, size = cmap->len * sizeof(u16);
>>       struct fb_cmap umap;
>>
>> +     if (cmap->len * 2 > INT_MAX)

Isn't that another integer overflow? I.e. should be "if (cmap->len >
INT_MAX / sizeof(u16))" instead?

>> +             return -EINVAL;
>> +
>>       memset(&umap, 0, sizeof(struct fb_cmap));
>> -     rc = fb_alloc_cmap(&umap, cmap->len, cmap->transp != NULL);
>> +     rc = fb_alloc_cmap_gfp(&umap, cmap->len, cmap->transp != NULL,
>> +                             GFP_KERNEL);
>>       if (rc)
>>               return rc;
>>       if (copy_from_user(umap.red, cmap->red, size) ||
>
> This looks reasonable, but it probably makes more sense to use -E2BIG
> for the overflow case (as other cases are doing already), and also just
> to check size directly rather than open-coding the * 2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
