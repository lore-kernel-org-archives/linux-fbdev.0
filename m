From: Johan Hovold <johan@kernel.org>
Date: Fri, 11 May 2018 07:27:31 +0000
Subject: Re: [PATCH v2 0/4] backlight: fix device-tree node lookups
Message-Id: <20180511072731.GA17870@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171120104547.2639-1-johan@kernel.org>
In-Reply-To: <20171120104547.2639-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Johan Hovold <johan@kernel.org>, linux-fbdev@vger.kernel.org

Hi Lee,

On Mon, Nov 20, 2017 at 11:45:43AM +0100, Johan Hovold wrote:
> A number of drivers have been using the wrong OF helper when doing child-node
> lookups during probe. This meant that they were doing tree-wide searches rather
> than matching on child nodes and that the parent node could end up being
> prematurely freed.

> Johan Hovold (4):
>   backlight: as3711_bl: fix device-tree node lookup
>   backlight: max8925_bl: fix device-tree node lookup
>   backlight: tps65217_bl: fix device-tree node lookup
>   backlight: as3711_bl: fix device-tree node leaks

It appears these four have been sitting in your for-backlight-fixes 
branch for half a year now without being forwarded to Linus.

Don't get many backlight fixes these days, huh? ;)

Thanks,
Johan
