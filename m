From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Building fbtest impossible
Date: Tue, 31 Aug 2004 10:32:55 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0408311031580.22665@waterleaf.sonytel.be>
References: <41338DD3.26D693AA@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C244v-0005it-6e
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 31 Aug 2004 01:33:21 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C244c-0004aN-BQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 31 Aug 2004 01:33:18 -0700
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i7V8WtMp012970
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 31 Aug 2004 10:32:55 +0200 (MEST)
In-Reply-To: <41338DD3.26D693AA@orpatec.ch>
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
To: 'linux-fbdev-devel' <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 30 Aug 2004, Otto Wyss wrote:
> The fbtest app can't be build, I always gets the following errors:
>
> ld -r -o tests.o test001.o test002.o test003.o test004.o test005.o
> test006.o test007.o test008.o test009.o test010.o
> make[1]: Leaving directory `/usr/src/Devel/fbtest/tests'
> pnmtohex.c:17:17: pnm.h: No such file or directory
> make[1]: *** [.depend] Error 1
> /bin/sh: line 1: ../pnmtohex/pnmtohex: No such file or directory
> make[1]: *** [penguin.c] Error 127
> make: *** No rule to make target `images/images.o', needed by `fbtest'.  Stop.
>
> Where is pnm.h?

apt-get install libnetpbm10-dev

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
