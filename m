From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] i.MX Framebuffer: remove gpio setup
	function
Date: Tue, 2 Sep 2008 22:10:09 +0200
Message-ID: <20080902221009.5b70402b.krzysztof.h1@poczta.fm>
References: <1220354697-13648-1-git-send-email-s.hauer@pengutronix.de>
	<1220354697-13648-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kac63-0008Ib-OL for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 13:03:27 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kac61-00069D-9z
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 13:03:27 -0700
In-Reply-To: <1220354697-13648-3-git-send-email-s.hauer@pengutronix.de>
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

On Tue,  2 Sep 2008 13:24:45 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> Remove the gpio mux setup function from i.MX framebuffer driver.
> This function is platform specific and thus should be done by
> the board setup. As there are currently no in-kernel users
> of this driver we do not break anything.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl

I'll review the rest of your fb patches.

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
