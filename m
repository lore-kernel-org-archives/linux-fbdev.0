From: James Simmons <jsimmons@infradead.org>
Subject: Re: framebuffer_{alloc,release}
Date: Wed, 17 Sep 2003 20:11:54 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309172000040.1730-100000@phoenix.infradead.org>
References: <20030916192753.GB14731@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zhj6-00034Q-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 12:12:32 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19zhj5-0004y9-9g
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Sep 2003 12:12:31 -0700
In-Reply-To: <20030916192753.GB14731@dreamland.darkstar.lan>
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
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, Russell King <rmk@arm.linux.org.uk>


The patch looks nice except for one thing. framebuffer_alloc is incorrect 
in assuming there is one struct xxx_par per strut fb_info. Struct xxx_par
represents the physically hardware in a way independent of the 
framebuffer. The reason for this was to handle cards with more than one 
physical framebuffer. For example take a dual headed radeon card. You 
would have a design like this.
		   |-----------------	
 ____________	   |	 | /dev/fb0 |
| radeon_par | ----|	 ------------
|____________|	   |
		   |
		   |-----------------
		   	 | /dev/fb1 |
		   	 ------------

the reason for this design is simple. If fb0 video resolution changes it 
affects par. Now par's state affect fb1. We need to see if changes to 
either fb0 or fb1 affects the other display as well. 

> +/**
> + * framebuffer_alloc - creates a new frame buffer info structure
> + *
> + * @size: size of driver private data, can be zero
> + * @dev: pointer to the device for this fb, can be NULL
> + *
> + * Creates a new frame buffer info structure. Also reserves @size bytes
> + * for driver private data (fb_info->par). fb_info->par (if any) will be
> + * aligned to sizeof(long).
> + * 
> + * Returns the new structure, or NULL if an error occurred.
> + *
> + */
> +struct fb_info *framebuffer_alloc(size_t size, struct device *dev) {
> +#define BYTES_PER_LONG (BITS_PER_LONG/8)
> +#define PADDING (BYTES_PER_LONG - (sizeof(struct fb_info) % BYTES_PER_LONG))
> +	struct fb_info *fb_info;
> +	char *p;
> +	int fb_info_size = sizeof(struct fb_info);
> +
> +	if (size)
> +		fb_info_size += PADDING;
> +
> +	p = kmalloc(fb_info_size + size, GFP_KERNEL);
> +	if (!p)
> +		return NULL;
> +	memset(p, 0, fb_info_size + size);
> +	fb_info = (struct fb_info *)p;
> +	fb_info->class_dev.dev = dev;
> +
> +	if (size)
> +		fb_info->par = p + fb_info_size;
> +
> +	return fb_info;
> +#undef PADDING
> +#undef BYTES_PER_LONG
> +}



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
