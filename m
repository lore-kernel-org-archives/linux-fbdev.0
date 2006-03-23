From: Mardy <mardy@users.sourceforge.net>
Subject: Re: Re: [PATCH] Add acceleration support to ATI Imageon
Date: Thu, 23 Mar 2006 14:28:25 +0100
Message-ID: <20060323132825.GB10824@pupilla>
References: <20060323112930.GA10090@pupilla> <4422987A.7030900@pol.net> <44229A2E.1040109@pol.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMPrn-0007uG-F7
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 05:28:43 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1FMPrl-0000RP-TW
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 05:28:43 -0800
Content-Disposition: inline
In-Reply-To: <44229A2E.1040109@pol.net>
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
Cc: "Antonino A. Daplas" <adaplas@pol.net>, Richard Purdie <rpurdie@rpsys.net>

Le die Thu, Mar 23, 2006 at 08:53:02PM +0800, Antonino A. Daplas ha scribite:
> > 
> > I presume that w100_wait_complete is a "wait for engine idle" function?

Yes: without it, the characters were written in the framebuffer before
the copyarea operation actually took place. I didn't notice we had a
sync operation, too.

> > You can wrap w100_wait_complete() as w100fb_sync() and add this to fb_ops, ie
> > 
> > .fb_sync = w100fb_sync.

Yes, it's definitely better.

> Although the result is the same, I prefer an OR (|) rather than
> addition (+)... At first glance, an OR makes you think of bitsetting
> while the addition is a bit confusing at first.

Will do, and resend a new patch.
Thanks!


-- 
Saluti,
    Mardy
http://interlingua.altervista.org

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
