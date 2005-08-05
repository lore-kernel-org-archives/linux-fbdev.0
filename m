From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Regression: radeonfb: No synchronisation on CRT with linux-2.6.13-rc5
Date: Fri, 5 Aug 2005 19:38:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0508051935570.2326@be1.lrz>
References: <Pine.LNX.4.58.0508040103100.2220@be1.lrz> <1123195493.30257.75.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E169W-00016U-U8
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Aug 2005 10:38:38 -0700
Received: from mail-in-09.arcor-online.net ([151.189.21.49])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E169V-0006e5-K9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Aug 2005 10:38:39 -0700
In-Reply-To: <1123195493.30257.75.camel@gaston>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bodo Eggert <7eggert@gmx.de>, LKML <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

On Fri, 5 Aug 2005, Benjamin Herrenschmidt wrote:

> On Fri, 2005-08-05 at 00:03 +0200, Bodo Eggert wrote:
> > My CRT is out of sync after radeonfb from 2.6.13-rc5 is initialized. 
> > 2.6.12 does not show this behaviour.
> 
> I'm out of town at the moment, could you maybe diff radeonfb between
> working & non-working and CC me the diff ? I don't have my work stuff at
> hand not my kernel images so...

There were no changes in radeonfb.c, but I could trace to to 
CONFIG_PREEMPT. With _NONE, it works as expected.


-- 
There is no such thing as an atheist in a foxhole. 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
