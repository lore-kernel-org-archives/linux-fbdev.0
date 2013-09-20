From: Tejun Heo <tj@kernel.org>
Date: Fri, 20 Sep 2013 22:20:50 +0000
Subject: Re: [PATCH 39/51] DMA-API: others: use dma_set_coherent_mask()
Message-Id: <20130920222050.GA8763@mtj.dyndns.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMnNq-0007s4-HN@rmk-PC.arm.linux.org.uk>
 <20130920121652.GA7630@mtj.dyndns.org>
 <20130920140018.GP25647@n2100.arm.linux.org.uk>
In-Reply-To: <20130920140018.GP25647@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, b43-dev@lists.infradead.org, devel@driverdev.osuosl.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, e1000-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-ide@vger.kernel.org, linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Solarflare linux maintainers <linux-net-drivers@solarflare.com>, uclinux-dist-devel@blackfin.uclinux.org, Inki Dae <inki.dae@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyun

Hey,

On Fri, Sep 20, 2013 at 03:00:18PM +0100, Russell King - ARM Linux wrote:
> Another would be if subsystem maintainers are happy that I carry them,
> I can add the acks, and then later on towards the end of the cycle,
> provide a branch subsystem maintainers could pull.
> 
> Or... if you can think of something easier...

I'm happy with the latter method and it's likely that you'll end up
carrying at least some of the patches through your tree anyway.
Please feel free to add my acks to all libata related patches and
carry them through your tree.

Thanks and have fun routing.

-- 
tejun
