From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: linux 2.6.21-rc1 : FB Kconfig error
Date: Fri, 23 Feb 2007 23:44:32 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0702232343330.14457@scrub.home>
References: <200702210946.27758.toralf.foerster@gmx.de>
	<Pine.LNX.4.62.0702211102000.340@pademelon.sonytel.be>
	<Pine.LNX.4.64.0702211238400.14457@scrub.home>
	<Pine.LNX.4.62.0702211322350.340@pademelon.sonytel.be>
	<Pine.LNX.4.64.0702220052020.14457@scrub.home>
	<Pine.LNX.4.62.0702221854520.25919@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKjAa-0006fM-8N for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Feb 2007 14:45:40 -0800
Received: from scrub.xs4all.nl ([194.109.195.176] ident=mail)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKjAY-0004Xw-Pj
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Feb 2007 14:45:40 -0800
In-Reply-To: <Pine.LNX.4.62.0702221854520.25919@pademelon.sonytel.be>
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Geoff Levand <geoffrey.levand@am.sony.com>, =?UTF-8?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>

Hi,

On Thu, 22 Feb 2007, Geert Uytterhoeven wrote:

> Like this?
> 
> Subject: ps3: Introduce CONFIG_PS3_ADVANCED

Looks good.

> --- ps3-linux-2.6.21-rc1.orig/arch/powerpc/platforms/ps3/Kconfig
> +++ ps3-linux-2.6.21-rc1/arch/powerpc/platforms/ps3/Kconfig
> @@ -1,9 +1,25 @@
>  menu "PS3 Platform Options"
>  	depends on PPC_PS3
>  
> +config PS3_ADVANCED
> +	depends on PPC_PS3
> +	bool "PS3 Advanced configuration options"
> +	default n

except that this default is not really necessary.

bye, Roman

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
