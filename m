From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RFC 2.6.26-rc9 4/5] am200epd: convert to
 shared fb and use gpio api
Date: Sun, 3 Aug 2008 16:29:57 +0200
Message-ID: <20080803162957.67f64e54.krzysztof.h1@poczta.fm>
References: <1217422269-11093-1-git-send-email-jayakumar.lkml@gmail.com>
	<1217422269-11093-5-git-send-email-jayakumar.lkml@gmail.com>
	<20080731174642.a55e1e39.krzysztof.h1@poczta.fm>
	<45a44e480808020632r691e964bjaa88dfc529e02d21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KPes3-000857-P6 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Aug 2008 07:47:43 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KPes1-0006qj-Bj
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Aug 2008 07:47:43 -0700
In-Reply-To: <45a44e480808020632r691e964bjaa88dfc529e02d21@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sat, 2 Aug 2008 09:32:13 -0400
"Jaya Kumar" <jayakumar.lkml@gmail.com> wrote:

> On Thu, Jul 31, 2008 at 11:46 AM, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> > On Wed, 30 Jul 2008 08:51:08 -0400
> > Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> >
> 
> >> +     am200_device = platform_device_alloc("metronomefb", -1);
> >
> > The second parameter is instance id. Probably 0 is better here.
> 
> I would like to mark it as single instance only, -1. I see in platform.c:
> 
>       if (pdev->id != -1)
>                 snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s.%d", pdev->name,
>                          pdev->id);
>         else
>                 strlcpy(pdev->dev.bus_id, pdev->name, BUS_ID_SIZE);
> 
> 

Ok.

Regards,
Krzysztof

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>>  http://link.interia.pl/f1e91


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
