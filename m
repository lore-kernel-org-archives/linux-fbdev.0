From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: fbcon VT (mode) switching issue
Date: Wed, 28 Apr 2004 08:49:30 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200404280846.13888.adaplas@pol.net>
References: <10040.159.37.7.44.1083099594.squirrel@www.foogod.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIdGR-0008UK-Jw
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:49:27 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BIdGR-0002Ir-87
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:49:27 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 19B5C3B4467
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Apr 2004 00:25:44 +0000 (UTC)
In-Reply-To: <10040.159.37.7.44.1083099594.squirrel@www.foogod.com>
Content-Disposition: inline
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
To: Alex Stewart <alex@foogod.com>, linux-fbdev-devel@lists.sourceforge.net

On Wednesday 28 April 2004 04:59, Alex Stewart wrote:
> I'm still trying to sort out a few of the little "annoyance" issues still
> present in the neofb driver.  One of these is the following:
>
> If I change VT from XFree86 (using its own neomagic driver, not through
> fb) to a framebuffer console, and the resolution/bitdepth of the console
> screen is different from what the X server was using, the screen is not
> initially repainted correctly.
>

That's because in 2.6, it's fbcon that decides if the hardware needs to be 
touched again (by calling set_par).  This decision is based on a compare 
between info->var and the var passed to fb_check_var.  If there's none, then 
set_par is not called.  So switching from X to the original console will not 
cause a change in var, so set_par is not called (incorrectly).

There are several solutions:

1. 2.4 approach. Unconditionally call set_par in check_var. (In 2.4, drivers 
decide when to touch the hardware, not fbcon).

2. Find some kind of flag to indicate that hardware has been touched by other 
apps besides fbcon.  KD_TEXT and KD_GRAPHICS, as discussed in a previous 
thread, seems to be a good bet.

Tony





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
