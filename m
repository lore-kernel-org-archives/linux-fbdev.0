From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 29 Dec 2017 18:26:42 +0000
Subject: Re: [PATCH 0/5] video-SMSC UFX: Adjustments for five function implementations
Message-Id: <1736749.UIs06O4xc5@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171125204312epcas2p149d6487ac83e886f95aefe0b35aef1b0@epcas2p1.samsung.com>
 <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
In-Reply-To: <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Steve Glendinning <steve.glendinning@shawell.net>, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org

On Saturday, November 25, 2017 09:42:57 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 25 Nov 2017 21:38:42 +0100
> 
> A few update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (5):
>   Delete an error message for a failed memory allocation in two functions

This patch removes the information about the device for which the allocation
fails.

>   Less checks in ufx_usb_probe() after error detection

This patch depends on the earlier patch (which is not being merged) so please
re-base it if you want it to be applied.

>   Return an error code only as a constant in ufx_realloc_framebuffer()

ditto

>   Improve a size determination in two functions

Patch queued for 4.16, thanks.

>   Adjust three checks for null pointers

This patch contains unrelated change ({} braces addition) which should be
dropped.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

