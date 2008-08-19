From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 2.6.26-rc9 0/2] metronomefb and
	am200epd fixes v9
Date: Tue, 19 Aug 2008 11:03:39 +0100
Message-ID: <20080819100339.GD1067@flint.arm.linux.org.uk>
References: <1217682500-31503-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVO4G-0002IS-3I for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 03:04:00 -0700
Received: from caramon.arm.linux.org.uk ([78.32.30.218])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVO4F-0004Gl-3t
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 03:03:59 -0700
Content-Disposition: inline
In-Reply-To: <1217682500-31503-1-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sat, Aug 02, 2008 at 09:08:18AM -0400, Jaya Kumar wrote:
> 
> This is version 9 of this RFC and contains the following updates:
> - switched to using fb notifiers. The benefit of this is that it avoids
>   the need to add any custom callbacks in pxafb. Basically, using this
>   mechanism there are no changes needed from the underlying host video driver.
> - eliminates one patch. So we just have the new am200epd and changes to
>   metronomefb.

Well, somethings gone wrong - patch 1 doesn't compile.

arch/arm/mach-pxa/am200epd.c: In function `am200_share_video_mem':
arch/arm/mach-pxa/am200epd.c:151: error: structure has no member named `metromem'
arch/arm/mach-pxa/am200epd.c:152: error: structure has no member named `host_fbinfo'
<and lots more errors>

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
