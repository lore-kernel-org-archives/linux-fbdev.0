From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tridentfb: replace macros with
	functions
Date: Fri, 2 May 2008 05:38:56 -0700
Message-ID: <20080502053856.804983db.akpm@linux-foundation.org>
References: <481add6589c4d@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JruXd-0003gu-Uo for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 May 2008 05:39:10 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JruXc-000504-L8
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 May 2008 05:39:09 -0700
In-Reply-To: <481add6589c4d@wp.pl>
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
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 02 May 2008 11:22:45 +0200 "Krzysztof Helt" <krzysztof.h1@wp.pl> wrote:

> This patch replaces macros with static functions and
> puts tridentfb_par pointer as the first argument of
> these functions. These is a step toward multihead
> support.
> 
> Additionally, bogus TRIDENT_MMIO define is removed as
> the driver supports graphics cards only through the mmio mode.

Something went wrong here..

drivers/video/tridentfb.c: In function 'tridentfb_fillrect':
drivers/video/tridentfb.c:518: warning: passing argument 1 of 'acc->fill_rect' makes pointer from integer without a cast
drivers/video/tridentfb.c:518: error: too few arguments to function 'acc->fill_rect'
drivers/video/tridentfb.c:519: error: too few arguments to function 'acc->wait_engine'
drivers/video/tridentfb.c: In function 'tridentfb_copyarea':
drivers/video/tridentfb.c:524: warning: passing argument 1 of 'acc->copy_rect' makes pointer from integer without a cast
drivers/video/tridentfb.c:524: error: too few arguments to function 'acc->copy_rect'
drivers/video/tridentfb.c:525: error: too few arguments to function 'acc->wait_engine'
drivers/video/tridentfb.c: In function 'tridentfb_set_par':
drivers/video/tridentfb.c:1018: warning: passing argument 1 of 'acc->init_accel' makes pointer from integer without a cast
drivers/video/tridentfb.c:1018: error: too few arguments to function 'acc->init_accel'


Also, checkpatch says

ERROR: "(foo*)" should be "(foo *)"
#863: FILE: drivers/video/tridentfb.c:1123:
+       struct tridentfb_par *par = (struct tridentfb_par*)info->par;

ERROR: "(foo*)" should be "(foo *)"
#887: FILE: drivers/video/tridentfb.c:1160:
+       struct tridentfb_par *par = (struct tridentfb_par*)info->par;

which is easily fixed by just removing the unneeded typecasts of void*.


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
