From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 05 Jul 2019 15:16:22 +0000
Subject: Re: [PATCH] video: fbdev: s3c-fb: Mark expected switch fall-throughs
Message-Id: <4771baff-b157-2416-d43b-bf6d8980fbb3@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190625160111epcas3p162f3d789c6219e679d9fd30c6a6b3d51@epcas3p1.samsung.com>
        <20190625160103.GA13133@embeddedor>
In-Reply-To: <20190625160103.GA13133@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>


On 6/25/19 6:01 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/video/fbdev/s3c-fb.c: In function ‘s3c_fb_blank’:
> drivers/video/fbdev/s3c-fb.c:811:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    sfb->enabled &= ~(1 << index);
>    ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
> drivers/video/fbdev/s3c-fb.c:814:2: note: here
>   case FB_BLANK_NORMAL:
>   ^~~~
>   LD [M]  drivers/staging/greybus/gb-light.o
>   CC [M]  drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gp10b.o
> drivers/video/fbdev/s3c-fb.c: In function ‘s3c_fb_check_var’:
> drivers/video/fbdev/s3c-fb.c:286:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    var->transp.length = 1;
>    ~~~~~~~~~~~~~~~~~~~^~~
> drivers/video/fbdev/s3c-fb.c:288:2: note: here
>   case 18:
>   ^~~~
> drivers/video/fbdev/s3c-fb.c:314:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    var->transp.offset = 24;
>    ~~~~~~~~~~~~~~~~~~~^~~~
> drivers/video/fbdev/s3c-fb.c:316:2: note: here
>   case 24:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case, the code comments are modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for v5.3, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
