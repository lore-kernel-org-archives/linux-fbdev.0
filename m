From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: linux 2.6.21-rc1 : FB Kconfig error
Date: Wed, 21 Feb 2007 13:27:55 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0702211322350.340@pademelon.sonytel.be>
References: <200702210946.27758.toralf.foerster@gmx.de>
	<Pine.LNX.4.62.0702211102000.340@pademelon.sonytel.be>
	<Pine.LNX.4.64.0702211238400.14457@scrub.home>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJqa8-0004d1-LP for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 04:28:24 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HJqa7-0004SC-JB
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 04:28:24 -0800
In-Reply-To: <Pine.LNX.4.64.0702211238400.14457@scrub.home>
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
To: Roman Zippel <zippel@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: =?UTF-8?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>

On Wed, 21 Feb 2007, Roman Zippel wrote:
> On Wed, 21 Feb 2007, Geert Uytterhoeven wrote:
> > >  make mrproper ...
> > >  make rndconfig ...drivers/video/Kconfig:1604:warning: 'select' used by config symbol 'FB_PS3' refer to undefined symbol 'PS3_PS3AV'
> > >  make oldconfig ...
> > 
> > This looks actually like a bug in kconf, since it doesn't obey the
> > `depends on PPC_PS3' one line above...
> 
> It has little to do with the dependencies, as select doesn't really care 
> about them.

Well, that's the problem :-)

Why doesn't it obey dependencies? On one side we want to put drivers of a
specific type under driver/*, on the other side we want to put
architecture-specific things under arch/*. But as soon as you want to select an
architecture-specific thing, this breaks (well, generates warnings).

> In this case it looks like someone went a little overboard with the select 
> usage. It looks like most of the PS3 options could be hidden behind an 
> advanced option, then you can also use normal dependencies.

We wanted to have PS3FB and PS3SND (not yet submitted) to select PS3AV, so it
gets enabled automatically. Else we need dependencies on things the user
shouldn't really need to care about.

What other solution do you propose?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
