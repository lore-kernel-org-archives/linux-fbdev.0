From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Opinions about YUV framebuffers
Date: Sun, 7 Aug 2005 11:58:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508071153170.31010@gorilla.sonytel.be>
References: <ba2a6a4405080700015bfebaed@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1i03-0004i1-DT
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 03:03:23 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1i02-0006FL-Vm
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 03:03:23 -0700
Received: from gorilla.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j77A3Lva005954
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 7 Aug 2005 12:03:21 +0200 (MEST)
In-Reply-To: <ba2a6a4405080700015bfebaed@mail.gmail.com>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 7 Aug 2005, Nishant Kamat wrote:
> I'd like to solicit some opinions about using the fbdev API for a
> display controller that accepts data in YUV format. fbcon seems to be

Just add an additional #define FB_VISUAL_* for your YUV format to <linux/fb.h>.
Been there, done that.

> written to work only for RGB framebuffers. Is that correct? Would it

In 2.6, if you provide an fb_imageblit() routine that converts from 256 color
CLUT to YUV, you should have a text console and a penguin.

In 2.4, getting a text console (and penguin) on YUV is much more work.

> require lot of change to make it work with YUV data? Can X be run on
> YUV framebuffers?

I'm afraid X doesn't support YUV yet.

But if you use the shadow buffer feature in recent X code, you can run the X
server in e.g. RGB565 or RGB888, and write an update routine to convert a
rectangular area from RGB565 resp. RGB888 to YUV. After that you'll have X
running.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
