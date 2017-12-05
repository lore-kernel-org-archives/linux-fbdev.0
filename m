From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 05 Dec 2017 13:50:55 +0000
Subject: Re: [PATCH v3 11/14] nubus: Rename struct nubus_dev
Message-Id: <2621660.olL7LkYlpq@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1512454057.git.fthain@telegraphics.com.au>
        <CGME20171205062004epcas5p2f8586fbcbbe377a56e8403c7566e8c3c@epcas5p2.samsung.com>
        <60d598946ac219440cbb1fabed05964e806ebc5f.1512454057.git.fthain@telegraphics.com.au>
In-Reply-To: <60d598946ac219440cbb1fabed05964e806ebc5f.1512454057.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tuesday, December 05, 2017 01:20:02 AM Finn Thain wrote:
> It is misleading to call a functional resource a "device". In adopting
> the Linux Driver Model, the struct device will be embedded in struct
> nubus_board. That will compound the terminlogy problem because drivers
> will bind with boards, not with functional resources. Avoid this by
> renaming struct nubus_dev as struct nubus_rsrc. "Functional resource"
> is the vendor's terminology so this helps avoid confusion.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

for fbdev part

> ---
>  drivers/net/ethernet/8390/mac8390.c     |  26 ++++----
>  drivers/net/ethernet/natsemi/macsonic.c |  22 +++----
>  drivers/nubus/nubus.c                   | 105 ++++++++++++++++----------------
>  drivers/nubus/proc.c                    |  15 ++---
>  drivers/video/fbdev/macfb.c             |   2 +-
>  include/linux/nubus.h                   |  30 +++++----
>  6 files changed, 98 insertions(+), 102 deletions(-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

