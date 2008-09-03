From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] i.MX Framebuffer: add TFT support
Date: Wed, 3 Sep 2008 21:25:09 +0200
Message-ID: <20080903212509.2c961db8.krzysztof.h1@poczta.fm>
References: <1220354697-13648-1-git-send-email-s.hauer@pengutronix.de>
	<1220354697-13648-13-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kaxrw-0006wt-2i for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 12:18:20 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kaxru-0006jt-LS
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 12:18:20 -0700
In-Reply-To: <1220354697-13648-13-git-send-email-s.hauer@pengutronix.de>
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

On Tue,  2 Sep 2008 13:24:55 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> From: sascha Hauer <s.hauer@pengutronix.de>
> 
> With TFTs we can do 5/6/5 instead of 4/4/4. Add a bitfield for this
> and use it with TFTs.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/video/imxfb.c |   38 +++++++++++++++++++-------------------
>  1 files changed, 19 insertions(+), 19 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---------------------------------------------------------------
Nasilaja sie kradzieze.
Mieszkancy osiedli zaniepokojeni.
Prosimy o pomoc w tej sprawie >>> http://link.interia.pl/f1eef



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
