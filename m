From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 12 Oct 2017 16:30:32 +0000
Subject: Re: [PATCH] video: fbdev: radeon: make const array post_divs static, reduces object code size
Message-Id: <3309966.vVeY8tZnvB@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170919213206epcas2p3a2bea87468fa266cf1c94829444ab162@epcas2p3.samsung.com>
 <3245965.OqUEzHD6FT@amdc3058>
 <268158e3-00d6-b9c3-34a4-e8ce8e464276@canonical.com>
In-Reply-To: <268158e3-00d6-b9c3-34a4-e8ce8e464276@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin Ian King <colin.king@canonical.com>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Thursday, October 12, 2017 05:17:49 PM Colin Ian King wrote:
> On 12/10/17 17:17, Bartlomiej Zolnierkiewicz wrote:
> > 
> > [ added dri-devel ML to cc: ]
> > 
> > On Tuesday, September 19, 2017 10:32:01 PM Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> Don't populate the read-only const array post_divs on the stack,
> >> nstead make it static. Makes the object code smaller by 90 bytes:
> >>
> >> Before:
> >>    text	   data	    bss	    dec	    hex	filename
> >>   40231	   8584	    896	  49711	   c22f	radeon_base.o
> >>
> >> After:
> >>    text	   data	    bss	    dec	    hex	filename
> >>   39914	   8744	    960	  49618	   c1d2	radeon_base.o
> >>
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > 
> > Are these results obtained using the same compiler as the other patches
> > (gcc version 7.2.0, x86_64)?
> 
> Yes, I forgot to annotate it.

Patch queued for 4.15 (with updated patch description), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

