From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: Re: [ PATCH-LINK ] fb accel capabilities - take 2
Date: Thu, 27 May 2004 22:38:08 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1085715488.40b6b42062e3c@mail.theboonies.us>
References: <40B691DF.4060509@winischhofer.net>
Reply-To: David Eger <eger-dated-1086320292.98e266@theboonies.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTYCG-0001ix-5B
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 May 2004 20:38:16 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BTYCF-0008MU-T1
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 May 2004 20:38:15 -0700
In-Reply-To: <40B691DF.4060509@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

Thomas Winischhofer eloquently put:
> David Eger wrote:
>  > If the patch looks good to you (James, Geert, BenH), I'd like to
>  > forward it on to Linus followed by the individual driver updates
>  > (that'll take a little longer -- I need to revise how drivers do
>  > things like remember noaccel, etc. and update them).
>
> How about properly documenting what you actually do and let the driver
> maintainer handle the implementation?

see the update to skeletonfb.c

> General question (not to you only): How about considering the 2.6 series
> as "stable" as everybody else does and keep it to fixing bugs instead of
> change the driver API the Xth time?


If you want to handle the fix for sisfb, please do, I'll skip over that one ;-)

It's all part of fixing bugs ;-)  When my "accelerated" fb driver is still
super-slow, i consider that a bug.  And it's a bug of the framebuffer
subsystem, not really of the drivers.  Your lovely
SiS310SubsequentScreenToScreenCopy() and friends (do I smell xfree86 code here?
;-) )  would probably work great if they were ever called.  Currently, they're
not :-P

The patch (a later version mailed to lkml against mainline) fixes an issue
discussed in a large thread previously.  The Linux 2.6 fbdriver/kernel
interface is opaque as to what hardware acceleration a video card *actually*
provides.  There are a bunch of entry-points, but they're often done by
software.  This patch fixes the framebuffer interface so that fbcon (currently
the only app that really lives on top of the fb subsystem) can sanely choose
its method of rendering.

-dte



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
