From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 04 Jan 2018 13:37:46 +0000
Subject: Re: [PATCH] fbdev: au1200fb: delete duplicate header contents
Message-Id: <17042840.GgI3QMGfLJ@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171128152248epcas4p479d822a4cac1b766e2199e517ad8606d@epcas4p4.samsung.com>
 <20171128152222.6260-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20171128152222.6260-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tuesday, November 28, 2017 04:22:22 PM Rasmus Villemoes wrote:
> This file has been copy-pasted-pasted:
> 
>   ~/linux$ x=drivers/video/fbdev/au1200fb.h; diff -u <(head -n 286 $x; head -n 286 $x) $x
>   ~/linux$
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Patch queued for 4.16, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

