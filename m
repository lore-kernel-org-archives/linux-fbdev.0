From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 21 Sep 2013 20:00:00 +0000
Subject: Re: [PATCH 24/51] DMA-API: dma: pl330: add dma_set_mask_and_coherent() call
Message-Id: <20130921200000.GS25647@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMm5t-0007i5-V7@rmk-PC.arm.linux.org.uk>
 <201309201926.29084.heiko@sntech.de>
In-Reply-To: <201309201926.29084.heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org, devel@driverdev.osuosl.org, linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, e1000-devel@lists.sourceforge.net, b43-dev@lists.infradead.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Solarflare linux maintainers <linux-net-drivers@solarflare.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-crypto@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org

On Fri, Sep 20, 2013 at 07:26:27PM +0200, Heiko St=FCbner wrote:
> Am Donnerstag, 19. September 2013, 23:49:01 schrieb Russell King:
> > The DMA API requires drivers to call the appropriate dma_set_mask()
> > functions before doing any DMA mapping.  Add this required call to
> > the AMBA PL08x driver.
> 			^--- copy and paste error - should of course be PL330

Fixed, thanks.
