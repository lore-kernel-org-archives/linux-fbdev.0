From: Alessio Sangalli <alesan@manoweb.com>
Subject: Re: Implementing new fb driver
Date: Sat, 20 Sep 2008 11:29:54 -0700
Message-ID: <48D54122.7060301@manoweb.com>
References: <20080917133444.11D82CF1A0@f21.poczta.interia.pl>	<48D13AFF.3050803@manoweb.com>	<48D2EF0F.1080701@manoweb.com>
	<20080920193030.37d3caf7.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <alesan@manoweb.com>) id 1Kh7Q7-0000Mj-5r
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 20 Sep 2008 18:43:03 +0000
Received: from moutng.kundenserver.de ([212.227.126.177])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Kh7Pl-00044g-IE for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 20 Sep 2008 18:43:03 +0000
In-Reply-To: <20080920193030.37d3caf7.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>, "linux-fbdev-devel@lists.sourceforge.net >>
	\"linux-fbdev-devel@lists.sourceforge.net\"" <linux-fbdev-devel@lists.sourceforge.net>

Krzysztof Helt wrote:

> I see. It seems that this ioctl is not implemented. The cursor
> control works through the console layer but I am not sure if you can
> set shape through this.
> 
> I have no time implement this at the moment.

Well, we did implement it, on Monday I will send you a patch to consider.

bye!
as


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
