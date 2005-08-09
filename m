From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: [PATCH] mach64 atari patch
Date: Tue, 9 Aug 2005 01:04:14 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508090057460.2187@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0508070315260.12196@pentafluge.infradead.org>
 <Pine.LNX.4.62.0508071316230.31010@gorilla.sonytel.be>
 <20050807094618.0cc4cadc.akpm@osdl.org> <Pine.LNX.4.56.0508080003360.12912@pentafluge.infradead.org>
 <42F699DC.20103@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2IQJ-0006I7-CT
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 17:56:55 -0700
Received: from [213.146.154.40] (helo=pentafluge.infradead.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E2Hge-0003Rd-IU
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 17:09:45 -0700
In-Reply-To: <42F699DC.20103@gmail.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>


> Please, my patch (based from Jon's) is huge because it's removing > 200 lines
> and it's moving softcursor.c from drivers/video to drivers/video/console where
> it belongs. But it is _not_ intrusive.  In fact, the majority of the patch consists
> of a single logical change which removes the line below from each driver
> 
> - .fb_cursor = softcursor;
> 
> and removes the line below from drivers/video/Kconfig.
> 
> - select FB_SOFT_CURSOR
> 
> Our proposal aims to make complex code simpler and big code smaller. Your patch,
> on the other hand, although small, introduces another flag  FB_HWCURSOR_SOFTCURSOR,
> which is redundant, and adds yet another level of complexity to an already too
> complex code.

I ask you the same question as Jon. Currently several fbdev drivers have a 
optional flag to turn on and off the hardware cursor. Should this functionality
be removed and force all fbdev drivers to always have the hardware cursor 
avaiable. Thus leaving fbcon to control when to use the hardware cursor 
or the software cursor. It all comes down to who controls when the 
hardware driver will use the hardware cursor. As noted several drivers 
have such a flag. You would have to strip that flag out of the drivers as 
well.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
