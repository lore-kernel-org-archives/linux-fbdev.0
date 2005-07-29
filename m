From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fixing fbdev for various framebuffer configs
Date: Fri, 29 Jul 2005 13:21:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0507291317080.5335@numbat.sonytel.be>
References: <9e473391050729035370d76cc5@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyT1W-0000r9-P5
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 04:27:30 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DyT1V-0008VN-9b
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 04:27:30 -0700
In-Reply-To: <9e473391050729035370d76cc5@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>, James Simmons <jsimmons@infradead.org>

On Fri, 29 Jul 2005, Jon Smirl wrote:
> It has been determined that bits per pixel is insuffucient to
> enumerate all the needed fbconfigs. Here are the possible fgconfigs
> from the OpenGL headers:
> 
> total bits 
> 8     GL_R3_G3_B2
> 8     GL_RGBA2
> 12   GL_RGB4
> 15   GL_RGB5
> 16   GL_R5_G6_B5
> 16   GL_RGBA4
> 16   GL_RGB5_A1
> 24   GL_RGB8
> 30   GL_RGB10
> 32   GL_RGBA8
> 32   GL_RGB10_A2
> 36   GL_RGB12
> 48   GL_RGB16
> 48   GL_RGBA12
> 64   GL_RGBA16

All above (and many more) can be handled fine, cfr.
fb_var_screeninfo.{red,green,blue,transp}.

> 48   GL_FLOAT_RGB16
> 64   GL_FLOAT_RGBA16
> 96   GL_FLOAT_RGB32
> 128 GL_FLOAT_RGBA32
>
> We need to be able to set any of these through the fbdev interface. We
> also need to allow for possible future expansion.
> 
> Ideas on how to adjust the fbdev interface?

Floating point pixel values could be handled by a new nonstd flag:

    #define FB_NONSTD_FLOAT	2
    fb_var_screeninfo.nonstd |= FB_NONSTD_FLOAT

> What is the effect of alpha bits on the scanout buffer, do they do anything?

They determine the transparency of the pixel w.r.t. to the underlying plane, if
the hardware supports it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
