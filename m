From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 8/8] fbdev: Fix broken fb_blank() implementation.
Date: Mon, 08 Nov 2004 08:39:41 +1100
Message-ID: <1099863581.10262.134.camel@gaston>
References: <200411080526.50550.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQulz-00069u-La
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 13:40:31 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CQulx-0008U1-Ok
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 13:40:31 -0800
In-Reply-To: <200411080526.50550.adaplas@hotpop.com>
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
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2004-11-08 at 05:27 +0800, Antonino A. Daplas wrote:
> This patch fixes some of the drivers' fb_blank() implementation which got
> the usage of the VESA_* constants incorrectly and converts them to use the
> new FB_BLANK-* constants.
> 
> I'm not sure if what I did is correct for all drivers, so maintainers,
> please review.
> 
> (Note: For most of the drivers, FB_BLANK_NORMAL is treated as
> FB_BLANK_UNBLANK, but returns a nonzero so fbcon wi

I think that on laptops, FB_BLANK_NORMAL could lower the backlight to 0
(without disabling the panel, which requires more time)... I'll look
into this, in the meantime, your patch is fine.

BTW, what is the current status, can we use msleep in blank yet ? I
think we can still have unblank() called by printk at interrupt time
right ? I'd like to msleep in there rather than playing my games with
a timer ...

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
