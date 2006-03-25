From: "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: [PATCH] Add acceleration support to ATI Imageon (new patch)
Date: Sat, 25 Mar 2006 08:39:54 +0800
Message-ID: <4424915A.406@pol.net>
References: <20060323112930.GA10090@pupilla> <4422987A.7030900@pol.net> <44229A2E.1040109@pol.net> <20060323132825.GB10824@pupilla> <20060323171855.GB15382@pupilla>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMxI1-0005xT-MH
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Mar 2006 17:10:01 -0800
Received: from pproxy.gmail.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMxHz-0004Kk-Uf
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Mar 2006 17:10:01 -0800
Received: by pproxy.gmail.com with SMTP id z59so795030pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Mar 2006 17:09:59 -0800 (PST)
In-Reply-To: <20060323171855.GB15382@pupilla>
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
To: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@pol.net>, Richard Purdie <rpurdie@rpsys.net>, mardy@users.sourceforge.net

Mardy wrote:
> Hi!
>   Here's the patch; I changed w100_wait_complete() in w100fb_sync(), and
> it works correctly.
> I'm a bit uncertain about the return value of w100fb_sync(); it should
> be an int, but by grepping the sources I couldn't find any place where
> its return value is checked. Anyway, I choose to return 0 if everything
> is OK, or -EBUSY for timeout.

Yes, the return value is not checked by anywhere. The prototype probably
should be returning void...

> 
> 
> Signed-off-by: Alberto Mardegan <mardy@users.sourceforge.net>

I'll add this to my tree, and push it later to akpm, barring a disagreement
from Richard.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
