From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Fri, 29 May 2015 21:04:20 +0000
Subject: Re: [PATCH v4 0/17] framebuffer: simple conversions to arch_phys_wc_add()
Message-Id: <20150529210420.GF23057@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432859434-17821-1-git-send-email-mcgrof@do-not-panic.com>
 <5567FDBE.8010701@ti.com>
In-Reply-To: <5567FDBE.8010701@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, May 29, 2015 at 08:48:46AM +0300, Tomi Valkeinen wrote:
> 
> 
> On 29/05/15 03:30, Luis R. Rodriguez wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > 
> > Tomi,
> > 
> > Upon integration onto your tree of the series, "[PATCH v3 00/17] framebuffer:
> > simple conversions to arch_phys_wc_add()" the 0 day build bot found a
> > compilation issue on the gbefb driver. I had test compiled drivers with
> > allyesconfig and allmodconfig but failed to test compile against MIPS. This
> > driver is enabled *only for MIPS*.  For the life me I could not get a MIPS
> > cross compiler even on debian, so what I did to test this was incorporate into
> > my private tree a temporary patch [0] which enables this driver to compile on
> > x86 and go test compile with that as a temporary patch. The compilation was
> > failing since I used the info struct instead of the actual private data
> > structure. This fixes that and moves its assignment early.  Sorry about that.
> > 
> > The rest of the series does not require changes for integration after these
> > two patch replacements. Let me know if you'd like me to respin the entire
> > series though, but I didn't since I figured its pointless as the patches remain
> > intact. For your convenience however I've rebased all these 17 patches onto
> > your latest tree on the for-next branch, you can pull the changes with the
> > details provided below. This v4 iteration only carries the two patches which
> > required updates. The details of the full pull request go below this.
> 
> Thanks, I've updated the two patches, and pushed the series to my for-next.

And yet another corner case, which compilation would not have picked up but
only grammar would. Best handled now before it being merged.  The same gbefb
MIPS patch had a missing change from dma_free_coherent() to
dma_free_writecombine(), this is needed since the gbefb is changed to use
dma_alloc_writecombine(). The change required is illustrated below. Terribly
sorry about that...  I'll send a v5 pull request unless you want that to
go separately. Meanwhile I've verified the other series I have for MTRR
and none of them use these APIs so this is the only one with this
inconsistancy.

diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index d2601808..b63d55f 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -1238,7 +1238,7 @@ static int gbefb_probe(struct platform_device *p_dev)
 out_gbe_unmap:
 	arch_phys_wc_del(par->wc_cookie);
 	if (gbe_dma_addr)
-		dma_free_coherent(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
+		dma_free_writecombine(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
 out_tiles_free:
 	dma_free_coherent(NULL, GBE_TLB_SIZE * sizeof(uint16_t),
 			  (void *)gbe_tiles.cpu, gbe_tiles.dma);
@@ -1259,7 +1259,7 @@ static int gbefb_remove(struct platform_device* p_dev)
 	gbe_turn_off();
 	arch_phys_wc_del(par->wc_cookie);
 	if (gbe_dma_addr)
-		dma_free_coherent(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
+		dma_free_writecombine(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
 	dma_free_coherent(NULL, GBE_TLB_SIZE * sizeof(uint16_t),
 			  (void *)gbe_tiles.cpu, gbe_tiles.dma);
 	release_mem_region(GBE_BASE, sizeof(struct sgi_gbe));

  Luis
