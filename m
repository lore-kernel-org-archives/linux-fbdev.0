From: Takashi Iwai <tiwai@suse.de>
Date: Fri, 01 Feb 2019 16:17:59 +0000
Subject: Re: [alsa-devel] [PATCH 17/18] ALSA: hal2: pass struct device to DMA API functions
Message-Id: <s5hy36z7aa0.wl-tiwai@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190201084801.10983-1-hch@lst.de>
        <20190201084801.10983-18-hch@lst.de>
        <s5hr2cr8xf6.wl-tiwai@suse.de>
        <20190201160906.GC6532@lst.de>
In-Reply-To: <20190201160906.GC6532@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>, Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>, Nicolas Ferre <nicolas.ferre@microchip.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, iommu@lists.linux-foundation.org

On Fri, 01 Feb 2019 17:09:06 +0100,
Christoph Hellwig wrote:
> 
> On Fri, Feb 01, 2019 at 02:12:45PM +0100, Takashi Iwai wrote:
> > Shall I take this one through sound git tree or all through yours?
> 
> Feel free to merge the sound bits through your tree!

Alright, merged both patches 17 and 18 now.


thanks,

Takashi
