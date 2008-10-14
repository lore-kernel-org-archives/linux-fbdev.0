From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] Add new framebuffer driver for
	Fujitsu	MB862xx GDCs
Date: Tue, 14 Oct 2008 15:50:52 +0000 (UTC)
Message-ID: <gd2f4s$82f$1@ger.gmane.org>
References: <1223997906-19900-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <glfd-linux-fbdev-devel@m.gmane.org>)
	id 1KpmAz-0003Dh-Cz for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Oct 2008 15:51:13 +0000
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1KpmAt-0001e2-1H
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Oct 2008 15:51:13 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KpmAo-0000vx-9p for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Oct 2008 15:51:02 +0000
Received: from ppp91-122-81-211.pppoe.avangarddsl.ru ([91.122.81.211])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00 for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 14 Oct 2008 15:51:02 +0000
Received: from dbaryshkov by ppp91-122-81-211.pppoe.avangarddsl.ru with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 14 Oct 2008 15:51:02 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linuxppc-dev@ozlabs.org

Anatolij Gustschin wrote:

> This patch adds framebuffer driver for Fujitsu Carmine/Coral-P(A)/Lime
> graphics controllers. Lime GDC support is known to work on PPC440EPx
> based lwmon5 and MPC8544E based socrates embedded boards, both equipped
> with Lime GDC. Carmine/Coral-P PCI GDC support is known to work on
> PPC440EPx based Sequoia board and also on x86 platform.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de> ---
> There are some PPC OF bits, so I'm cc'ing linuxppc-dev list.

I though there is already carminefb driver. Probably you should either merge
them or state that carminefb should be dropped.

-- 
With best wishes
Dmitry



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
