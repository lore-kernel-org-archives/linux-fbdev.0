From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: Linux 2.5.69
Date: Wed, 7 May 2003 21:44:08 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0305072138510.12013-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19DUsF-0005xU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 07 May 2003 12:46:43 -0700
In-Reply-To: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
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
To: Ben Collins <bcollins@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Sun, 4 May 2003, Linus Torvalds wrote:
> Summary of changes from v2.5.68 to v2.5.69
> ============================================
> 
> Ben Collins:
>   o [VIDEO]: Revert cfbimgblt.c back to a working state on 64-bit
>   o [VIDEO]: Revert atyfb back to known working clean base

For future changes, could you please run these `reversals' through 
linux-fbdev-devel, instead of silently passing them behind our backs? Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
