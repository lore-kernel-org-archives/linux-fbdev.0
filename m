From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: aty128fb problems on iMac, kernel 2.8.1 (fwd)
Date: Thu, 23 Sep 2004 19:14:41 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409231914.41279.adaplas@hotpop.com>
References: <Pine.GSO.4.61.0409231022110.7127@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.12] (helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CARZJ-00017l-Qp
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Sep 2004 04:15:21 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CARZJ-0004Vx-FC
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Sep 2004 04:15:22 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id A3F23110A167
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Sep 2004 11:15:04 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.61.0409231022110.7127@waterleaf.sonytel.be>
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
To: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Theodore Kilgore <kilgota@banach.math.auburn.edu>

>
> mac_find_mode  undefined
>
> and
>
> mac_vmode_to_var  undefined.
>

Those functions are in macmodes.c but they are not exportable.

You can try changing this line in drivers/video/Makefile:

obj-$(CONFIG_FB_ATY128)           += aty128fb.o

to

obj-$(CONFIG_FB_ATY128)           += aty128fb.o macmodes.o

Possibly, you may need to remove these lines if the compile complains
of duplicate symbols:

# Only include macmodes.o if we have FB support and are PPC
ifeq ($(CONFIG_FB),y)
obj-$(CONFIG_PPC)                 += macmodes.o
endif

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
