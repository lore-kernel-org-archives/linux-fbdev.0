From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] EFI framebuffer on EFI X86_64
Date: Wed, 4 Jul 2007 18:54:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0707041850500.10749@anakin>
References: <1183585851.16719.36.camel@caritas-dev.intel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I687W-00041l-W8 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jul 2007 09:54:27 -0700
Received: from europa.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I687S-0005h3-E2
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jul 2007 09:54:26 -0700
In-Reply-To: <1183585851.16719.36.camel@caritas-dev.intel.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 4 Jul 2007, Huang, Ying wrote:
> diff -uprN -X linux-2.6.21-orig/Documentation/dontdiff
> linux-2.6.21-orig/drivers/video/efifb.c
> linux-2.6.21-uefi-finaltest4/drivers/video/efifb.c

Your mail client seems to corrupt whitespace...

> +       //size_total = screen_info.lfb_size * 65536;

Please don't use C++-style comments. You can use scripts/checkpatch.pl
to perform some basic style checks on your patches.

> +#ifndef __i386__
> +       //screen_info.imacpm_seg = 0;
> +#endif

Superfluous block?

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
