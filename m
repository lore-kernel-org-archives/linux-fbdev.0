From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: 2.6.7 still garbage upon start
Date: Sun, 20 Jun 2004 04:25:55 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406200425.55142.adaplas@hotpop.com>
References: <40D21E31.5070904@winischhofer.net> <200406190240.31144.adaplas@hotpop.com> <40D4938E.6090406@undead.cc>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbmOy-0002yr-Ju
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 13:25:24 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BbmOy-0003bv-A0
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 13:25:24 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id C488161E2E6
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Jun 2004 19:46:27 +0000 (UTC)
In-Reply-To: <40D4938E.6090406@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Winischhofer <thomas@winischhofer.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sunday 20 June 2004 03:27, John Zielinski wrote:
> Antonino A. Daplas wrote:
> >1. Solution: Move this set_par call to fbcon_init instead.
>
> One thing I just noticed about your patch, if we move the set_par
> shouldn't the vc_resize move with it?
>

I tried it and the white rectangle returned.  Not so sure of the reason, but 
it seems that calling vc_resize while in fbcon_startup() will involve vgacon, 
not fbdev.  By the time we reach fbcon_init(), the vc's dimension already 
matches that of fbdev so fbcon_resize is not called.   On the other hand, 
moving vc_resize to fbcon_init will force a call to fbcon_resize.  Maybe an 
early call to  fbcon_resize is partly the reason for the white rectangle..., 
again not sure.

Tony  




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
