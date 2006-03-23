From: Mardy <mardy@users.sourceforge.net>
Subject: Re: [PATCH] Add acceleration support to ATI Imageon
Date: Thu, 23 Mar 2006 14:22:58 +0100
Message-ID: <20060323132258.GA10824@pupilla>
References: <20060323112930.GA10090@pupilla> <Pine.LNX.4.62.0603231317370.16810@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMPmZ-0007JB-4z
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 05:23:19 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1FMPmX-0007LK-Jt
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 05:23:19 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0603231317370.16810@pademelon.sonytel.be>
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

Le die Thu, Mar 23, 2006 at 01:23:33PM +0100, Geert Uytterhoeven ha scribite:
> > Since this is my first submission, please let me know if there's
> > something else that should be done.
> 
> A Signed-Off-By line?

Maybe ;-)

[...bitfields type...]
> OTOH, in my copy of C99, I didn't immediately find out whether using `long' or
> `int' here has any visible effect at all.

I think it shouldn't make any difference, but for consistency I'll
submit a patch that changes all those "unsigned long" to "u32".


-- 
Saluti,
    Mardy
http://interlingua.altervista.org

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
