From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 26 Jul 2012 11:20:44 +0000
Subject: Re: [PATCH v2 4/4] fbdev: sh_mobile_lcdc: use dma_mmap_coherent if available
Message-Id: <1820152.JumtPU1V17@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343301191-26001-1-git-send-email-hdk@igel.co.jp>
 <1343301191-26001-5-git-send-email-hdk@igel.co.jp>
In-Reply-To: <1343301191-26001-5-git-send-email-hdk@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hideki EIRAKU <hdk@igel.co.jp>
Cc: alsa-devel@alsa-project.org, Katsuya MATSUBARA <matsu@igel.co.jp>, linux-fbdev@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-media@vger.kernel.org, Pawel Osciak <pawel@osciak.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Kyungmin Park <kyungmin.park@samsung.com>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>

Hi Eiraku-san,

On Thursday 26 July 2012 20:13:11 Hideki EIRAKU wrote:
> fb_mmap() implemented in fbmem.c uses smem_start as the physical
> address of the frame buffer.  In the sh_mobile_lcdc driver, the
> smem_start is a dma_addr_t that is not a physical address when IOMMU is
> enabled.  dma_mmap_coherent() maps the address correctly.  It is
> available on ARM platforms.
> 
> Signed-off-by: Hideki EIRAKU <hdk@igel.co.jp>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

