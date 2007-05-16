From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 01/10] fbdev: Clean up of sparc FB
	options
Date: Wed, 16 May 2007 14:47:39 -0700 (PDT)
Message-ID: <20070516.144739.41633447.davem@davemloft.net>
References: <464B74EE.5040407@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HoRLJ-00076n-6F for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 14:47:34 -0700
Received: from [74.93.104.97] (helo=sunset.davemloft.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HoRLI-0007cs-Eh
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 14:47:33 -0700
In-Reply-To: <464B74EE.5040407@gmail.com>
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
To: adaplas@gmail.com
Cc: akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net

From: "Antonino A. Daplas" <adaplas@gmail.com>
Date: Thu, 17 May 2007 05:17:34 +0800

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch puts all SBUS/UPA selection under one option "SBUS/UPA
> framebuffers" and moves all sparc specific drivers next to them
> in one group.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>

Thanks for cleaning this up.

Signed-off-by: David S. Miller <davem@davemloft.net>

On a related note I've been trying to figure out how to solve a
particular issue on sparc, perhaps you can help?

The firmware has properties that we could use to determine exactly
which framebuffer device is being used as the console in multi-head
situations.

Currently there is no easy way to make use of that so the user just
gets whatever the framebuffer device probing order gives them which
isn't nice and is often wrong.

One idea I have is to provide a way to set some flag in the
fbinfo.  The flag would indicate that this framebuffer should
be used as the primary console by default.  Command line options
et al. could of course override this.

In this way sparc framebuffers could see if a device is the
one the "output-device" firmware property points to, and if
so it would set the flag.

What do you think about this?

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
