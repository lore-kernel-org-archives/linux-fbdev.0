From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: [PATCH] mach64 atari patch
Date: Mon, 08 Aug 2005 07:31:40 +0800
Message-ID: <42F699DC.20103@gmail.com>
References: <Pine.LNX.4.56.0508070315260.12196@pentafluge.infradead.org> <Pine.LNX.4.62.0508071316230.31010@gorilla.sonytel.be> <20050807094618.0cc4cadc.akpm@osdl.org> <Pine.LNX.4.56.0508080003360.12912@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1ucG-0006mz-U5
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 16:31:40 -0700
Received: from wproxy.gmail.com ([64.233.184.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1ucE-0001Fh-KU
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 16:31:41 -0700
Received: by wproxy.gmail.com with SMTP id i5so679558wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 16:31:32 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0508080003360.12912@pentafluge.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>

James Simmons wrote:
> 
>> I'll also drop fbdev-dont-allow-softcursor-use-from-userland.patch as there
>> seems to be quite a bit of controversy there.
> 
> The disagreement was how much to change it at one time. Some patches where 
> just huge and did massive changes to all drivers. I wanted to break the patch 
> up into little pieces. Please apply this patch otherwise we will be stuck 
> where we are. 
> 

Please, my patch (based from Jon's) is huge because it's removing > 200 lines
and it's moving softcursor.c from drivers/video to drivers/video/console where
it belongs. But it is _not_ intrusive.  In fact, the majority of the patch consists
of a single logical change which removes the line below from each driver

- .fb_cursor = softcursor;

and removes the line below from drivers/video/Kconfig.

- select FB_SOFT_CURSOR

Our proposal aims to make complex code simpler and big code smaller. Your patch,
on the other hand, although small, introduces another flag  FB_HWCURSOR_SOFTCURSOR,
which is redundant, and adds yet another level of complexity to an already too
complex code.

I already have the patch, but I'm not pushing it yet because of an ongoing
disagreement, in courtesy to other developers such as yourself.

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
