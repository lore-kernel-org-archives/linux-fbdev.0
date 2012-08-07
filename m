From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Tue, 07 Aug 2012 14:53:25 +0000
Subject: RE: [PATCH v3 3/4] media: videobuf2-dma-contig: use dma_mmap_coherent if available
Message-Id: <012701cd74ac$6a617060$3f245120$%szyprowski@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344246924-32620-1-git-send-email-hdk@igel.co.jp>
 <1344246924-32620-4-git-send-email-hdk@igel.co.jp>
In-Reply-To: <1344246924-32620-4-git-send-email-hdk@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Hideki EIRAKU' <hdk@igel.co.jp>, 'Russell King' <linux@arm.linux.org.uk>, 'Pawel Osciak' <pawel@osciak.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Mauro Carvalho Chehab' <mchehab@infradead.org>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, 'Jaroslav Kysela' <perex@perex.cz>, 'Takashi Iwai' <tiwai@suse.de>, Tomasz Stanislawski <t.stanislaws@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, 'Katsuya MATSUBARA' <matsu@igel.co.jp>

Hello,

On Monday, August 06, 2012 11:55 AM Hideki EIRAKU wrote:

> Previously the vb2_dma_contig_mmap() function was using a dma_addr_t as a
> physical address.  The two addressses are not necessarily the same.
> For example, when using the IOMMU funtion on certain platforms, dma_addr_t
> addresses are not directly mappable physical address.
> dma_mmap_coherent() maps the address correctly.
> It is available on ARM platforms.
> 
> Signed-off-by: Hideki EIRAKU <hdk@igel.co.jp>

I'm sorry for bringing this issue now, once you have already created v3 of your
patches, but similar patch has been already proposed some time ago. It is already
processed together with general videobuf2-dma-contig redesign and dma-buf extensions
by Tomasz Stanislawski.

See post http://thread.gmane.org/gmane.comp.video.dri.devel/70402/focusI461 and
http://thread.gmane.org/gmane.linux.drivers.video-input-infrastructure/49438 

It doesn't use conditional code inside videobuf2 allocator and rely entirely on 
dma-mapping subsystem to provide a working dma_mmap_coherent/writecombine/attrs() 
function. When it was posted, it relied on the dma-mapping extensions, which now
have been finally merged to v3.6-rc1. Now I wonder if there are any architectures, 
which don't use dma_map_ops based dma-mapping framework, which might use 
videobuf2-dma-conting module. 

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


