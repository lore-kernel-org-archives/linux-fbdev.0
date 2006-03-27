From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: funny framebuffer fonts on PowerBook with radeonfb
Date: Mon, 27 Mar 2006 16:26:38 +1100
Message-ID: <1143437199.2221.3.camel@localhost.localdomain>
References: <20060327004741.GA19187@MAIL.13thfloor.at>
	 <1143422242.3589.2.camel@localhost.localdomain>
	 <20060327033743.GA19788@MAIL.13thfloor.at>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNkGw-0001kV-B9
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Mar 2006 21:28:10 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FNkGv-0002XC-Uk
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Mar 2006 21:28:10 -0800
In-Reply-To: <20060327033743.GA19788@MAIL.13thfloor.at>
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
Content-Type: text/plain; charset="us-ascii"
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel ML <linux-kernel@vger.kernel.org>, "Antonino A. Daplas" <adaplas@hotpop.com>

On Mon, 2006-03-27 at 05:37 +0200, Herbert Poetzl wrote:

> after that, the screen goes white for half a second
> and becomes black with a large terminal font on it
> (the one I get without framebuffer, I think), the
> text there is printed undistorted ... shortly after
> that, I get a flash, and the mode switches to a much
> smaller font (the final framebuffer font) and the
> kernel messages written there are already distorted.
> half a second later (or less) the penguin appears at
> the top area (undistorted), when the bootup is done
> I get the following prompt (which again is okay)
> 
> 	bash-2.05b#
> 
> typing anything there is distorted again ...

Hrm... this is a a pristine 2.6.16 without any patch applied ? Also,
what video chip revision do you have exactly ? (lspci will tell you)

> pressing enter several times leaves 'copies' of
> the caracters on the screen, forming vertical bars
> the prompt (bash) is now always fine, the copy one
> line above (as all the others) is distorted ...
> 
> note, the bootup is not much different with older
> kernels, except for the strange distortions ...
> 
> attached my kernel configuration, just in case
> it is related ...

# CONFIG_VGA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
CONFIG_FONTS=y
# CONFIG_FONT_8x8 is not set
# CONFIG_FONT_8x16 is not set
CONFIG_FONT_6x11=y
CONFIG_FONT_7x14=y
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_10x18 is not set

Interesting... I suspect there is an endian bug in the new font code
that hits odd sized fonts (or non-multiple-of-8 fonts). Can you try
enabling 8x8 and 8x16 instead of 6x11 and 7x14 fonts and tell me if
those work ?

Tony: If my suspition is confirmed, I think that's your call :)

Cheers,
Ben.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
