From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: atyfb expert needed
Date: Thu, 12 Feb 2004 09:10:53 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1076537453.868.123.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ar2bn-0003y1-Gr
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Feb 2004 14:13:27 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Ar2b1-0005F2-Mk
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Feb 2004 14:12:39 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id i1BM6DUn031586
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Feb 2004 16:06:14 -0600
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi ! I'm calling again for an atyfb expert ;)

The current driver in James tree (with generic lcd support) breaks
the display on the LT-G chip of the powerbook wallstreet. I don't
have time at the moment to dig into every change (there's a lot).

The "effect" is that the screen appears to be cut in vertical bands,
each of them displaying a slightly offseted version of what should be
there with some noise near the right edge.

If that symptom rings any bell about what registers can be wrong,
that would help me a lot figuring out what's up.

Ben.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
