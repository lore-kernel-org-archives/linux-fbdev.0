From: Thomas Arendsen Hein <thomas@intevation.de>
Subject: Re: cyblafb in kernel 2.6.16: corrupted display    in Xfree86
Date: Thu, 23 Mar 2006 19:50:23 +0100
Message-ID: <20060323185022.GA10089@intevation.de>
References: <20060322234812.GB2361@intevation.de> <44225DAD.8080004@t-online.de> <20060323125244.GB5579@intevation.de> <4422B753.5080704@t-online.de> <20060323160321.GB7464@intevation.de> <4422D390.4030500@t-online.de> <20060323183908.GA9907@intevation.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMUtC-0004QV-UI
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 10:50:30 -0800
Received: from aktaia.intevation.org ([212.95.126.10] helo=mail.intevation.de)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMUtC-0001qs-Q1
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 10:50:31 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.intevation.de (Postfix) with ESMTP id A72B936F13
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 19:50:26 +0100 (CET)
Received: from intevation.de (eukrante.hq [192.168.11.14])
	by mail.intevation.de (Postfix) with SMTP id BC1EF36DC3
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 19:50:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20060323183908.GA9907@intevation.de>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

* Thomas Arendsen Hein <thomas@intevation.de> [20060323 19:40]:
> I've found another problem with the new cyblafb under X which didn't
> happen before: DPMS no longer turns of the monitor. At the time
> where DPMS suspend kicked in before, now the xlock clock simply
> stops updating, but is still visible (xlock -mode dclock).

... and DPMS on the fb console still works fine.

Thomas

-- 
Email: thomas@intevation.de
http://intevation.de/~thomas/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
