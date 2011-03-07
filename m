From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 07 Mar 2011 10:31:39 +0000
Subject: Re: [PATCH] video: add MODULE_DEVICE_TABLE
Message-Id: <20110307103139.53cdaa71@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1299486373.20702.1.camel@mola>
In-Reply-To: <1299486373.20702.1.camel@mola>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ghozlane Toumi <gtoumi@laposte.net>, "David S. Miller" <davem@davemloft.net>, Alan Hourihane <alanh@tungstengraphics.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org

On Mon, 07 Mar 2011 16:26:13 +0800
Axel Lin <axel.lin@gmail.com> wrote:

> The device table is required to load modules based on modaliases.

Doing this then triggers autoloading which for some of these drivers is
the wrong thing.

> diff --git a/drivers/video/sstfb.c b/drivers/video/sstfb.c
> index 2ab7041..597e80b 100644
> --- a/drivers/video/sstfb.c
> +++ b/drivers/video/sstfb.c
> @@ -1485,6 +1485,7 @@ static const struct pci_device_id sstfb_id_tbl[] = {
>  		.driver_data = ID_VOODOO2, },
>  	{ 0 },
>  };
> +MODULE_DEVICE_TABLE(pci, sstfb_id_tbl);

NAK - as things stand in the frame buffer world you don't want sstfb
autoloading and stealing your main framebuffer away.

