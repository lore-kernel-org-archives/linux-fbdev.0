From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: Framebuffer console not working with
 matroxfb on 2.6
Date: Fri, 17 Sep 2004 11:53:13 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0409171151540.19914@waterleaf.sonytel.be>
References: <3B9599C3EB4@vcnet.vc.cvut.cz> <20040917085131.GQ18257@uvt316-2.ruk.cuni.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8FQc-0001d1-Ry
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Sep 2004 02:53:18 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C8FQb-0005Cn-7w
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Sep 2004 02:53:18 -0700
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i8H9rDMp020356
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Sep 2004 11:53:13 +0200 (MEST)
In-Reply-To: <20040917085131.GQ18257@uvt316-2.ruk.cuni.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 17 Sep 2004, Michal 'hramrach' Suchanek wrote:
> However, I still get a minor problem with the driver.
> When I switch between the default 640x480-60 mode and 1024x768-85 mode
> the 1024x768 gets interlaced, with completely different timings. I have
> to use fbset to restore it to 1024x768-85.

I think this is a `feature' of the new mode selection code. When I tried
booting my Radeon with `1024x768@100', I got 87 Hz interlaced...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
