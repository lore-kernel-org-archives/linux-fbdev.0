From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: [PATCH] 2.5.24 matroxfb memory corruption
Date: Mon, 1 Jul 2002 10:12:49 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <afq2n7$if1$2@main.gmane.org>
References: <20020630002834.GG25118@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17P4jM-0003j7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 01 Jul 2002 10:12:52 -0700
In-Reply-To: <20020630002834.GG25118@ppc.vc.cvut.cz>
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net


> do_install_cmap(), he blindly changed also matroxfb, which happily
> uses fbcon.currcon == -1. This caused memory corruption because of
> memory before fb_display[] array was overwritten.
>   Default do_install_cmap() also installed invalid default color map
> in some matroxfb resolutions. Not all world have >= 4bpp.

Applied to BK tree.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
