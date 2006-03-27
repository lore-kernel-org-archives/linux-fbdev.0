From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: funny framebuffer fonts on PowerBook with radeonfb
Date: Mon, 27 Mar 2006 12:17:21 +1100
Message-ID: <1143422242.3589.2.camel@localhost.localdomain>
References: <20060327004741.GA19187@MAIL.13thfloor.at>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNgNi-0007Zf-26
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Mar 2006 17:18:54 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FNgNf-0005Cy-JT
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Mar 2006 17:18:54 -0800
In-Reply-To: <20060327004741.GA19187@MAIL.13thfloor.at>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel ML <linux-kernel@vger.kernel.org>

On Mon, 2006-03-27 at 02:47 +0200, Herbert Poetzl wrote:
> Hey Ben!
> 
> 2.6.16 and 2.6.15-something show a funny behaviour
> when using the radeonfb driver (for text mode), they
> kind of twist and break the fonts in various places
> some characters or parts seem to be mirrored like
> '[' becoming ']' but not on character boundary but
> more on N pixels, colors seem to be correct for the
> characters, and sometimes the font is perfectly fine
> for larger runs, e.g. I can read the logon prompt
> fine, but everything I type is garbled ...
> 
> just for an example, when I type 'echo "Test"' then
> all characters are mirrored and cut off on the right
> side but the locations are as shown above, on enter
> the T is only a few pixels wide, but the est part is
> written perfectly fine ... this is a new behaviour
> and going back to 2.6.13.3 doesn't show this ...
> 
> if there is some testing I can do for you, or when
> you need more info, please let me know. here a few
> details for the machine:

I have a similar machine and haven't seen such a problem with it so
far ... does this happen after you load X or already at boot before X
ever kicks in ? Does it happen if you don't load any font (that is for
example boot with init=/bin/sh to prevent any init script to try to load
a font)

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
