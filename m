From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] au1200fb: fixup PM support.
Date: Tue, 5 Aug 2008 17:22:00 +0200
Message-ID: <20080805172200.4f52ca12.krzysztof.h1__783.74642548642$1217950985$gmane$org@poczta.fm>
References: <20080805124221.GA27469@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQOfT-00011j-5e for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 08:41:47 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KQOfR-00038Z-NF
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 08:41:47 -0700
In-Reply-To: <20080805124221.GA27469@roarinelk.homelinux.net>
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
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: L-M-O <linux-mips@linux-mips.org>, Kevin Hickey <khickey@rmicorp.com>, linux-fbdev-devel@lists.sf.net

On Tue, 5 Aug 2008 14:42:21 +0200
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> Remove last traces of the custom Alchemy linux-2.4 PM code, implement
> suspend/resume callbacks.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
>  drivers/video/au1200fb.c |  164 ++++++++++++----------------------------------
>  1 files changed, 41 insertions(+), 123 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

If you don't want to push this patch through the mips tree you may post this patch
to Andrew Morton <akpm@linux-foundation.org> with my acked-by.

Regards,
Krzysztof

----------------------------------------------------------------------
Te newsy nakreca Cie na caly dzien!
Sprawdz >>> http://link.interia.pl/f1e94


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
