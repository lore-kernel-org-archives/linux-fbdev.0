From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] i.MX Framebuffer: fix margins
Date: Wed, 3 Sep 2008 21:14:20 +0200
Message-ID: <20080903211420.91835ea6.krzysztof.h1@poczta.fm>
References: <1220354697-13648-1-git-send-email-s.hauer@pengutronix.de>
	<1220354697-13648-5-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaxhW-0005nb-Ua for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 12:07:35 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KaxhV-0002QX-GR
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 12:07:34 -0700
In-Reply-To: <1220354697-13648-5-git-send-email-s.hauer@pengutronix.de>
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
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Dyer <amdyer@gmail.com>

On Tue,  2 Sep 2008 13:24:47 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> The upper/lower and left/right margins are mixed up in the driver.
> Fix it
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/video/imxfb.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)


Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

----------------------------------------------------------------------
Tylko u nas - swieza krew w rozsadnych cenach!
>> http://link.interia.pl/f1eed


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
