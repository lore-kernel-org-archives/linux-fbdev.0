From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 29 Dec 2017 18:02:03 +0000
Subject: Re: [PATCH 0/4] video-UDLFB: Adjustments for five function implementations
Message-Id: <1768474.zA76iyE2Y1@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171124204825epcas1p41626d598b6e437dfb4c6b648e3730cc1@epcas1p4.samsung.com>
        <6fb11bb4-2c1d-a939-087b-de31c42328b9@users.sourceforge.net>
In-Reply-To: <6fb11bb4-2c1d-a939-087b-de31c42328b9@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bernie Thompson <bernie@plugable.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Friday, November 24, 2017 09:48:14 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 24 Nov 2017 21:45:54 +0100
> 
> A few update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (4):
>   Delete an error message for a failed memory allocation in two functions

This patch removes the information about the device for which the allocation
fails.

>   Return an error code only as a constant in dlfb_realloc_framebuffer()

This patch depends on the earlier patch (which is not being merged) so please
re-base it if you want it to be applied.

>   Improve a size determination in dlfb_alloc_urb_list()

Patch queued for 4.16, thanks.

>   Delete an unnecessary return statement in two functions

Patch queued for 4.16, thanks.
 
>  drivers/video/fbdev/udlfb.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

