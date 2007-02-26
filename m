From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH] ps3: Introduce CONFIG_PS3_ADVANCED
Date: Mon, 26 Feb 2007 08:35:10 -0800
Message-ID: <45E30C3E.80006@am.sony.com>
References: <200702210946.27758.toralf.foerster@gmx.de>
	<Pine.LNX.4.62.0702211102000.340@pademelon.sonytel.be>
	<Pine.LNX.4.64.0702211238400.14457@scrub.home>
	<Pine.LNX.4.62.0702211322350.340@pademelon.sonytel.be>
	<Pine.LNX.4.64.0702220052020.14457@scrub.home>
	<Pine.LNX.4.62.0702221854520.25919@pademelon.sonytel.be>
	<Pine.LNX.4.64.0702232343330.14457@scrub.home>
	<Pine.LNX.4.62.0702261644310.5716@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLip7-0001in-J0 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Feb 2007 08:35:37 -0800
Received: from outbound-fra.frontbridge.com ([62.209.45.174]
	helo=outbound4-fra-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HLip5-0007YN-LY
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Feb 2007 08:35:37 -0800
In-Reply-To: <Pine.LNX.4.62.0702261644310.5716@pademelon.sonytel.be>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Roman Zippel <zippel@linux-m68k.org>, =?UTF-8?B?77+9?= <toralf.foerster@gmx.de>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/PPC Development <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Andrew Morton <akpm@linux-foundation.org>

Geert Uytterhoeven wrote:
> ps3: Introduce CONFIG_PS3_ADVANCED, as suggested by Roman Zippel, and use it to
> control questions about PS3 subsystems that may not be obvious for the casual
> user.
> 
> This gets rid of the following warning on non-powerpc platforms:
> | drivers/video/Kconfig:1604:warning: 'select' used by config symbol 'FB_PS3' refer to undefined symbol 'PS3_PS3AV'

Please apply, fixes build warning in 2.6.21-rc1.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
