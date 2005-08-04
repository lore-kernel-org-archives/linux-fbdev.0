From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Regression: radeonfb: No synchronisation on CRT with
 linux-2.6.13-rc5
Date: Fri, 05 Aug 2005 00:44:52 +0200
Message-ID: <1123195493.30257.75.camel@gaston>
References: <Pine.LNX.4.58.0508040103100.2220@be1.lrz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0oWd-0004V0-TJ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Aug 2005 15:49:19 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E0oWc-00040G-NN
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Aug 2005 15:49:20 -0700
In-Reply-To: <Pine.LNX.4.58.0508040103100.2220@be1.lrz>
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

On Fri, 2005-08-05 at 00:03 +0200, Bodo Eggert wrote:
> My CRT is out of sync after radeonfb from 2.6.13-rc5 is initialized. 
> 2.6.12 does not show this behaviour.

I'm out of town at the moment, could you maybe diff radeonfb between
working & non-working and CC me the diff ? I don't have my work stuff at
hand not my kernel images so...

Thanks,
Ben.





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
