From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 01 Aug 2017 12:34:31 +0000
Subject: Re: [PATCH] video/chips: constify fb_fix_screeninfo and fb_var_screeninfo structures
Message-Id: <2575493.n74KlNstDc@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170708011556epcas3p2900f8ed5102858fc64d194feb7874305@epcas3p2.samsung.com>
        <20170708011552.GA26138@embeddedgus>
In-Reply-To: <20170708011552.GA26138@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, July 07, 2017 08:15:52 PM Gustavo A. R. Silva wrote:
> These structures are only used to copy into other structures,
> so declare them as const.
> 
> This issue was detected using Coccinelle and the following semantic patch:
> 
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct fb_fix_screeninfo i@p = { ... };
> 
> @ok@
> identifier r.i;
> expression e;
> position p;
> @@
> e = i@p
> 
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct fb_fix_screeninfo e;
> @@
> e@i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct fb_fix_screeninfo i = { ... };
> 
> The semantic patch for fb_var_screeninfo is analogous.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

