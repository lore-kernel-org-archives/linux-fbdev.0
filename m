From: Jim Hague <jim.hague@acm.org>
Subject: Re: [PATCH] pm2fb section mismatches
Date: Mon, 17 Apr 2006 22:26:22 +0100
Message-ID: <200604172226.23138.jim.hague@acm.org>
References: <20060414214905.375a308a.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FVbEy-0003kk-4t
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Apr 2006 14:26:36 -0700
Received: from cpc3-oxfd2-0-0-cust846.oxfd.cable.ntl.com ([82.10.99.79] helo=fluffy.bear-cave.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FVbEw-0004s8-PC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Apr 2006 14:26:36 -0700
In-Reply-To: <20060414214905.375a308a.rdunlap@xenotime.net>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, adaplas@pol.net

On Saturday 15 April 2006 05:49, Randy.Dunlap wrote:
> modpost warns:
>
> WARNING: drivers/video/pm2fb.o - Section mismatch: reference to .init.data:
> from .text.pm2fb_set_par after 'pm2fb_set_par' (at offset 0x7d4) WARNING:
> drivers/video/pm2fb.o - Section mismatch: reference to .init.data: from
> .text.pm2fb_set_par after 'pm2fb_set_par' (at offset 0x7f9)
>
> These are due to pm2fb_set_par() referencing <lowhsync> and
> <lowvsync>, which are __devinitdata.  Question is:  can
> pm2fb_set_par() [or any fb_set_par method] be called after
> driver initializtion?  I.e., do all of those calls in
> console/fbcon.c to fbops->fb_set_par() happen only during
> driver init, or can they happen later?

Just to confirm - I know calls to fb_set_par() happen after driver 
init. 'lowhsync' and 'lowvsync' shouldn't be __devinitdata; it was ignorance 
on my part that allowed another patch to make them so. Tony, please apply 
Randy's patch.
-- 
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lift.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
