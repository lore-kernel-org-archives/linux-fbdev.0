From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Kernel panic by write to console while switching consoles.
Date: Fri, 30 Jul 2004 04:52:53 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407300452.56290.adaplas@hotpop.com>
References: <1091116646.41091e66f1b3c@webmail.quest-innovations.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqHtj-0004Lt-Ut
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Jul 2004 13:53:07 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BqHtj-0007P7-IP
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Jul 2004 13:53:07 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id EBA93746004
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 29 Jul 2004 20:02:38 +0000 (UTC)
In-Reply-To: <1091116646.41091e66f1b3c@webmail.quest-innovations.com>
Content-Disposition: inline
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
To: Jaap van den Handel <jaap@quest-innovations.com>, linux-fbdev-devel@lists.sourceforge.net

On Thursday 29 July 2004 23:57, Jaap van den Handel wrote:
>
> Did we miss a setting to disable writes to the console while initializing
> our driver?
> Is it a bug which only comes forward in combination with a serial console
> or relative slow cpu's?

This is a problem in 2.4, hopefully fixed by BenH in 2.6 by acquiring the
console semaphore at strategic places.

Try placing acquire_console_sem(), release_console_sem() around the loop
in take_over_console() to disable early printing during console initialization.

Tony 




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
