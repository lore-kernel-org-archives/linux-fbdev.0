From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: Framebuffer console not working with matroxfb on 2.6
Date: Fri, 17 Sep 2004 21:38:28 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409172138.29021.adaplas@hotpop.com>
References: <3B9599C3EB4@vcnet.vc.cvut.cz> <200409171921.50273.adaplas@hotpop.com> <Pine.GSO.4.58.0409171349430.19914@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8IwS-0000Lj-7s
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Sep 2004 06:38:24 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C8IwR-0001ea-EU
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Sep 2004 06:38:24 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id CACCD10F9139
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Sep 2004 13:38:15 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.58.0409171349430.19914@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>, Antonino Daplas <adaplas@pol.net>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Friday 17 September 2004 19:50, Geert Uytterhoeven wrote:

> Modedb does have that mode! Before I've been using it for years on my PPC
> box.
>
> linux-2.6.8.1/drivers/video/modedb.c:
>
>     }, {
>         /* 1024x768 @ 100Hz, 80.21 kHz hsync */
>         NULL, 100, 1024, 768, 8658, 192, 32, 21, 3, 192, 10,
>         0, FB_VMODE_NONINTERLACED
>     }, {
>
> Gr{oetje,eeting}s,

Indeed it does.  So why didn't radeonfb not use the mode?  Is it a problem
with fb_find_mode() or radeonfb?

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
