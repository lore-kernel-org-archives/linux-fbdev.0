From: Richard Smith <rsmith@bitworks.com>
Subject: Re: Telling libSDL that my fbdev can do acclerated
 fills
Date: Tue, 29 Jun 2004 23:45:05 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40E24551.2030008@bitworks.com>
References: <200406301047.57423.adaplas@hotpop.com> <1088564019.1922.12.camel@gaston> <40E239F8.7070909@bitworks.com> <200406301238.06406.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfWy9-0000st-Vz
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 21:45:13 -0700
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BfWy8-000184-PD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Jun 2004 21:45:13 -0700
In-Reply-To: <200406301238.06406.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino A. Daplas wrote:

> 
> All hardware-assisted drawing functions in fbdev are for use by the console
> only.  You might want to try DirectFB (www.directfb.org), I believe they have
> ported a lot of libs, including SDL.  However, I doubt they have a gfxdriver for
> your hardware though.

I'm looking at that now.  Yes they have a SDL driver.  No they don't 
have anything for my hardware.  I'll have to do a port if I want directfb.

The documentation says that it runs on top of the linux framebuffer 
device.  If it runs on top of fbdev but fbdev only does  assisted stuff 
for the console then how does that work?






-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
