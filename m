From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 12 Jan 2011 06:00:40 +0000
Subject: Re: [PATCH 06/16] nuc900fb: don't treat NULL clk as an error
Message-Id: <20110112060040.GC2350@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294749833-32019-1-git-send-email-jamie@jamieiles.com>
	<1294749833-32019-7-git-send-email-jamie@jamieiles.com>
	<AANLkTingg+wm8jy4kRL=ubLFrCDXq17jZQkD3v3M4h+Y@mail.gmail.com>
In-Reply-To: <AANLkTingg+wm8jy4kRL=ubLFrCDXq17jZQkD3v3M4h+Y@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jan 12, 2011 at 09:24:47AM +0800, Wan ZongShun wrote:
> 2011/1/11 Jamie Iles <jamie@jamieiles.com>:
> > clk_get() returns a struct clk cookie to the driver and some platforms
> > may return NULL if they only support a single clock. ??clk_get() has only
> > failed if it returns a ERR_PTR() encoded pointer.
> >
> > Cc: Wan ZongShun <mcuos.com@gmail.com>
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> 
> Thanks for your patch.
> 
> Acked-by: Wan ZongShun <mcuos.com@gmail.com>
> 
Applied, thanks.
