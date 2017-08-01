From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 01 Aug 2017 12:50:42 +0000
Subject: Re: [PATCH] video: cobalt_lcdfb: constify fb_fix_screeninfo structure
Message-Id: <2606688.MWf1F93hnl@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170708013027epcas1p36438cf071afb2633cd7439ad0de538d3@epcas1p3.samsung.com>
        <20170708013023.GA4842@embeddedgus>
In-Reply-To: <20170708013023.GA4842@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, July 07, 2017 08:30:23 PM Gustavo A. R. Silva wrote:
> This structure is only used to copy into other structures,
> so declare it as const.
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
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

