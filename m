From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 8/8] fbdev: Fix broken fb_blank() implementation.
Date: Mon, 8 Nov 2004 07:23:39 +0800
Message-ID: <200411080723.39722.adaplas@hotpop.com>
References: <200411080526.50550.adaplas@hotpop.com> <1099863581.10262.134.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQwO0-0005bN-UW
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 15:23:52 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CQwNz-00059r-Ky
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 15:23:52 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 6D4DF11BB9DD
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  7 Nov 2004 23:23:35 +0000 (UTC)
In-Reply-To: <1099863581.10262.134.camel@gaston>
Content-Disposition: inline
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Monday 08 November 2004 05:39, Benjamin Herrenschmidt wrote:
> On Mon, 2004-11-08 at 05:27 +0800, Antonino A. Daplas wrote:
> > This patch fixes some of the drivers' fb_blank() implementation which got
> > the usage of the VESA_* constants incorrectly and converts them to use
> > the new FB_BLANK-* constants.
> >
> > I'm not sure if what I did is correct for all drivers, so maintainers,
> > please review.
> >
> > (Note: For most of the drivers, FB_BLANK_NORMAL is treated as
> > FB_BLANK_UNBLANK, but returns a nonzero so fbcon wi
>
> I think that on laptops, FB_BLANK_NORMAL could lower the backlight to 0
> (without disabling the panel, which requires more time)... I'll look
> into this, in the meantime, your patch is fine.

Yes, I was not too sure what to do with FB_BLANK_NORMAL not just for drivers
with backlights, so I took the safe route (unblank but do a soft_blank).

>
> BTW, what is the current status, can we use msleep in blank yet ? I
> think we can still have unblank() called by printk at interrupt time
> right ? I'd like to msleep in there rather than playing my games with
> a timer ...
>

I'm not too sure about this, but I think so, it is world callable and is
called by bust_spinlocks() at least. What about putting fbcon_blank() in the
workqueue...? (Or perhaps unblank/blank_screen in vt.c, but the code
in vt.c is very fragile...)

Tony





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
