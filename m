From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH]: image.depth fix to accomodate monochrome cards
Date: Wed, 12 Feb 2003 20:50:05 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302122037530.31435-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0302051602060.16681-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18j3q5-0006SY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Feb 2003 12:50:41 -0800
In-Reply-To: <Pine.GSO.4.21.0302051602060.16681-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > 1.  Changed meaning of image.depth.  If image.depth == 0, it flags for
> > color expansion, otherwise, it flags for image drawing (without color
> > expansion).  This change is to accomodate monochrome cards so they can
> > differentiate character drawing from logo drawing.
> 
> What's the status of this issue? Monochrome is still broken due to this.

Ug. There are a few issues left to deal with. 

1) The cursor issue. We need to add in the cusor ioctl call for people to 
use. Theortically there should be no issues with using soft_cursor with 
full color images with xxfb_imageblit. I like to see dest go away in 
struct fb_cursor. It's a matter of taking advantage of the upper console 
layer here. We shouldn't have any static variables in accel_cursor because 
if we have multiple cards we have problems. I plan to work on that.

2) Tileblits and stuff. I have been thinking about this and I really like 
to make it even more generic. We also have seperate buffers for textures 
for example which could also be used to draw fonts. The first thing is
allocating or retreiving memory space for where to store the images. 
Second is to draw it. I guess a index of position would be used.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
