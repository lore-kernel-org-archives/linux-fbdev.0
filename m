From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH] Tile Blitting
Date: 27 Feb 2003 08:35:06 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046306105.1210.83.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0302261933310.12126-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18oC0I-0001ap-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Feb 2003 16:34:26 -0800
In-Reply-To: <Pine.LNX.4.44.0302261933310.12126-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-02-27 at 04:11, James Simmons wrote:
> 
> Boy this has been tricky to handle. I have been thinking about how to 
> handle image blitting from normal memory to texture mappings to tiles.
> Then after that I have to make it abstract to fit all these models. 
> Pretty much I have come to the conclusion that we have two models.
> 
> Model 1: Consistent mappings. 
> 
> 	In this model we allocate one time a buffer to store image data.
> 	The fbcon classic is loadfont. It could also be creating texures
> 	and saving it in a permentant texture map buffer that is present 
>         on the card. Same for tiles. We create a bunch of tiles and save 
>         them somewhere. We then use a index of some kind later to draw 
> 	the image.
> 
> Model 2: Streaming mappings. 
> 
> 	This model has us create a temporary memory pool to store data 
> 	then draw it. After drawing is complete we release the memory. 
> 	
> 
> As you can see the standard imageblit function falls into model 2. At 
> present we allocate a static buffer :-( Now for a PCI DMA based card we 
> want a hook to allocate a chunck of memory via pci_alloc_consittent. To 
> free the memory we use pci_free_consistent. Also for AGP there could be 
> hooks just for it. So model 2 can be broken into 2 parts.
> 
> A) Memory mangement. We first allocate the memory needed. After drawing
>    the image free the memory.
> 
> B) Draw the image. This occurs between the two events in A.
> 

For model 2, do we have to allocate/deallocate per iteration?  First, we
are not dealing with large-sized bitmaps here (a single character at
most will have 64 bytes).  Secondly, we cannot deallocate the memory
until the GPU is done rendering.  This means we have to synchronize for
each imageblit, further slowing it down.  Modern GPU's have deep
pipelines, let's take advantage of it.

So, how about letting the driver allocate the memory for us, and this
will last throughout the lifetime of the driver?  This also becomes a
consistent mapping.  The main difference is, we treat this memory as a a
ringbuffer, ie:

Memory is at address p, size N. 

The first bitmap, in terms of time of arrival, (bitmap1) will be at 'p',
bitmap2 at 'p+size1', bitmap 3 at 'p+size1+size2' and so on and so
forth.  Once fbcon reaches the end of the buffer, 'p+N', it calls
fb_sync() and start all over again, at 'p'.

The advantages of the above are:

	1. no need to allocate/deallocate memory which is disproportionately
more expansive relative to the bitmap sizes fbcon is dealing with.

	2. no chance of memory becoming unavailable during
memory-starved/emergency states.

	3. the whole process is very fast and asynchronous.  The GPU can be
rendering, while the CPU is preparing the bitmap.  The only time fbcon
synchronizes is during the "wrap-around".

This is actually the initial patch that I submitted to you months ago,
but you rejected it.  That's why I came up with the simpler
implementation (statically allocated buffer).  As Geert and DaveM has
mentioned to me, the current implementation might not be thread-safe
(although I see more of a concurrency problem between CPU and GPU).
Thus, the restriction that the buffer must be completely copied by the
driver before returning.  And because of this restriction, an extra copy
which might be unnecessary cannot be avoided (this was noted by Petr).

Treating the buffer as a ringbuffer, we eliminate these restrictions.

So:

struct fb_pixmap {
	__u8 *addr;
	__u32 size;
	__u32 tail;
	__u32 buf_align;
	__u32 scan_align;
	__u32 flags;
}

a. addr - pointer to memory

b. tail - this is the current offset to the buffer

c. buf_align - start alignment per bitmap

d. scan_align - alignment for each scanline, cfb_imageblit requires 1,
i810fb, 2, rivafb and tgafb(?) 4. 

e. flags = location of buffer (system or graphics/pci/dma) so fbcon can
choose how to access the memory.

The structure is prepared by the driver at initialization. If it chooses
not too, addr should be NULL and fbcon will just allocate memory for it,
and use default values (size = 8K, buf_align = 1, scan_align = 1, flags
= system).

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
