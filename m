From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 17 Jan 2020 19:32:23 +0000
Subject: Re: [PATCH 0/6] video: fbdev: controlfb: small cleanup
Message-Id: <20200117193223.GD24812@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200116140914eucas1p1a62794ad40589e818614176ea8e817ff@eucas1p1.samsung.com>
 <20200116140900.26363-1-b.zolnierkie@samsung.com>
In-Reply-To: <20200116140900.26363-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi Bartlomiej

On Thu, Jan 16, 2020 at 03:08:54PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> Small cleanup for controlfb driver:
> 
> - fix sparse warnings
> - remove not working module support
> - add COMPILE_TEST support
> - remove redundant function prototypes

Nice cleanup - with a few comments.
The last three patches are the good ones.

With my comments considered - and then up to you if you cahnge anything
- then all patches are:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 
> Bartlomiej Zolnierkiewicz (6):
>   video: fbdev: controlfb: fix sparse warning about using incorrect type
>   video: fbdev: controlfb: remove obsolete module support
>   video: fbdev: controlfb: add COMPILE_TEST support
>   video: fbdev: controlfb: remove function prototypes part #1
>   video: fbdev: controlfb: remove function prototypes part #2
>   video: fbdev: controlfb: remove function prototypes part #3
> 
>  drivers/video/fbdev/Kconfig     |   2 +-
>  drivers/video/fbdev/controlfb.c | 810 +++++++++++++++-----------------
>  2 files changed, 383 insertions(+), 429 deletions(-)
> 
> -- 
> 2.24.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
