From: Jens Axboe <axboe@suse.de>
Subject: Re: Framebuffer updates.
Date: Tue, 25 Mar 2003 19:20:43 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030325182043.GH30908@suse.de>
References: <Pine.LNX.4.33.0303251032320.4272-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from ns.virtualhost.dk
	([195.184.98.160] helo=virtualhost.dk ident=mail)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xtKE-0003B1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Mar 2003 10:39:06 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303251032320.4272-100000@maxwell.earthlink.net>
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, Mar 25 2003, James Simmons wrote:
> 
> As usually I have a patch avalaible at 
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
>  drivers/video/aty/aty128fb.c  |   16 +++++++---------
>  drivers/video/console/fbcon.c |    4 ++--
>  drivers/video/controlfb.c     |   18 +++---------------
>  drivers/video/platinumfb.c    |   28 ++++++++--------------------
>  drivers/video/radeonfb.c      |   10 ++++++++++
>  drivers/video/softcursor.c    |    2 +-
>  6 files changed, 31 insertions(+), 47 deletions(-)
> 
> The patch has updates for the ATI Rage 128, Control, and Platnium 
> framebuffer driver. The Radeon patch adds PLL times for the R* series of
> cards. Memory is now safe to allocate for the software cursor and inside 
> fbcon. There still are issues with syncing which cause the cursor on some 
> systems to become corrupt sometimes. 

-       data = kmalloc(size, GFP_KERNEL);
-       mask = kmalloc(size, GFP_KERNEL);
+       data = kmalloc(size, GFP_ATOMIC);
+       mask = kmalloc(size, GFP_ATOMIC);

        if (cursor->set & FB_CUR_SETSIZE) {
                memset(data, 0xff, size);


irk, you replaced GFP_KERNEL with GFP_ATOMIC, and even unconditionally
memset the return without even bothering to check if it succeeded or
not.

-- 
Jens Axboe



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
