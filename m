From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: TV Out control and Product selection.
Date: Tue, 20 Aug 2002 03:31:28 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020820013128.GF6988@ppc.vc.cvut.cz>
References: <C0D45ABB3F45D5118BBC00508BC292DBA94488@imgserv04>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from p042.as-l031.contactel.cz ([212.65.234.234] helo=ppc.vc.cvut.cz)
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17gxtM-0004HV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Aug 2002 18:33:09 -0700
Content-Disposition: inline
In-Reply-To: <C0D45ABB3F45D5118BBC00508BC292DBA94488@imgserv04>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Francis Reader <freader@imerge.co.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, Aug 19, 2002 at 03:52:49PM +0100, Francis Reader wrote:
> Is it me, or is it becoming extremley difficult to spec a card that supports
> one of the many fb drivers, AND allow you to control the "tv out"
> capabilities on board.

What you want to control?
 
> Most of the drivers I've come across allow you to control the TV Dacs
> through X, but have put very little effort in providing fb support for the
> same device.
> 
> ATI are refusing to talk due to IP issues with Macrovision, NVidia only
> support this functionality through the XFree driver, the SiS driver
> currently has no standard way of controlling this.

Matrox also refuses to document it... but because of Matrox refuses to
release docs for anything after G400, it is not big surprise. 

matroxfb from 2.5.32, or patches from 
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/*-tvo*.gz allow you
to use TVOut on G450/G550. TVOut on G400 is supported for years.

Patch from platan has an additional feature which allows you to change
brightness/contrast by using 'v4lctl -c /dev/fb0 bright ...'. matroxfb
supports only composite/svhs output, rgb scart is not supported without
changing sources.

Please note that G450/G550 hardware can do TV output only from /dev/fb1,
so you are limited to 15/16/32bpp, without gamma correction, and with
matroxfb also unaccelerated.
						Petr Vandrovec
						vandrove@vc.cvut.cz
							


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
