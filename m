From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Benchmark and testprograms for fbdriver
Date: Thu, 25 Sep 2003 16:45:46 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0309251645200.6298-100000@vervain.sonytel.be>
References: <20030925142530.GA24106@zensonic.dk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2XOE-00083H-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 07:46:42 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A2XOC-0006Or-TH
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Sep 2003 07:46:41 -0700
In-Reply-To: <20030925142530.GA24106@zensonic.dk>
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
To: "Thomas S. Iversen" <zensonic@zensonic.dk>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 25 Sep 2003, Thomas S. Iversen wrote:
> Do any of you have any benchmark (performance of HW acceleration
> vs. software fallbacks) and test programs (to test cornercases to see
> if the driver hangs/fails) to test framebuffer device drivers?
> 
> It is the last step before I feel confident enough to release my driver!

For testing, you can check out module fbtest from CVS at SourceForge.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
