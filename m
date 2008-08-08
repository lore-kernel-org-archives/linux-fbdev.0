From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 0/3] matroxfb fixes and improvements
Date: Fri, 8 Aug 2008 16:49:37 +0200
Message-ID: <20080808164937.141a95e0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRTI0-0007ft-7P for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 07:50:00 -0700
Received: from zone0.gcu-squad.org ([212.85.147.21]
	helo=services.gcu-squad.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KRTHy-0003LT-Re
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 Aug 2008 07:50:00 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@gmail.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, LKML <linux-kernel@vger.kernel.org>

Hi Antonino,

Not having heard of Petr in one month and a half, I am sending these 3
patches again. Patch 1/3 (matrox maven: Fix a broken error path) in
particular should be applied ASAP. Patch 2/3 (matroxfb: i2c structure
templates clean-up) would be good to have as well and I tested it.
Patch 3/3 (matrox maven: Convert to a new-style i2c driver) needs
testing before it can go upstream. I can't test it myself, but it has
been in linux-next for 6 weeks or so.

Thanks,
-- 
Jean Delvare

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
