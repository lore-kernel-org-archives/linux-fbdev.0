From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fb_write change in your tree
Date: Wed, 24 Mar 2004 10:59:03 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1080086342.23716.161.camel@gaston>
References: <Pine.LNX.4.44.0403231806450.2419-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5w26-0000Xc-3Y
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Mar 2004 16:14:10 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1B5w25-0006sB-7Z
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Mar 2004 16:14:09 -0800
In-Reply-To: <Pine.LNX.4.44.0403231806450.2419-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Look again. The idea was to grab the userland data and create struct 
> fb_image then use xxxfb_imageblit to draw for you. We should never 
> allow fb_write and fb_read to directly access the framebuffer.

Right. Note that fb_read is still using copy_to_user() with the
fb as a source, and that is hairy too.

But I would still like to allow the fb to just overwrite the whole
fb_read/write implementation. Also, your patch may break things if
userland did fb_write for an amount that covers several lines but
ends up in a middle of one afaik, it converts to images that are
rectangles, and doesn't properly deal with the possible first line
and last lines not beeing complete

> Speaking of. We really need to cleanup the fb_write and crap.
> The program flow should be:
> 
> fb_write -> xxxfb_imageblit -> fb_pixmap.outbuf();
> 
> The outbuf and inbuf commands should replace the fb_writeX and fb_readX 
> stuff. This way driver developers can still use the cfb_xxx functions for 
> strange hardware. a good example is the Epson 1335 chip. You can only 
> access the framebuffer 16 bits at a time. Using 32 bit transfers will drop 
> have the data. Why epson did this will never be know.
> 
>    The other bonus with using the imageblit method with fb_write is 
> that we can treat planar modes a packed pixel modes :-)
> 
> 
> 
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
