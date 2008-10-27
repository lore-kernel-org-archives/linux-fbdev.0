From: James Cloos <cloos@jhcloos.com>
Subject: radeonfb lockup in .28-rc (bisected)
Date: Mon, 27 Oct 2008 19:45:58 -0400
Message-ID: <m31vy1k3ea.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <cloos@jhcloos.com>) id 1Kubqz-0000qF-F5
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Oct 2008 23:50:33 +0000
Received: from eagle.jhcloos.com ([207.210.242.212])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Kubqw-0005Bf-Gb
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Oct 2008 23:50:33 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Krzysztof Halasa <khc@pm.waw.pl>

Commit b1ee26bab1 breaks radeonfb on my inspiron 8100 (P3-M with a
Mobility M7 LW [7500] (1002:4c57 1028:00e6)).

The boot is OK until init(8) starts; after init outputs its version info
it calls rc(8), which starts by setting the fb font.  At that point any
kernel with b1ee26bab1 locks hard.  The cursor stops flashing, magic
sysrq stops working and the fan starts up after a few seconds.  (I can't
tell whether it is the CPU or the GPU that heats up.)

If it is relevant, I use a 10x20 font, so the font change means the
console converts from 200x75, 8x16 to 160x60, 10x20.

I can boot the bad kernels with init=/bin/bash, and was able to get
dmesg output.  The differences between rc2 and rc2+revert are limited
to some changes in the size of the kernel:

-Memory: 512232k/524200k available (4376k kernel code, 11428k reserved, 1707k data, 320k init, 0k highmem)
+Memory: 512272k/524200k available (4354k kernel code, 11388k reserved, 1693k data, 316k init, 0k highmem)

the sizes of some hash allocations as a result of the above, the normal
randomish variances in the detected CPU speed, a few minor ordering
changes:

-input: AT Translated Set 2 keyboard as /class/input/input5
 Marking TSC unstable due to TSC halts in idle
+input: AT Translated Set 2 keyboard as /class/input/input5

and the output of the various modules that load during a normal boot but
which I did not load in the init=/bin/bash boot.

I'm running rc2 with b1ee26bab1 reverted now, and nothing else has been
a problem.

[CC list from the commit's Signed-off-By/Acked-By/CC list.]

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
