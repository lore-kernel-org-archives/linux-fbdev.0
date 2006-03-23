From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Linux 2.6.16: Cursor trouble on Matrox Millenium
 II framebuffer
Date: Thu, 23 Mar 2006 09:22:19 +0800
Message-ID: <4421F84B.2010801@gmail.com>
References: <20060323004734.31741.qmail@web52911.mail.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMYNt-0005Ee-JE
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 14:34:25 -0800
Received: from pproxy.gmail.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMYNs-0006zg-Db
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 14:34:25 -0800
Received: by pproxy.gmail.com with SMTP id z59so515667pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Mar 2006 14:34:23 -0800 (PST)
In-Reply-To: <20060323004734.31741.qmail@web52911.mail.yahoo.com>
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
To: Chris Rankin <rankincj@yahoo.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, vandrove@vc.cvut.cz

Chris Rankin wrote:
> Hmm, the effect is no longer happening on my console, although it was at a consistent height
> before. (As if someone thought that the framebuffer had fewer lines than it actually did.)

Someone reported a similar problem, with a different driver.  It seems to be related to
an init script running kbd.

> 
> The machine is a busy one that is awkward to reboot. I'll try and schedule something.

Don't bother then, just check first if it's related to an rc script running kbd.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
