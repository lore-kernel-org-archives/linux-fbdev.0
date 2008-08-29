From: krzysztof.h1@poczta.fm
Subject: Re: [PATCH 3/3] tdfxfb: do not make changes to
	default tdfx_fix
Date: 29 Aug 2008 07:36:28 +0200
Message-ID: <20080829053629.AAA5445B81E@f49.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYx68-0000xv-JB for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 23:04:40 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYx67-0005GK-46
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 23:04:40 -0700
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
To: Andrew Morton <akpm@linux-foundation.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: "geert@linux-m68k.org" <geert@linux-m68k.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

> On Thu, 28 Aug 2008 22:20:30 +0200
> Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > This was suggested by Geert Uytterhoeven
> > to avoid overwriting of default values
> > from the tdfx_fix.
> > 
> 
> I've uncertainly decided that this one can/should be held off until
> 2.6.28.  Please let me know if that was inappropriate.
> 

This one is for 2.6.28 as the buffer overrun is fixed
by the previous patch.

Regards,
Krzysztof

----------------------------------------------------------------------
Nie szukam kochanka!
>> http://link.interia.pl/f1eeb


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
