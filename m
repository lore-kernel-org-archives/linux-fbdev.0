From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Vesa Fbdev update.
Date: Sun, 25 Apr 2004 10:08:57 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404251007540.11039@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404250329200.15965-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BHp71-0001of-Eb
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 25 Apr 2004 12:16:23 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BHp71-0002Cb-26
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 25 Apr 2004 12:16:23 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.30)
	id 1BHlJP-0004vC-14
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 25 Apr 2004 08:12:55 -0700
In-Reply-To: <Pine.LNX.4.44.0404250329200.15965-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 25 Apr 2004, James Simmons wrote:
> This patch migrates the Vesa Framebuffer driver over to the
> framebuffer_alloc/framebuffer_release api. It also fixes the error
> handling paths. The mtrr issue that Geert brought up has been fixed.
> With your approval Geert, Ben please apply this patch.

> +	/* Set video size according to vram boot option */
> +	if (vram && vram * 1024 * 1024 != vesafb_fix.smem_len)
> +		vesafb_fix.smem_len = vram * 1024 * 1024;

The second part of the test can be removed. The rest looks OK to me.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
