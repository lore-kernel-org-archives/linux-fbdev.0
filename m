From: Antonino Daplas <adaplas@pol.net>
Subject: RE: Adding an fb_sync() operation to fb_ops
Date: 04 Jun 2002 07:53:06 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1023148432.541.1.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17F1db-0004Dj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 03 Jun 2002 16:53:24 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Matthew J Sottek <matthew.j.sottek@intel.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2002-06-03 at 23:49, Sottek, Matthew J wrote:
> 
> So here is the obvious problem case.
> 
> Application mmap's the framebuffer.
> Application Draws some pixels into the framebuffer.
> Application issues an ioctl that would lead to a blit, the command is put
>  in a ring buffer but hasn't happened yet.
> The application draws some more pixels (via the mmap) in a region that
>  intersects the previously blitted region.
> The hardware gets around to the blit command and overwrites the pixels you
>   just put in the frambuffer.
> 
> 
And it does not have to happen outside the kernel.  Within the kernel
too.  For instance, a particular accelerator may only support fillrect
and copyarea, but not imageblit (neofb).  It has no choice but to mix in
cfb_imageblit and the sync problem will arise unless the accelerator
forces a sync -- which neofb does by the way.
  
Tony


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
