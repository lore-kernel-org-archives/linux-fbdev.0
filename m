From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Missing radeonfb_setup
Date: Wed, 29 Oct 2003 10:19:22 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0310291018490.10663-100000@waterleaf.sonytel.be>
References: <20031028185559.384201ff.jvillavicencio@arnet.com.ar>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEmUD-00006I-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 01:19:29 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AEmUD-0007eE-BO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 29 Oct 2003 01:19:29 -0800
In-Reply-To: <20031028185559.384201ff.jvillavicencio@arnet.com.ar>
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
To: Javier Villavicencio <jvillavicencio@arnet.com.ar>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 28 Oct 2003, Javier Villavicencio wrote:
> Simple patch to the new radeon fb driver to make it set modes/resolutions,
> and take the other parameters.
> Extracted some code from the matroxfb driver. Added radeonfb_setup function.

If you bother to change the initialization of radeonfb_default_var, please also
convert it to C99 struct unitializers, so you don't need the comments.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
