From: Andrey Volkov <andreyvolkov@users.sourceforge.net>
Subject: hwd accel framebuffer: Newbi question (sleep in sync)
Date: Mon, 11 Jul 2005 12:04:25 +0400
Message-ID: <42D22809.8070800@users.sourceforge.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DrtHA-0003Bg-Bb
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 11 Jul 2005 01:04:28 -0700
Received: from [195.144.244.147] (helo=[10.0.19.34])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1DrtH8-0003sm-GD
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 11 Jul 2005 01:04:28 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Hi all,

Anyone could explain me, could I or couldn't
use process sleep (i.e. wait_for..., sleep_on...)
in fb_info->fb_sync and/or in any hwd accelerated routines (i.e. blit,
cursor and rectfill)?
Code, which now in kernel, look terrible for me (counter based pooling).
Must it be so?

--
Regards,
Andrey Volkov


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
