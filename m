From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: fb_imageblit semantic
Date: Thu, 13 Mar 2003 23:23:40 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030313222340.GB23719@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org> <20030220150201.GD13507@codemonkey.org.uk> <20030220182941.GK14445@vana.vc.cvut.cz> <1045787031.2051.9.camel@localhost.localdomain> <20030303203500.GA2916@vana.vc.cvut.cz> <20030304212906.GA1115@middle.of.nowhere> <20030309212903.GC16578@vana.vc.cvut.cz> <1047248782.1208.45.camel@localhost.localdomain> <20030309225455.GD16578@vana.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from vana.vc.cvut.cz ([147.32.240.58] ident=root)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18tb79-0005v0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Mar 2003 14:23:51 -0800
Content-Disposition: inline
In-Reply-To: <20030309225455.GD16578@vana.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jsimmons@infradead.org
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi James,
  after I spent two hours trying to find why my accelerated
fb_imageblit oopses (or paints garbage) when painting logo 
for bpp != 8 I have one simple question for you:

Why do you pass image.depth == 16 (or 24 or 32) to fb_imageblit
when logo image is in reality always 8bpp, as quick look at 
cfb_imageblit revealed?

Should I just assume that image.depth == 1 means that data are
1bpp with fgcol/bgcol valid, and all other depths mean 8bpp
input?
				Thanks,
					Petr Vandrovec
					vandrove@vc.cvut.cz


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
