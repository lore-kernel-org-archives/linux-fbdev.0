From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fbmem.c : FBIOGETCMAP
Date: 08 Jan 2003 11:49:19 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1041997586.927.80.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301072230180.17129-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W7QM-0008Ro-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 20:02:38 -0800
In-Reply-To: <Pine.LNX.4.44.0301072230180.17129-100000@phoenix.infradead.org>
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
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-01-08 at 06:37, James Simmons wrote:
> 
> > I can run the fb color map tests now if you had a
> > chance to fix the code.
> > 
> > I am just running fbtest from the sourceforge fb cvs.
> 
> I'm CC the fbdev list because the fb color map code is a mess. I like to 
> know what the best approach would be to clean it up.
> 
> FIrst the main bug. In fb_copy_cmap we should be testing to see if 
> copy_from[to]_user fails. We don't. The other issue is for fb_copy_cmap
> We handle memcpy, copy_from_user, and copy)to_user. Now in fb_set_cmap
> we use get_user also without any checks. 
> 
> So we could have fb_copy_cmap keep handling all these issues and remove 
> get_user from fb_set_cmap. We would just pass in fbcmap we got from 
> fb_copy_cmap and pass into fb_set_cmap. The other approach is to 
> remove copy_from_user in fb_copy_cmap and place it int fb_set_cmap. 
> 
> What do you think is the best approach to this?
> 
> 
I don't know, it looks okay to me except for the following:

1.  In case FBIOPUTCMAP, fb_set_cmap() must pass 1 (to imply get info
from user space).

2.  In case FBIOGETCMAP, fb_copy_cmap() must pass 2 (to imply copy cmap
from kernel space to user space)

3.  no checks when doing the user access functions (should have no
effect really, except for the extra processing).

I think fb_set_cmap() is a bit misleading.  It mostly implies set the hardware 
DAC based on the color information in fb_cmap.  fb_cmap is either in kernel 
space or user space.  There is no need to copy the actual cmap to kernel 
space and we just let the user app keep a copy of its own.

So fb_copy_cmap() is not necessary when doing an fb_set_cmap() because
you have to allocate memory for it, which has to be deallocated after
doing an fb_set_cmap().  We cannot use info->cmap because it might be of
different length, and it will clobber the console cmap.

The copy_from_user() of fb_copy_cmap() may not be needed unless we
have support for it.  If this is the case, then we have to find a way of
saving info->cmap first then allocate memory for the new cmap.  Then
deallocate the new cmap and restore the default cmap to info->cmap
afterwards.  You will need additional code for this. In any case, info->cmap
is driver-private anyway, and user apps have no business replacing
info->cmap with its own.

I think the main use of those 2 ioctls is this:

1. save kernel cmap by doing FBIOGETCMAP,
2. set hardware DAC based on user app's cmap using FBIOPUTCMAP,
3. upon exit of the app, restore hardware DAC by doing FBIOPUTCMAP using
the cmap taken from FBIOGETCMAP.

Tony 




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
