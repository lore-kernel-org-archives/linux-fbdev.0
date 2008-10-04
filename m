From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: RV5|6 support
Date: Sat, 4 Oct 2008 21:29:19 +0200
Message-ID: <20081004192919.GA16032@aragorn.home.lxtec.de>
References: <20080927113021.GA4211@aragorn.home.lxtec.de>
	<a728f9f90809270745v5c93a93bmf96dd4feaa40adf1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <riesebie@lxtec.de>) id 1KmCpC-0008EK-Pk
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 04 Oct 2008 19:29:58 +0000
Received: from smtpout.hostsharing.net ([83.223.95.99])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1KmCoj-0001oA-4b
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 04 Oct 2008 19:29:58 +0000
Received: from h01.hostsharing.net (h01.hostsharing.net [212.42.230.152])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtpout.hostsharing.net (Postfix) with ESMTP id CB79E20000A1
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat,  4 Oct 2008 21:29:25 +0200 (CEST)
Received: from mail.home.lxtec.de (p5B146FFD.dip.t-dialin.net [91.20.111.253])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h01.hostsharing.net (Postfix) with ESMTP id 8FC831837BAA1
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat,  4 Oct 2008 21:29:25 +0200 (CEST)
Received: from localhost ([127.0.0.1])
	by mail.home.lxtec.de with esmtp (Exim 4.69 1 (LXTEC))
	id 1KmCoe-0000au-6X for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 04 Oct 2008 21:29:24 +0200
Received: from mail.home.lxtec.de ([127.0.0.1])
	by localhost (mail.home.lxtec.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ne4EdxqOjv1
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat,  4 Oct 2008 21:29:20 +0200 (CEST)
Received: from aragorn.home.lxtec.de ([192.168.200.203] ident=Debian-exim)
	by mail.home.lxtec.de with esmtps (Exim 4.69 1 (LXTEC))
	id 1KmCoa-0000ag-Cr for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 04 Oct 2008 21:29:20 +0200
Content-Disposition: inline
In-Reply-To: <a728f9f90809270745v5c93a93bmf96dd4feaa40adf1@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

* Alex Deucher [081004 19:20 +0200]
> On Sat, Sep 27, 2008 at 7:30 AM, Elimar Riesebieter <riesebie@lxtec.de> wrote:
> > Hi all,
> >
> > is there support for ATI RV5* RV6* (RV670) chips with radeonfb?
> > Where can I find a patch to support RV670?
> 
> There is not.  If you need kernel fb support for newer asics, your
> best bet is the new drm modesetting stuff.  It provides fb interfaces.
> http://airlied.livejournal.com/62269.html
> http://cgit.freedesktop.org/mesa/drm/log/?h=modesetting-gem

Thanks. I'll check it.

Elimar

-- 
  Do you smell something burning or ist it me?

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
