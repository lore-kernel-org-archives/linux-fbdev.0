From: Jakub Bogusz <qboosh@pld-linux.org>
Subject: Re: [PATCH 2.6][RESEND] fbcon margins colour fix
Date: Thu, 18 Mar 2004 10:37:15 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040318093715.GB17838@gruby.cs.net.pl>
References: <20040317233135.GB3510@satan.blackhosts> <Pine.GSO.4.58.0403181020320.10688@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3ty2-0001Dd-0O
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Mar 2004 01:37:34 -0800
Received: from gruby.cs.net.pl ([62.233.142.99] ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B3txy-00024p-En
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Mar 2004 01:37:31 -0800
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0403181020320.10688@waterleaf.sonytel.be>
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
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Mar 18, 2004 at 10:21:31AM +0100, Geert Uytterhoeven wrote:
> On Thu, 18 Mar 2004, Jakub Bogusz wrote:
> > I sent it a few times to linux-kernel and at least one to
> > linux-fbdev-devel, but haven't seen any comments - and this annoying
> > changing margins colour seems to be still there in 2.6.4 (at least on
> > tdfxfb).
> 
> What happens on `reverse video' (i.e. black on white, like Sun) graphics cards?
> In that case the overscan color is white.

Uhm. What is palette entry for this white?
Or, more generally, how to find (palette colour number of) overscan
colour for current console?
Video erase character colour is not proper one as it may be different
even from background colour at the moment of vt switch.



-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
