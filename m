From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RFC 2.6.26-rc9 5/5] metronomefb: changes
 to use separate framebuffer
Date: Fri, 1 Aug 2008 22:47:30 +0200
Message-ID: <20080801224730.87d95f27.krzysztof.h1@poczta.fm>
References: <1217422269-11093-1-git-send-email-jayakumar.lkml@gmail.com>
	<1217422269-11093-6-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KP1S9-0001sN-72 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 13:42:21 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KP1S7-0000SH-QV
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 13:42:21 -0700
In-Reply-To: <1217422269-11093-6-git-send-email-jayakumar.lkml@gmail.com>
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

On Wed, 30 Jul 2008 08:51:09 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> These changes are used in order to support the use of a separate
> framebuffer provided by the platform device driver. Other changes
> are cleanup to error handling and order of release.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> ---
>  drivers/video/Kconfig       |   18 +++-
>  drivers/video/metronomefb.c |  227 +++++++++++++++++++++++++------------------
>  include/video/metronomefb.h |   22 ++---
>  3 files changed, 153 insertions(+), 114 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

----------------------------------------------------------------------
W kosciele tez zdarzaja sie wpadki!
Smieszny filmik >>> http://link.interia.pl/f1e61


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
