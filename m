From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 05 Dec 2017 13:51:19 +0000
Subject: Re: [PATCH v3 12/14] nubus: Adopt standard linked list implementation
Message-Id: <2055799.vQuQORffXy@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1512454057.git.fthain@telegraphics.com.au>
        <CGME20171205062005epcas1p192e7c295d64034067554997825ab6539@epcas1p1.samsung.com>
        <7b1f483782e215b88dbd8945838e3b2d9a4a1dc1.1512454057.git.fthain@telegraphics.com.au>
In-Reply-To: <7b1f483782e215b88dbd8945838e3b2d9a4a1dc1.1512454057.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tuesday, December 05, 2017 01:20:02 AM Finn Thain wrote:
> This increases code re-use and improves readability.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Tested-by: Stan Johnson <userm57@yahoo.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

for fbdev part

> ---
>  drivers/net/ethernet/8390/mac8390.c     |  7 +++--
>  drivers/net/ethernet/cirrus/mac89x0.c   |  6 +++--
>  drivers/net/ethernet/natsemi/macsonic.c |  8 +++---
>  drivers/nubus/nubus.c                   | 45 ++++++++-------------------------
>  drivers/nubus/proc.c                    | 11 +++-----
>  drivers/video/fbdev/macfb.c             |  8 +++---
>  include/linux/nubus.h                   | 15 +++++------
>  7 files changed, 40 insertions(+), 60 deletions(-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

