From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 11 May 2018 08:13:26 +0000
Subject: Re: [PATCH v2 0/4] backlight: fix device-tree node lookups
Message-Id: <20180511081326.GB5130@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171120104547.2639-1-johan@kernel.org>
 <20180511072731.GA17870@localhost>
In-Reply-To: <20180511072731.GA17870@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Johan Hovold <johan@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

On Fri, 11 May 2018, Johan Hovold wrote:

> Hi Lee,
> 
> On Mon, Nov 20, 2017 at 11:45:43AM +0100, Johan Hovold wrote:
> > A number of drivers have been using the wrong OF helper when doing child-node
> > lookups during probe. This meant that they were doing tree-wide searches rather
> > than matching on child nodes and that the parent node could end up being
> > prematurely freed.
> 
> > Johan Hovold (4):
> >   backlight: as3711_bl: fix device-tree node lookup
> >   backlight: max8925_bl: fix device-tree node lookup
> >   backlight: tps65217_bl: fix device-tree node lookup
> >   backlight: as3711_bl: fix device-tree node leaks
> 
> It appears these four have been sitting in your for-backlight-fixes 
> branch for half a year now without being forwarded to Linus.
> 
> Don't get many backlight fixes these days, huh? ;)

Ha!  To be honest I think those patches are the only 4 -fixes I've
*ever* had for Backlight. :)

I have pulled them into the main branch, so they won't be forgotten
again.  Sorry for the delay.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
