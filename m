From: James Simmons <jsimmons@www.infradead.org>
Subject: Status for my work.
Date: Sat, 5 Feb 2005 01:03:40 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502042214120.26842@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxEMV-0005K0-Kj
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 17:03:47 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CxEMS-0001h3-WF
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 17:03:47 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Hi!
	I have been busy with some new patches. Hold off on the cfb_imageblit
    patch. I'm working on a better one. Of the things I discovered is that not
    all graphics hardware can do 32 bit writes to the framebuffer. For example
    the Epson135X chipsets have this problem. Only 16 bit writes/reads. So I
    have been working on making cfb_imageblit be able to do 8/16/32 writes/reads
    to the framebuffer. So far I have managed to get the color image working
    for most conditions. Unfortunely it doesn't work for the case where the pixel
    is larger than the allowed write/read.
        The second issue I have been pondering is what to do exactly with
    struct fb_pixmap. Its not really clear what its totally functionality
    could be to alot of people. Originally it was designed to deal with
    padding scan lines of images to and/or padding image data at the end so 
    hardware accel engines could handle the data directly inside the hardware
    drivers acceleration functions.
    	Now I have been viewing it as a layer just above the lowest level of 
    access. It still would do the above functions plus more. I'm purposing
    creating a list of struct pixmap's for struct fb_info. Right now we have
    pixmap and sprite. No one at the present uses sprite. So instead we have 
    the link list instead. We would create the default one which is the 
    scratch pad for fb_con. It could be used else where as well. I also like to
    create a second one for the framebuffer itself. Doing this we could:

	1. Move screen_base and screen_size into struct fb_pixmap.
	2. Get ride of the fb_writes and fb_reads with inbuf, outbuf.

    So what do you think?

	The other thing I have been working on is real sysfs support. So far I 
    brought it back and made it functional. You can also get the name of the device
    also which can replace /proc/fb. I have been attempting to figure out how to
    handle the mode database. How should it be displayed in the tree?
    


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
