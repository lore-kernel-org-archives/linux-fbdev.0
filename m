From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fbcursor warning in 2.6.6-rc3
Date: Wed, 28 Apr 2004 15:36:44 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404281535040.3644@waterleaf.sonytel.be>
References: <Pine.GSO.4.44.0404281221150.24906-100000@math.ut.ee>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIpGs-00013c-TG
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 06:38:42 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIpGp-0008Ky-9f
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 06:38:39 -0700
In-Reply-To: <Pine.GSO.4.44.0404281221150.24906-100000@math.ut.ee>
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
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 28 Apr 2004, Meelis Roos wrote:
> This is 2.6.6-rc3 and I get the following warning on several
> architectures:
>
>   CC      drivers/video/fbmem.o
> drivers/video/fbmem.c: In function `fb_cursor':
> drivers/video/fbmem.c:917: warning: passing arg 1 of `copy_from_user' discards qualifiers from pointer target type
>
> The code is
> if (copy_from_user(cursor.image.data, sprite->image.data, size) ||
>
> cursor.image.data is const char *. Since copy_from_user actually changes
> that, we should probably cast it manually:

    [...]

Yep, that's the fix I have in my local tree as well. However, I'm not 100%
satisfied with it (I do like const, but hate superfluous casts).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
