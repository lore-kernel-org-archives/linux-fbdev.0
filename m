From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Regression: radeonfb: No synchronisation on CRT with
 linux-2.6.13-rc5
Date: Mon, 08 Aug 2005 10:19:59 +0200
Message-ID: <1123489200.30257.133.camel@gaston>
References: <Pine.LNX.4.58.0508040103100.2220@be1.lrz>
	 <1123195493.30257.75.camel@gaston>
	 <Pine.LNX.4.58.0508051935570.2326@be1.lrz>
	 <1123401069.30257.102.camel@gaston>
	 <3EF2003B-12DF-4EBB-B304-59614AEFAA09@mac.com>
	 <Pine.LNX.4.58.0508071921540.3495@be1.lrz>
	 <1123451289.30257.118.camel@gaston>
	 <Pine.LNX.4.58.0508080158520.7822@be1.lrz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E22wT-0008D3-93
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 01:25:05 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E22wR-0005jn-Sw
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 01:25:05 -0700
In-Reply-To: <Pine.LNX.4.58.0508080158520.7822@be1.lrz>
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
To: Bodo Eggert <7eggert@gmx.de>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, LKML <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

On Mon, 2005-08-08 at 02:06 +0200, Bodo Eggert wrote:

> The wrong values are constant across reboots (see my first mail), and I 
> have a CRT.
> 
> Can you tell me where the timing values are read?

radeon_write_mode() programs the mode. The monitor timing infos are read
by the various bits of code in radeon_monitor.c

I'd be curious if you could identify what bit of code is misbehaving

Ben.




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
