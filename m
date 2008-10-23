From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: lockdep splat from fbmem (fwd)
Date: Thu, 23 Oct 2008 09:30:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0810230930431.7533@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@linux-m68k.org>) id 1Ksuev-0005YQ-8N
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 23 Oct 2008 07:31:05 +0000
Received: from wilson.telenet-ops.be ([195.130.132.42])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ksuel-0005b6-TO for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 23 Oct 2008 07:31:05 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by wilson.telenet-ops.be (Postfix) with SMTP id 5FE7F3402C
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 23 Oct 2008 09:30:48 +0200 (CEST)
Received: from anakin.of.borg (d54C15368.access.telenet.be [84.193.83.104])
	by wilson.telenet-ops.be (Postfix) with ESMTP id 4704E34023
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 23 Oct 2008 09:30:48 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-5) with ESMTP id m9N7UlhA018045
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 23 Oct 2008 09:30:47 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m9N7Ulj0018042
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 23 Oct 2008 09:30:47 +0200
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

---------- Forwarded message ----------
Date: Thu, 23 Oct 2008 05:23:38 +0200
From: Johannes Weiner <hannes@saeurebad.de>
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Andrea Righi <righi.andrea@gmail.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: lockdep splat from fbmem

Hi,

fb_mmap() is called under mmap_sem and acquires fb_info->lock.

Since 3e680aae4e53ab "fb: convert lock/unlock_kernel() into local fb
mutex", fb_ioctl() takes fb_info->lock and does copy_to/from_user()
under it, which in turn might acquire mmap_sem.

Just noticed the trace and wanted to let you know.

        Hannes
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
