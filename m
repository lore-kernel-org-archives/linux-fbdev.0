From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 04 Jan 2018 15:05:15 +0000
Subject: Re: [PATCH] vfb: fix video mode and line_length being set when loaded
Message-Id: <3149875.iSmVjzXX7W@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <39a57338-18ac-c64f-1cf1-70a5f905990a@national.shitposting.agency>
        <CGME20171220145325epcas4p2734200912e99f122f834413362cf6504@epcas4p2.samsung.com>
        <81bf0d1e-ee7a-29ea-d19e-ffeb41d285fe@national.shitposting.agency>
In-Reply-To: <81bf0d1e-ee7a-29ea-d19e-ffeb41d285fe@national.shitposting.agency>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Pieter \"PoroCYon\" Sluys" <pcy@national.shitposting.agency>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Wednesday, December 20, 2017 02:53:00 PM Pieter PoroCYon Sluys wrote:
> Geert Uytterhoeven:
> > Please add your "Signed-off-by", cfr.
> > Documentation/process/submitting-patches.rst.
> 
> Sorry I knew I would've messed up *something*.
> 
> > You can drop the tests for 2 and 4, as these are no longer used by the driver.
> 
> Done that.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Pieter "PoroCYon" Sluys <pcy@national.shitposting.agency>

I've queued your patch for 4.16 kernel (after fixing few minor
issues [*]), thanks!

[*] next time please remember to:

* always include full patch description in the later patch revisions

* put things that don't belong to patch description after "---" so
  they will not be included in the final commit

* in the later patch revisions include ChangeLog after "---" and also
  put patch version in the patch summary line / mail subject
  (i.e. "[PATCH v2] ...")

* add tags (i.e. "Reviewed-by: ...") from patch reviewers / testers
  into the patch description

* check your patch with scripts/checkpatch.pl tool and fix reported
  issues, i.e.:

ERROR: switch and case should be at the same indent
#69: FILE: drivers/video/fbdev/vfb.c:242:
+       switch (info->var.bits_per_pixel) {
+               case 1:
[...]
+               case 8:
[...]
+               case 16:
+               case 24:
+               case 32:

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

