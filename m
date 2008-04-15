From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] OLPC: gxfb/lxfb: add DCON panel
 modes to framebuffer drivers
Date: Mon, 14 Apr 2008 18:21:12 -0700
Message-ID: <20080414182112.848bcb64.akpm@linux-foundation.org>
References: <20080414035302.794dcd7a@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JlZru-0006JI-EA for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 18:21:54 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JlZrs-0002v7-3z
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 18:21:54 -0700
In-Reply-To: <20080414035302.794dcd7a@ephemeral>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andres Salomon <dilinger@queued.net>
Cc: jordan.crouse@amd.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org, info-linux@geode.amd.com

On Mon, 14 Apr 2008 03:53:02 -0400 Andres Salomon <dilinger@queued.net> wrote:

> 
> Since there's no way to autodetect panel modes, we're forced to hardcode
> them in the driver and add a big fat #ifdef.  The OLPC DCON needs a
> specific mode line (at 1200x900).  This adds it to both gxfb and lxfb.
> 
> ...
>
> +static const struct fb_videomode gx_dcon_modedb[] __initdata = {
> +const struct fb_videomode olpc_dcon_modedb[] __initdata = {

include/linux/init.h:38 points out that `const' and `__initdata' should
not be mixed.

I forget which architecture/compiler versions explode when we do this.  But
it's not x86, iirc.

Still, it's poor form and, err, I don't immediately recall which tag we
_should_ use, and the comments in there are unhelpful.  It might be
__initconst, but that has exactly zero users.  Help.


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
