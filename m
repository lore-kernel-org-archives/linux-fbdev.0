From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: [PATCH] mach64 atari patch
Date: Tue, 09 Aug 2005 07:55:58 +0800
Message-ID: <42F7F10E.7080700@gmail.com>
References: <Pine.LNX.4.56.0508070315260.12196@pentafluge.infradead.org>  <Pine.LNX.4.62.0508071316230.31010@gorilla.sonytel.be>  <20050807094618.0cc4cadc.akpm@osdl.org>  <Pine.LNX.4.56.0508080003360.12912@pentafluge.infradead.org>  <42F699DC.20103@gmail.com> <9e47339105080716487e59df5c@mail.gmail.com>  <Pine.LNX.4.56.0508081827550.27739@pentafluge.infradead.org> <9e4733910508081056714061fe@mail.gmail.com> <Pine.LNX.4.56.0508081907150.27739@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2dvk-0005F9-N6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 16:54:48 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E2dvj-0005zY-IM
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 16:54:48 -0700
Received: from wproxy.gmail.com ([64.233.184.198])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1E2SSD-0008Ca-UC
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 04:39:34 -0700
Received: by wproxy.gmail.com with SMTP id i17so738144wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Aug 2005 04:39:28 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0508081907150.27739@pentafluge.infradead.org>
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
Cc: Jon Smirl <jonsmirl@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>

James Simmons wrote:
>>>> I just don't think this patch is as complex as you are making it out
>>>> to be. It is large simply because the same action has been repeated
>>>> for each of the 65 drivers. The action is only a simple deletion of
>>>> two lines.
>>> I'm not arguing over this. What is wrong with breaking this patch up!!!!!
>>> I still have no answer to this!!!! I'm using the hardware flag because
>>> sometimes the driver that does have a hardware cursor wants to turn
>>> support off for it.
>> Set  .fb_cursor = NULL; to turn off the support.
> 
> So forbid hardware drivers that support hware cursors to never turn off 
> there hardware cursor support!!!!!
> 
> Let see what drivers have a flag to control using the hardware cursor.
> 
> au1100fb	int nohwcursor
> intelfb		int hwcursor
> nvidia		int hwcur
> cyberfb
> 
> You need to remove this!!!!
>

Majority of the drivers that does support hardware cursors are written by myself.
If the driver does not want to turn on the hardware cursor, just return -ENODEV.
No need to fudge with pointers.

Tony 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
