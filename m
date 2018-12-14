From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 14 Dec 2018 12:27:09 +0000
Subject: Re: [PATCH] video/backlight: Use of_node_name_eq for node name comparisons
Message-Id: <20181214122709.GX4497@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181205195050.4759-28-robh@kernel.org>
 <20181206140221.rq4zp74olghzipxu@holly.lan>
In-Reply-To: <20181206140221.rq4zp74olghzipxu@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org

On Thu, 06 Dec 2018, Daniel Thompson wrote:

> On Wed, Dec 05, 2018 at 01:50:44PM -0600, Rob Herring wrote:
> > Convert string compares of DT node names to use of_node_name_eq helper
> > instead. This removes direct access to the node name pointer.
> > 
> > For instances using of_node_cmp, this has the side effect of now using
> > case sensitive comparisons. This should not matter for any FDT based
> > system which this is.
> > 
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> [this is FAO Lee J. rather than recommending you take it via you tree]

Rob knows better than that. ;)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
