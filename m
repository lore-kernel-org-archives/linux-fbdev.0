From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] cirrusfb: use modedb and add
 mode_option parameter
Date: Sun, 31 Aug 2008 22:01:01 +0200
Message-ID: <20080831220101.0cffb6f0.krzysztof.h1@poczta.fm>
References: <20080831160040.8237ad31.krzysztof.h1@poczta.fm>
	<Pine.LNX.4.64.0808312009460.8062@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZt0K-0007LS-BQ for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 Aug 2008 12:54:32 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KZt0G-00040O-V8
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 Aug 2008 12:54:32 -0700
In-Reply-To: <Pine.LNX.4.64.0808312009460.8062@anakin>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 31 Aug 2008 20:10:20 +0200 (CEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Sun, 31 Aug 2008, Krzysztof Helt wrote:
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > Use modedb for initial mode instead of a table
> > of few predefined modes. Leave 640x480@60 mode
> > in case the modedb failed.
> 
> Any specific reason you left the 640x480@60 mode?
> 

I left the lowest one to have a safe setting in case the
modedb does not match specified one.
If you have a better way, let me know.

Regards,
Krzysztof


----------------------------------------------------------------------
>> Sprawdz, czy do siebie pasujecie!
>> http://link.interia.pl/f1eea


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
