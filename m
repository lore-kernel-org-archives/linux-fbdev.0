From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: URGENT: status of atyfb
Date: Mon, 02 Aug 2004 15:21:27 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1091424085.7387.68.camel@gaston>
References: <1091417497.7393.63.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BrVJF-0004PO-0k
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 01 Aug 2004 22:24:29 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1BrVJE-0006pI-K0
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 01 Aug 2004 22:24:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id i725LvHR019479
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 2 Aug 2004 00:21:58 -0500
In-Reply-To: <1091417497.7393.63.camel@gaston>
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
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

Ok, I built an upstream tree with just the new atyfb in, and it breaks
on the wallstreet powerbook (LT-G) here. I'm not sure what is wrong at
this point, I'd say the clock stuff is incorrectly calculated.

On PPC, you do not have access to BIOS tables. So driver starts with
blowing up since the code for retreiving that from BIOS is unconditional
(it should be X86 only).

I disabled that, but then, the default values (which are the same as the old
driver afaik) don't seem to be enough anymore to produce a correct output.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
