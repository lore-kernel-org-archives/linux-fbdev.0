From: Tom Cooksey <thomas.cooksey@nokia.com>
Subject: Re: Userspace blit API
Date: Thu, 4 Dec 2008 10:59:03 +0100
Message-ID: <200812041059.04119.thomas.cooksey@nokia.com>
References: <200812040927.24861.thomas.cooksey@nokia.com>
	<DE92CB70-E15B-48CC-BA9F-C8F10B9AE78C@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <thomas.cooksey@nokia.com>) id 1L8Atj-00043a-Ga
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Dec 2008 09:53:27 +0000
Received: from smtp.nokia.com ([192.100.105.134] helo=mgw-mx09.nokia.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L8Atg-0008KL-Cm
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Dec 2008 09:53:27 +0000
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	mB49r8e9012084 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 4 Dec 2008 03:53:19 -0600
Received: from tomdev.localnet (olwst906.europe.nokia.com [172.24.90.6])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id
	mB49rFJv000814 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 4 Dec 2008 11:53:15 +0200
In-Reply-To: <DE92CB70-E15B-48CC-BA9F-C8F10B9AE78C@pobox.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

On Thursday 04 December 2008 09:58:26 ext Torgeir Veimo wrote:
> On 4 Dec 2008, at 18:27, Tom Cooksey wrote:
> > I apologize if this has been asked & answered before - If it has,
> > would you
> > mind digging out a link?
>
> Have you considered creating or using a DirectFB driver with this
> device, or is that too much overhead?

We have a DirectFB driver already and we were hoping that would solve this 
problem. The trouble is, DirectFB seems to have gone beyond it's original 
scope of "accelerated surface management" and is now a bit too big. Our 
customers also report 3rd party drivers (even in-tree drivers in my 
experience) are a bit unstable.

I personally quite like the surface management part of the DirectFB API, it's 
just a shame some of the implementations are letting it down. :-(


Cheers,

Tom



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
