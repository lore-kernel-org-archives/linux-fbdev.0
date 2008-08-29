From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] tdfxfb: do not make changes to
	default tdfx_fix
Date: Thu, 28 Aug 2008 17:50:11 -0700
Message-ID: <20080828175011.437a45cb.akpm@linux-foundation.org>
References: <20080828222030.60fcba44.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYsCX-0006Q6-Q5 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 17:50:57 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KYsCW-0000XW-IC
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 17:50:57 -0700
In-Reply-To: <20080828222030.60fcba44.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net

On Thu, 28 Aug 2008 22:20:30 +0200
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This was suggested by Geert Uytterhoeven
> to avoid overwriting of default values
> from the tdfx_fix.
> 

I've uncertainly decided that this one can/should be held off until
2.6.28.  Please let me know if that was inappropriate.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
