From: "Paul A. Clarke" <pc@us.ibm.com>
Subject: Re: [PATCH] Fbdev driver for IBM GXT4500P video
 cards
Date: Thu, 07 Dec 2006 00:12:23 -0600
Message-ID: <4577B0C7.80502@us.ibm.com>
References: <17766.24132.505274.631108@cargo.ozlabs.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GsCUj-0006Hu-3y for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Dec 2006 22:12:33 -0800
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GsCUh-0001CW-KD
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Dec 2006 22:12:33 -0800
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB76COmS005818
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 7 Dec 2006 01:12:24 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB76COkR222848 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 7 Dec 2006 01:12:24 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB76CORV022971 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 7 Dec 2006 01:12:24 -0500
In-Reply-To: <17766.24132.505274.631108@cargo.ozlabs.ibm.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linuxppc-dev@ozlabs.org, adaplas@pol.net

Paul,

Paul Mackerras wrote:
> This is an fbdev driver for the IBM GXT4500P display card found in
> some IBM System P (pSeries) machines.  These cards have hardware 2D
> and 3D capabilities, but the driver does not use them; it just exports
> a dumb framebuffer.

Any reason to believe this wouldn't work with a GXT6500P as well?  It's almost 
identical to the GXT4500P except for an added geometry engine.

I have one, but won't be near it again until mid-January.

(This is very cool, BTW!)
-- 
Regards,
Paul Clarke

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
