From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: linux 2.6.21-rc1 : FB Kconfig error
Date: Thu, 22 Feb 2007 01:01:46 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0702220052020.14457@scrub.home>
References: <200702210946.27758.toralf.foerster@gmx.de>
	<Pine.LNX.4.62.0702211102000.340@pademelon.sonytel.be>
	<Pine.LNX.4.64.0702211238400.14457@scrub.home>
	<Pine.LNX.4.62.0702211322350.340@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK1Pe-0004pS-MH for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 16:02:18 -0800
Received: from scrub.xs4all.nl ([194.109.195.176] ident=mail)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HK1Pd-0007rl-6j
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 16:02:18 -0800
In-Reply-To: <Pine.LNX.4.62.0702211322350.340@pademelon.sonytel.be>
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
Cc: =?UTF-8?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Hi,

On Wed, 21 Feb 2007, Geert Uytterhoeven wrote:

> Why doesn't it obey dependencies?

It was initially created to any override dependencies.

> > In this case it looks like someone went a little overboard with the select 
> > usage. It looks like most of the PS3 options could be hidden behind an 
> > advanced option, then you can also use normal dependencies.
> 
> We wanted to have PS3FB and PS3SND (not yet submitted) to select PS3AV, so it
> gets enabled automatically. Else we need dependencies on things the user
> shouldn't really need to care about.
> 
> What other solution do you propose?

As I said most PS3 could be hidden behind a PS3_ADVANCED option and use 
normal dependencies for the rest. Normal users don't care about all 
the options and advanced users should know what they're doing.

bye, Roman

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
