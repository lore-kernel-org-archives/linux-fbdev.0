From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: fbdev broken in current bk for PPC
Date: Fri, 10 Sep 2004 16:35:25 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409101635.25738.adaplas@hotpop.com>
References: <1094783022.2667.106.camel@gaston> <1094796002.14398.118.camel@gaston> <Pine.GSO.4.58.0409101004320.93@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5guI-0006Xo-So
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Sep 2004 01:37:22 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C5guG-0004MK-1b
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Sep 2004 01:37:21 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 7B4BB10D8CA8
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Sep 2004 08:34:05 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.58.0409101004320.93@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Friday 10 September 2004 16:07, Geert Uytterhoeven wrote:
> On Fri, 10 Sep 2004, Benjamin Herrenschmidt wrote:
> > I submited a patch moving offb to the bottom of the Makefile to at
> > least restore normal drivers. For ofonly, a bit more hackish, but
>
> Just in case they aren't, vesafb and vga16fb should also be at the bottom,
> cfr. the old order in fbmem.c.
>

They are, with vfb at the very last.

> > what about failing register_framebuffer for anything but offb ?
>
> Humm, indeed hackerish...
>
> But the advantage of this is that we can finally exercise the failure path
> of many frame buffer device drivers in the wild ;-)
>

Assuming, as I've mentioned in another thread, that info->fix.name ==
to video=xxxfb.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
