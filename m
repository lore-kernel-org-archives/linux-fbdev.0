From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 28 Jul 2014 08:54:34 +0000
Subject: Re: [PATCH] video: clcd-versatile: Depend on ARM
Message-Id: <5789388.BhevNhh9tO@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1406480658-27243-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1406480658-27243-1-git-send-email-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sunday 27 July 2014 18:04:18 Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> The Versatile CLCD helpers call dma_alloc_writecombine() which is only
> available on ARM and AVR32, meaning they won't build on other platforms
> including arm64. Unfortunately the current Kconfig enables the symbol
> by default if ARCH_VEXPRESS is defined which means that it is enabled on
> arm64 when building for the ARM reference platforms and models for ARMv8
> since they have many hardware similarities with their pre-ARMv8 systems.
> 
> Since all the systems that need the helpers are ARM systems fix this by
> adding a dependency on ARM.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

I guess this one is for me, as the bug only exists in linux-next through
arm-soc, introduced by my previous fix for another bug.

Applied to next/cleanup, thanks a lot for fixing it!

	Arnd
