From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 3/8] lcd: allow lcd device to
	handle	mode change events
Date: Wed, 8 Oct 2008 14:07:51 +0000 (UTC)
Message-ID: <gciern$sc1$1@ger.gmane.org>
References: <f17812d70808290026y39163cccy2d4b1fa3b30c8625@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <glfd-linux-fbdev-devel@m.gmane.org>)
	id 1KnZiC-00072i-Do for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Oct 2008 14:08:24 +0000
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1KnZhy-0007UL-Cy
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Oct 2008 14:08:24 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KnZhp-0005YJ-64 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Oct 2008 14:08:01 +0000
Received: from iap-pxy-mow1.siemens.ru ([212.248.25.26])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00 for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 08 Oct 2008 14:08:01 +0000
Received: from dbaryshkov by iap-pxy-mow1.siemens.ru with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 08 Oct 2008 14:08:01 +0000
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
Cc: linux-arm-kernel@lists.arm.linux.org.uk

Eric Miao wrote:

> Some LCD panels are capable of different resolutions, and is allowed to
> change at run-time, so to make "struct lcd_device" to be able to handle
> mode change events here.
> 
> Signed-off-by: Eric Miao <eric.miao@marvell.com>

This patch broke a bit all existing fb drivers. At least you'll get a nice
segfault on modechange, if any lcd driver w/o set_mode is registered.
Please add a check for ld->ops->set_mode being non-NULL.

-- 
With best wishes
Dmitry



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
