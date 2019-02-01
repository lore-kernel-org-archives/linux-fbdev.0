From: Takashi Iwai <tiwai@suse.de>
Date: Fri, 01 Feb 2019 13:12:45 +0000
Subject: Re: [alsa-devel] [PATCH 17/18] ALSA: hal2: pass struct device to DMA   API functions
Message-Id: <s5hr2cr8xf6.wl-tiwai@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de>
        <20190201084801.10983-18-hch@lst.de>
In-Reply-To: <20190201084801.10983-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, iommu@lists.linux-foundation.org

On Fri, 01 Feb 2019 09:48:00 +0100,
Christoph Hellwig wrote:
> 
> The DMA API generally relies on a struct device to work properly, and
> only barely works without one for legacy reasons.  Pass the easily
> available struct device from the platform_device to remedy this.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me:
  Reviewed-by: Takashi Iwai <tiwai@suse.de>

Shall I take this one through sound git tree or all through yours?


thanks,

Takashi
