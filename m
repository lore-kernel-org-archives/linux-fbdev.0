From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: [PATCH] mach64 atari patch
Date: Mon, 8 Aug 2005 19:15:20 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508081907150.27739@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0508070315260.12196@pentafluge.infradead.org> 
 <Pine.LNX.4.62.0508071316230.31010@gorilla.sonytel.be> 
 <20050807094618.0cc4cadc.akpm@osdl.org>  <Pine.LNX.4.56.0508080003360.12912@pentafluge.infradead.org>
  <42F699DC.20103@gmail.com> <9e47339105080716487e59df5c@mail.gmail.com> 
 <Pine.LNX.4.56.0508081827550.27739@pentafluge.infradead.org>
 <9e4733910508081056714061fe@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2C9m-0004pm-KA
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 11:15:26 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E2C9l-0004ml-7n
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 11:15:26 -0700
In-Reply-To: <9e4733910508081056714061fe@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>


> > > I just don't think this patch is as complex as you are making it out
> > > to be. It is large simply because the same action has been repeated
> > > for each of the 65 drivers. The action is only a simple deletion of
> > > two lines.
> > 
> > I'm not arguing over this. What is wrong with breaking this patch up!!!!!
> > I still have no answer to this!!!! I'm using the hardware flag because
> > sometimes the driver that does have a hardware cursor wants to turn
> > support off for it.
> 
> Set  .fb_cursor = NULL; to turn off the support.

So forbid hardware drivers that support hware cursors to never turn off 
there hardware cursor support!!!!!

Let see what drivers have a flag to control using the hardware cursor.

au1100fb	int nohwcursor
intelfb		int hwcursor
nvidia		int hwcur
cyberfb

You need to remove this!!!!

What I am arguing is that drivers with hardware cursor support should be 
able to turn off and on hardware cursor support. That is why the 
HWACCEL_CURSOR flag. Your test the fb_cursor field prevents this!!!




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
