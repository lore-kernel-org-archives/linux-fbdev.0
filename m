From: Johan Hovold <johan@kernel.org>
Date: Mon, 20 Nov 2017 11:44:12 +0000
Subject: Re: [PATCH v2 3/4] backlight: tps65217_bl: fix device-tree node lookup
Message-Id: <20171120114412.GD3339@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171120104547.2639-1-johan@kernel.org>
 <20171120104547.2639-4-johan@kernel.org>
 <6effdc1a-9c3d-a773-04e4-e6c3ea8f4f52@linaro.org>
In-Reply-To: <6effdc1a-9c3d-a773-04e4-e6c3ea8f4f52@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Matthias Kaehlcke <matthias@kaehlcke.net>

On Mon, Nov 20, 2017 at 11:34:07AM +0000, Daniel Thompson wrote:
> 
> 
> On 20/11/17 10:45, Johan Hovold wrote:
> > Fix child-node lookup during probe, which ended up searching the whole
> > device tree depth-first starting at the parent rather than just matching
> > on its children.
> > 
> > This would only cause trouble if the child node is missing while there
> > is an unrelated node named "backlight" elsewhere in the tree.
> > 
> > Fixes: eebfdc17cc6c ("backlight: Add TPS65217 WLED driver")
> > Cc: stable <stable@vger.kernel.org>     # 3.7
> > Cc: Matthias Kaehlcke <matthias@kaehlcke.net>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Didn't I already ack this one?

Indeed you did (same with the previous one). Sorry about forgetting to
add them to v2.

> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Thanks for the acks.

Johan
