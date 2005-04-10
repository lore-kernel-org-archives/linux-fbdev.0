From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: small radeon frame buffer issues
Date: Mon, 11 Apr 2005 09:17:51 +1000
Message-ID: <1113175071.9517.514.camel@gaston>
References: <200504101159.36819.post@hendrik-sattler.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DKlif-00081Y-2O
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Apr 2005 16:19:57 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DKlie-0006zi-IH
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Apr 2005 16:19:56 -0700
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j3ANFegJ028470
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 10 Apr 2005 18:15:41 -0500
In-Reply-To: <200504101159.36819.post@hendrik-sattler.de>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> I tried with
> video=radeonfb:1024x768-24@60
> and this resulted in no framebuffer console at all. 24bpp is a common setting 
> for X and in my opinion, the driver should just do the right thing with the 
> request (e.g. map it 32bpp if necessary).
> Or at least you could print a kernel message in the default case that the 
> selected bpp value is not supported.

Hrm... Is this the "old" or "new" radeonfb ? Also does it actually work
if you just replace 24 with 32 on the kernel command line ?

> 3.
> radeonfb is mentioned in no file in Documentation/fb/. This lets one guess on
> how to use it. Please add radeonfb to the supported list in 
> Documentation/fb/modedb.txt
> 
> Thanks.
> 
> Hendrik Sattler
> 
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
