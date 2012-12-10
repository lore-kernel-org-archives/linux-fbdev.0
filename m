From: Hideki EIRAKU <hdk@igel.co.jp>
Date: Mon, 10 Dec 2012 10:31:25 +0000
Subject: Re: [PATCH v4] fbdev: sh_mobile_lcdc: use dma_mmap_coherent
Message-Id: <20121210.193125.442743545.hdk@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345112000-22738-1-git-send-email-hdk@igel.co.jp>
	<14014166.3JMiBq7jRA@avalon>
In-Reply-To: <14014166.3JMiBq7jRA@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: laurent.pinchart@ideasonboard.com
Cc: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, matsu@igel.co.jp, dhobsong@igel.co.jp

Hi Laurent,

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4] fbdev: sh_mobile_lcdc: use dma_mmap_coherent
Date: Thu, 16 Aug 2012 14:16:32 +0200

> Hi Eiraku-san,
> 
> On Thursday 16 August 2012 19:13:20 Hideki EIRAKU wrote:
>> fb_mmap() implemented in fbmem.c uses smem_start as the physical
>> address of the frame buffer.  In the sh_mobile_lcdc driver, the
>> smem_start is a dma_addr_t that is not a physical address when IOMMU is
>> enabled.  dma_mmap_coherent() maps the address correctly.
>> 
>> Signed-off-by: Hideki EIRAKU <hdk@igel.co.jp>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> I will push the patch to v3.7 through my tree.

I'd like to use this patch to test IOMMU implementation of Renesas
IPMMU.  But I could not find it in v3.7-rc8.  Could you please tell me if 
this has already been merged somewhere or not?

-- 
Hideki EIRAKU <hdk@igel.co.jp>
