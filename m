From: James Simmons <jsimmons@infradead.org>
Subject: Re: aty support
Date: Wed, 4 Dec 2002 15:02:56 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0212041501300.1533-100000@maxwell.earthlink.net>
References: <20021201213508.GJ338@schottelius.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18JhjE-0005Lv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 04 Dec 2002 14:10:48 -0800
In-Reply-To: <20021201213508.GJ338@schottelius.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nico Schottelius <schottelius@wdt.de>
Cc: linux-fbdev-devel@lists.sourceforge.net


> Can you tell me,
>
>    a) is my chipset compatible with the atyfb/aty128fb driver ?

atyfb

>    b) what todo exactly to get it working ?
>    (i know howto compile kernel, patch around code,...
>    what I need are informations, whether
>    append="video=aty128fb:accel,<640x480@8bpp>"
>    or
>    append="video=atyfb:<800x600-16bpp>"
>
>    are correct, whether to pass vga= options to the kernel
>    is senseful and so on...)

Can you try my patch at

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
