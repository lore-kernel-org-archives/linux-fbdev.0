From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Tile Blitting
Date: Thu, 27 Feb 2003 01:18:02 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302270056200.16050-100000@phoenix.infradead.org>
References: <1046306105.1210.83.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18oCh2-0007FX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Feb 2003 17:18:37 -0800
In-Reply-To: <1046306105.1210.83.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> For model 2, do we have to allocate/deallocate per iteration?  

I'm looking at the streaming DMA model used by filesystem buffers being 
written/read by a SCSI device. You are right tho. If you use pci_dma_sync 
then you don't need to create and remove the mappings. The question is 
there any hardware to limited where we have to create/destory mapping 
constantly? 

> Secondly, we cannot deallocate the memory
> until the GPU is done rendering.  This means we have to synchronize for
> each imageblit, further slowing it down.  Modern GPU's have deep
> pipelines, let's take advantage of it.

Okay good point.
 
> So, how about letting the driver allocate the memory for us, and this
> will last throughout the lifetime of the driver?  This also becomes a
> consistent mapping.  The main difference is, we treat this memory as a a
> ringbuffer, ie:
> 
> Memory is at address p, size N. 
> 
> The first bitmap, in terms of time of arrival, (bitmap1) will be at 'p',
> bitmap2 at 'p+size1', bitmap 3 at 'p+size1+size2' and so on and so
> forth.  Once fbcon reaches the end of the buffer, 'p+N', it calls
> fb_sync() and start all over again, at 'p'.
> 
> The advantages of the above are:
> 
> 	1. no need to allocate/deallocate memory which is disproportionately
> more expansive relative to the bitmap sizes fbcon is dealing with.
> 
> 	2. no chance of memory becoming unavailable during
> memory-starved/emergency states.

Very good. 

> 	3. the whole process is very fast and asynchronous.  The GPU can be
> rendering, while the CPU is preparing the bitmap.  The only time fbcon
> synchronizes is during the "wrap-around".

> This is actually the initial patch that I submitted to you months ago,
> but you rejected it.  

Well I was wrong :-( I rejected because I was hoping to keep the api 
object orientated (rectangle and bitmap/pixmaps). Now I see that without 
this kind of solution we end up with a bigger mess. I admit I made the 
wrong judgement call on this. 

> As Geert and DaveM has
> mentioned to me, the current implementation might not be thread-safe
> (although I see more of a concurrency problem between CPU and GPU).

I agree I see more of a problem with CPU GPU syncing issue. I do have a 
fix in BK with allocating and deallocating continuely but it is the wrong
approach.

> Thus, the restriction that the buffer must be completely copied by the
> driver before returning.  And because of this restriction, an extra copy
> which might be unnecessary cannot be avoided (this was noted by Petr).
> 
> Treating the buffer as a ringbuffer, we eliminate these restrictions.

I didn't realize that the below was a ringbuffer implementation. The name
threw me off. 

> So:
> 
> struct fb_pixmap {
> 	__u8 *addr;
> 	__u32 size;
> 	__u32 tail;
> 	__u32 buf_align;
> 	__u32 scan_align;
> 	__u32 flags;
> }
> 
> a. addr - pointer to memory
> 
> b. tail - this is the current offset to the buffer
> 
> c. buf_align - start alignment per bitmap
> 
> d. scan_align - alignment for each scanline, cfb_imageblit requires 1,
> i810fb, 2, rivafb and tgafb(?) 4. 
> 
> e. flags = location of buffer (system or graphics/pci/dma) so fbcon can
> choose how to access the memory.
> 
> The structure is prepared by the driver at initialization. If it chooses
> not too, addr should be NULL and fbcon will just allocate memory for it,
> and use default values (size = 8K, buf_align = 1, scan_align = 1, flags
> = system).

Do you still have the original patch?



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
