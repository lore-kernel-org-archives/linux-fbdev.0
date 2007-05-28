From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 8/9] fbdev: Detect primary display
 device
Date: Mon, 28 May 2007 10:37:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705281037080.4790@anakin>
References: <465952CD.2040409@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hsajo-0002AD-2I for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 May 2007 01:38:00 -0700
Received: from asia.telenet-ops.be ([195.130.137.74])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hsajm-0002Gn-Lu
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 May 2007 01:38:00 -0700
In-Reply-To: <465952CD.2040409@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

On Sun, 27 May 2007, Antonino A. Daplas wrote:
> Add function helper, fb_is_display_device().  Given struct fb_info, it will
                             ^^^^^^^
			     primary

> return a nonzero value if the device is the primary display.

> +static inline int fb_is_primary_device(struct fb_screeninfo *info)
                                                 ^^^^^^^^^^^^^
						 fb_info

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
