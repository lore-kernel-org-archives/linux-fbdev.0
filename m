From: James Simmons <jsimmons@infradead.org>
Subject: Re: fb_write change in your tree
Date: Tue, 23 Mar 2004 18:21:49 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403231806450.2419-100000@phoenix.infradead.org>
References: <1080014223.22188.87.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5qXD-0005gi-KD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Mar 2004 10:21:55 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B5qXC-00089b-Fo
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Mar 2004 10:21:54 -0800
In-Reply-To: <1080014223.22188.87.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Hi James !
> 
> What is this change to fb_write() in your tree ? It looks very
> wrong to me. You are removing the ability for the driver to
> hook it's own fb_write function, which can be a problem. You
> basically assume copy_from_user() can be used straight with
> the framebuffer as a destination. 

Look again. The idea was to grab the userland data and create struct 
fb_image then use xxxfb_imageblit to draw for you. We should never 
allow fb_write and fb_read to directly access the framebuffer.

Speaking of. We really need to cleanup the fb_write and crap.
The program flow should be:

fb_write -> xxxfb_imageblit -> fb_pixmap.outbuf();

The outbuf and inbuf commands should replace the fb_writeX and fb_readX 
stuff. This way driver developers can still use the cfb_xxx functions for 
strange hardware. a good example is the Epson 1335 chip. You can only 
access the framebuffer 16 bits at a time. Using 32 bit transfers will drop 
have the data. Why epson did this will never be know.

   The other bonus with using the imageblit method with fb_write is 
that we can treat planar modes a packed pixel modes :-)








-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
