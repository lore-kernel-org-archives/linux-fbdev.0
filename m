From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: new radeon code and
	acquire/release_console_sem()
Date: Sun, 14 Sep 2003 02:38:08 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1063499888.674.43.camel@gaston>
References: <20030914003406.4373.qmail@web14903.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yKuj-0004uO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 17:38:53 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19yKuj-0003EJ-2T
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Sep 2003 17:38:53 -0700
In-Reply-To: <20030914003406.4373.qmail@web14903.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Kronos <kronos@kronoz.cjb.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2003-09-14 at 02:34, Jon Smirl wrote:
> I get this from insmod:
> radeonfb: Unknown symbol release_console_sem

I think the problem is that the core kernel doesn't export it,
I'll look into this. I added the console sem stuff to all the
PM code (atyfb, aty128fb and radeonfb so far, chipsfb soon)
because I want to prevent any access while setting up the
chip for sleep

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
