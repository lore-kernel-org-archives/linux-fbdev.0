From: James Simmons <jsimmons@infradead.org>
Subject: Re: Need advice on blitting to dword alignment
Date: Fri, 12 Sep 2003 18:09:56 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309121742420.5017-100000@phoenix.infradead.org>
References: <20030912135229.GA12523@zensonic.dk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xrRQ-0007vi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 10:10:40 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xrRP-0000RU-Bo
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 10:10:39 -0700
In-Reply-To: <20030912135229.GA12523@zensonic.dk>
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
To: "Thomas S. Iversen" <zensonic@zensonic.dk>
Cc: linux-fbdev-devel@lists.sourceforge.net


> Hi There
> 
> I am in the final stages of developing a framebufferdriver for 
> the Silicon Motion Lynx series chip, but ran into troubles
> during development of accelerated host blits (mono font expansion to
> arbitrary bpp depths)
> 
> The Lynx chip expects data in dwords no matter what. If
> the image is a multiple of 32 bits wide this is just fine, 
> but if it is not I have to pad in zeros in the last dword _for 
> each line_
> 
> eg. an 24bit by 16 bit mono image would consist of 1 dword for each line
> taking 16 dwords to transfer.
> 
> Is there _any_ way I can force the framebuffer console system to give
> images aligned to dwords? It is ofcourse possible to transfer data
> using a for loop taking the padding into account, but that seems
> overly complex and in-efficient compared to a memcpy_toio(src,dst,size)

Yes!!!!

The NVIDIA fbdev driver had the same problems. That is what struct 
fb_pixmap is for. Since you need 32 bit padded images you would need to 
fill in your own pixmap when you initalize the driver. Something like 
this.

	info->pixmap.addr = kmalloc(64*1024, GFP_KERNEL);
	info->pixmap.size = 64 * 1024;
        info->pixmap.buf_align = 4;
        info->pixmap.scan_align = 4;
        info->pixmap.flags = FB_PIXMAP_SYSTEM;
 
    Okay now what each field means. First is the addr field. This is 
scratch drawing area. In the above example I used normal system ram and tell 
ths system you are using normal ram with the FB_PIXMAP_SYSTEM flag. The 
size is of course the size of the drawing buffer. 
    Now some systems have a drawing buffer in hardware. A good example is the 
Geode graphics chipset. It has a bitblit buffer on chip. In this case you 
would point addr to that hardware address and set the flag to FB_PIXMAP_IO. 
Then just fill in the data. I just finished the cursor api and have a few 
examples of the hardware cursor using something similiar. For the Mach64 
cursor I did something like this at initialization.

P.S I didn't not remove the Big endian code or sparc code. I only cleaned 
it up to show a easy example. 

int __init aty_init_cursor(struct fb_info *info)
{
	unsigned long addr;

	info->fix.smem_len -= PAGE_SIZE;

	addr = (unsigned long) info->screen_base + info->fix.smem_len;
	info->sprite.addr = (u8 *) addr;	

	if (!info->sprite.addr)
		return -ENXIO;
	info->sprite.size = PAGE_SIZE;
	info->sprite.scan_align = 8;	// Cursor pad is 64 bits wide	
	info->sprite.buf_align = 8;	// and 64 bits tall.
	info->sprite.write_access = 2;	// Each pixel is represented by 2 bits
	info->sprite.flags = FB_PIXMAP_IO;	
	info->sprite.outbuf = aty_set_cursor_shape;
}

Here we grab the last page in framebuffer memory and use it as a drawing 
pad. Note the flag. Then we provide our our outbuf function. This function 
writes data to the buffer. With hardware we might need special magic to 
write the data. Also we have a inbuf function for taking data out of a 
hardware buffer and placing it into system memory.
	This can also be used with DMA memory regions. You can point addr 
to the dma region and set the flag to FB_PIXMAP_IO | FB_PIXMAP_SYNC. The 
reason is with dma you have to sync the memory region when it is "full".
No async support yet. Again you have to supply your own outbuf and inbuf
functions. Usually with dma you have to place headers at the front the 
padded image data and sometimes at the end of it as well. There is a 
function to grab a chunck of this memory called fb_get_buffer_offset. 
Usually the upper memory layers handle it only but in the case of DMA you 
might want to grab you own memory size. I haven't resolved that issue yet.

	Scan_align paddes the image data for each scanline. Buf_align pads 
the whole chuck of data. 


        Hope that helps.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
