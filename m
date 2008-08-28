From: krzysztof.h1@poczta.fm
Subject: Re: [PATCH 2/2] tdfxfb: fix frame buffer name
	overrun
Date: 28 Aug 2008 10:20:19 +0200
Message-ID: <20080828082020.525E411410@f07.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYd8B-0007Qr-G5 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 01:45:27 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYd8A-0001aL-1g
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 01:45:27 -0700
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
To: Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

> On Wed, 27 Aug 2008, Krzysztof Helt wrote:
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > If there are more then one graphics card handled 
> > by the tdfxfb driver the name of the frame buffer 
> > overruns reserved name size.
> 
> Nice spot! Multiple strcat() will start overwriting other fields in
> fb_fix_screeninfo.
> 
> 
> At first I thought: but this doesn't fix all problems with multiple
> cards, as tdfx_fix is still shared among all of them? But that's not
> true (tdfx_fix is copied to info->fix later), so it is correct.
> 
> IMHO, as tdfx_fix is used as some `temporary' variable in tdfxfb_probe()
> only,
> a better fix would be to change the operation mode from:
> 
>     info = framebuffer_alloc(...);
>     tdfx_fix.foo = ...; /* depends on probe value */
>     tdfx_fix.bar = ...; /* depends on probe value */
>     info->fix = tdfx_fix;
> 
> to
> 
>     info = framebuffer_alloc(...);
>     info->fix = tdfx_fix;
>     info->fix.foo = ...; /* depends on probe value */
>     info->fix.bar = ...; /* depends on probe value */
> 
> and make tdfx_fix const. Then you don't have to initialize tdfx_fix.id
> for every card, and make it clear that tdfx_fix is just used as a
> template.
> 

Ok.

Andrew, please drop this patch. I will prepare next version (with signed-off-by as well). I started playing with git and I haven't notice that I need "-s" option while generating patches.

Regards,
Krzysztof


---------------------------------------------------------------
Nasilaja sie kradzieze.
Mieszkancy osiedli zaniepokojeni.
Prosimy o pomoc w tej sprawie >>> http://link.interia.pl/f1eef



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
