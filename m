From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Telling libSDL that my fbdev can do acclerated fills
Date: Wed, 30 Jun 2004 14:14:57 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406301414.57345.adaplas@hotpop.com>
References: <200406301047.57423.adaplas@hotpop.com> <200406301238.06406.adaplas@hotpop.com> <40E24551.2030008@bitworks.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfYMy-0000dM-6P
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 23:14:56 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BfYMx-00006S-SA
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 23:14:56 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 3A932692D57
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Jun 2004 05:32:56 +0000 (UTC)
In-Reply-To: <40E24551.2030008@bitworks.com>
Content-Disposition: inline
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
To: Richard Smith <rsmith@bitworks.com>, adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wednesday 30 June 2004 12:45, Richard Smith wrote:
>
> The documentation says that it runs on top of the linux framebuffer
> device.  If it runs on top of fbdev but fbdev only does  assisted stuff
> for the console then how does that work?

fbdev exports the register space and framebuffer to userspace, DirectFB
uses those to create hardware specific drawing functions via the 
gfxdrivers.

Tony




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
