From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: [PATCH]: image.depth fix to accomodate
	monochrome cards
Date: 13 Feb 2003 07:37:54 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045092922.5830.136.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0302122037530.31435-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18j6Rb-0003mi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Feb 2003 15:37:36 -0800
In-Reply-To: <Pine.LNX.4.44.0302122037530.31435-100000@phoenix.infradead.org>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-02-13 at 04:50, James Simmons wrote:
> 
> > > 1.  Changed meaning of image.depth.  If image.depth == 0, it flags for
> > > color expansion, otherwise, it flags for image drawing (without color
> > > expansion).  This change is to accomodate monochrome cards so they can
> > > differentiate character drawing from logo drawing.
> > 
> > What's the status of this issue? Monochrome is still broken due to this.
> 

How about assigning fb_image.{bg_color,fg_color} to -1 if not color
expanding?  Since the pseudo_palette will not exceed 255, this should be
safe.
 
> Ug. There are a few issues left to deal with. 
> 
> 1) The cursor issue. We need to add in the cusor ioctl call for people to 
> use. Theortically there should be no issues with using soft_cursor with 
> full color images with xxfb_imageblit. I like to see dest go away in 

In order to do this, fb_imageblit has to support transparency (using a
transparency bitmask).  Userland apps will rarely have rectangular mouse
cursor pointers.  Also, it will need to support ROP's invert and copy. 
This will break fb_imageblit.  

Also, we have to double-buffer what's underneath the cursor.

Tony



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
