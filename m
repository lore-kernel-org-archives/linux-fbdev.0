From: Clint Adams <schizo@debian.org>
Subject: Re: Bug#226973: xserver-xfree86: [glint] second card at wrong resolution
Date: Thu, 15 Jan 2004 16:55:24 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040115215524.GA656@scowler.net>
References: <20040109163119.GA10151@scowler.net> <20040112121558.GA24511@iliana> <20040112215543.GB2150@scowler.net> <20040113074158.GF4863@iliana> <20040113154025.GA12817@scowler.net> <20040113160221.GA12752@iliana> <20040114211246.GA31567@scowler.net> <20040114211643.GA6793@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhFSY-00079P-Vv
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Jan 2004 13:55:26 -0800
Received: from acolyte.scowler.net ([216.254.112.142])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AhFSY-0006Zv-Me
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Jan 2004 13:55:26 -0800
Content-Disposition: inline
In-Reply-To: <20040114211643.GA6793@iliana>
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
Content-Transfer-Encoding: 7bit
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: 226973@bugs.debian.org, linux-fbdev-devel@lists.sourceforge.net

> This will not help, X things everything is ok, it is just the graphic
> card output which is problematic. No way to find it in the log, you have
> to look at the way the graphic output registers are programmed. 
> 
> Look at the pm2_dac.c stuff.

Well, I haven't gotten as far as dumping the registers, but I came
across Permedia2VPreInit in pm2v_dac.c, and forced it to call
Permedia2VPreInitSecondary(pScrn) unconditionally.

I also changed a few things seemingly related to linux-kernel-headers to
get the thing to compile, and it improved the situation.  Now there is a
mild amount of distortion and flicker.  The really bad part is that if I
drag an open window, it will turn into a block of noise, somewhat
related to the colors of the root window.  Also, X now detects 8 megs of
memory on that card.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
