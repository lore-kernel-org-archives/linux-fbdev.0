From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: gen_set_var() fix?
Date: Wed, 28 Aug 2002 11:19:08 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0208281118280.19583-100000@vervain.sonytel.be>
References: <20020828121619.05a8bf02.jani@iv.ro>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17jyzf-0005de-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Aug 2002 02:20:07 -0700
In-Reply-To: <20020828121619.05a8bf02.jani@iv.ro>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Monoses <jani@iv.ro>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 28 Aug 2002, Jani Monoses wrote:
> so not having check_var implies we only support one video mode?

Yes. This is useful for e.g. handheld devices with LCDs, and for offb.

> > The original code is correct.  It means the driver supports only 1 video
> > mode, which is the current one in info->var.  

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
