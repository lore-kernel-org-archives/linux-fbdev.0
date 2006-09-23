From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18 - vesafb unaiavilable if fbcon
	compiled as module
Date: Sat, 23 Sep 2006 01:44:23 -0700
Message-ID: <20060923014423.e57b2fae.akpm@osdl.org>
References: <200609231140.50220.arvidjaar@mail.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GR37b-0004y4-RE for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Sep 2006 01:44:27 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GR37a-00081q-HT
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Sep 2006 01:44:27 -0700
In-Reply-To: <200609231140.50220.arvidjaar@mail.ru>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: "Antonino A. Daplas" <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006 11:40:49 +0400
Andrey Borzenkov <arvidjaar@mail.ru> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Is it intentional? In Kconfig:
> 
> config FB_VESA
>         bool "VESA VGA graphics support"
>         depends on (FB = y) && X86
> 

cc's added.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
