From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Regression: radeonfb: No synchronisation on CRT with
 linux-2.6.13-rc5
Date: Sun, 07 Aug 2005 23:48:08 +0200
Message-ID: <1123451289.30257.118.camel@gaston>
References: <Pine.LNX.4.58.0508040103100.2220@be1.lrz>
	 <1123195493.30257.75.camel@gaston>
	 <Pine.LNX.4.58.0508051935570.2326@be1.lrz>
	 <1123401069.30257.102.camel@gaston>
	 <3EF2003B-12DF-4EBB-B304-59614AEFAA09@mac.com>
	 <Pine.LNX.4.58.0508071921540.3495@be1.lrz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1t4p-0001un-Sc
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 14:53:03 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E1t4o-0007XE-N3
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 14:53:04 -0700
In-Reply-To: <Pine.LNX.4.58.0508071921540.3495@be1.lrz>
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

On Sun, 2005-08-07 at 19:25 +0200, Bodo Eggert wrote:
> On Sun, 7 Aug 2005, Kyle Moffett wrote:
> > On Aug 7, 2005, at 03:51:07, Benjamin Herrenschmidt wrote:
> 
> > > Ah ! Interesting... I don't see why PREEMPT would affect radeonfb
> > > though ... Can you try something like wrapper radeon_write_mode() with
> > > preempt_disable()/preempt_enable() and tell me if it makes a
> > > difference ?
> 
> Did not help. The values used to initialize the mode seem to be wrong.
> Copying the aty directory from 2.6.12 did not help, too.

I don't see how PREEMPT could have any impact there unless you are
experiencing memory corruption... or one of those panels that have so
subtle timing issues that they sometimes don't sync depending on how
many flies you have in your room....

Ben.




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
