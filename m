From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] radeonfb: copyarea() "memmove()"
 problem
Date: Mon, 29 Mar 2004 17:49:40 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0403291748320.19888@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0403291709020.2356@rosencrantz.theboonies.us>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7z1H-0004mO-RZ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Mar 2004 07:49:47 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B7z1F-0004Qo-1n
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Mar 2004 07:49:45 -0800
In-Reply-To: <Pine.LNX.4.58.0403291709020.2356@rosencrantz.theboonies.us>
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
To: David Eger <eger-dated-1081179398.a664d4@theboonies.us>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

	Hi David,

On Mon, 29 Mar 2004, David Eger wrote:
> Now that my local kernel actually calls copyarea(), I see that my code was
> buggy... That is, the hardware needs to be told which way to do its memory
> copies if areas overlap.  Think of memmove() versus memcpy().
> Attached is the fix.

Do you know if there's a noticable performance difference between forward and
backward copies? If yes, you may want to check whether the areas really overlap
instead of testing their relative positions.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
