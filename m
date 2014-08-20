From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 20 Aug 2014 13:03:07 +0000
Subject: Re: [PATCH v2] video: ARM CLCD: Fix calculation of bits-per-pixel
Message-Id: <1408539787.21533.79.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1408538464.3858.43.camel@linaro1.home>
In-Reply-To: <1408538464.3858.43.camel@linaro1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 2014-08-20 at 13:41 +0100, Jon Medhurst (Tixy) wrote:
> If the device-tree specifies a max-memory-bandwidth property then the
> CLCD driver uses that to calculate the bits-per-pixel supported,
> however, this calculation is faulty for two reasons.
> 
> 1. It doesn't ensure that the result is a sane value, i.e. a power of 2
>    and <= 32 as the rest of the code assumes.
> 
> 2. It uses the displayed resolution and calculates the average bandwidth
>    across the whole frame. It should instead calculate the peak
>    bandwidth based on the pixel clock.
> 
> This patch fixes both the above.
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>

Acked-by: Pawel Moll <pawel.moll@arm.com>

