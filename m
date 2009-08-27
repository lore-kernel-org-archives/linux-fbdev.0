From: Rui Santos <rsantos@grupopie.com>
Subject: Re: radeonfb cannot map FB
Date: Thu, 27 Aug 2009 16:00:53 +0100
Message-ID: <4A969FA5.60501@grupopie.com>
References: <4A92EDDB.6040806@grupopie.com> <1251280465.1379.64.camel@pasglop>	
	<4A96685A.5060404@grupopie.com>
	<a728f9f90908270701j5611a4f9p4b40cb46ddd44648@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rsantos@grupopie.com>) id 1MggU4-0007hM-BE
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Aug 2009 15:01:52 +0000
Received: from bipbip.grupopie.com ([195.23.16.24])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MggTy-0007Lw-Vf for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Aug 2009 15:01:52 +0000
In-Reply-To: <a728f9f90908270701j5611a4f9p4b40cb46ddd44648@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux FB-Devel <linux-fbdev-devel@lists.sourceforge.net>


> x86 bioses only post the primary VGA card.  For secondary cards you'll
> either need to use a driver that can initialize the card itself, or
> use something like vgaarb and vbetool to post the secondary card
> before loading the driver.  If you would prefer to use the radeon
> card, there may be an option in the bios to use the radeon card as the
> primary rather than the integrated card, however, that would probably
> make the integrated card unusable.
>
> Alex
>   
Hi Alex,

    There is no option similar to "Init Display first" on this BIOS.
Howerver both cards must be initialized. I'm trying a radeon kernel
modesetting approach. I'll also pursue vgaarb and vbetool options.
    Thanks a lot for the information ?

Regards,
Rui

>
>
>   


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
