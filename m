From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fbdev: Fix crash if fb_set_var()
	called before register_framebuffer()
Date: Sat, 27 Nov 2004 09:38:43 +1100
Message-ID: <1101508723.28047.43.camel@gaston>
References: <200411250115.50895.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXok2-0001x0-NL
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Nov 2004 14:39:02 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CXok1-00015d-UY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Nov 2004 14:39:02 -0800
In-Reply-To: <200411250115.50895.adaplas@hotpop.com>
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
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>

On Thu, 2004-11-25 at 01:15 +0800, Antonino A. Daplas wrote:
> The field info->modelist is initialized during register_framebuffer.  This
> field is also referred to in fb_set_var().  Thus a call to fb_set_var()
> before register_framebuffer() will cause a crash.  A few drivers do this,
> notably controlfb.  (This might fix reports of controlfb crashing in
> powermacs).
>
> .../...

Hi Antonio, I "missed" this modelist thingy. Can you explain what is the
logic ? There is now a modelist attached to fb_info used for mode
matching ? In this case, it makes sense to be able to add things to it
before register_framebuffer(). I mean, I would expect drivers to probe
at least their default head modes before registering the fb, since the
later will cause fbcon to try to setup a mode ...

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
