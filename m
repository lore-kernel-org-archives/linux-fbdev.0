From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 01/10] fbdev: Clean up of sparc FB
	options
Date: Thu, 17 May 2007 07:15:05 +0800
Message-ID: <1179357305.4743.20.camel@daplas>
References: <464B74EE.5040407@gmail.com>
	<20070516.144739.41633447.davem@davemloft.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HoSiD-0007Dl-L2 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 16:15:17 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HoSiB-0001Yy-78
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 16:15:17 -0700
Received: by py-out-1112.google.com with SMTP id a29so670923pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 May 2007 16:15:14 -0700 (PDT)
In-Reply-To: <20070516.144739.41633447.davem@davemloft.net>
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
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net

On Wed, 2007-05-16 at 14:47 -0700, David Miller wrote:
> From: "Antonino A. Daplas" <adaplas@gmail.com>
> Date: Thu, 17 May 2007 05:17:34 +0800
> 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > This patch puts all SBUS/UPA selection under one option "SBUS/UPA
> > framebuffers" and moves all sparc specific drivers next to them
> > in one group.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > Signed-off-by: Antonino Daplas <adaplas@gmail.com>
> 
> Thanks for cleaning this up.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> On a related note I've been trying to figure out how to solve a
> particular issue on sparc, perhaps you can help?
> 
> The firmware has properties that we could use to determine exactly
> which framebuffer device is being used as the console in multi-head
> situations.
> 
> Currently there is no easy way to make use of that so the user just
> gets whatever the framebuffer device probing order gives them which
> isn't nice and is often wrong.
> 

This is a potential problem for the x86 too, actually.

> One idea I have is to provide a way to set some flag in the
> fbinfo.  The flag would indicate that this framebuffer should
> be used as the primary console by default.  Command line options
> et al. could of course override this.

A flag may be the easiest. But we can also define an arch-specific
function (ie, fb_get_primary_device()) in asm/fb.h. With the x86, this
can be easily done by checking the IORESOURCE_ROM_SHADOW bit flag.  

I'll add this for the x86, and then perhaps others can follow suit.

Tony  



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
