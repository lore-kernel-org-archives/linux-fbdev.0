From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 2/2]][RESEND] vesafb: Add blanking
 support
Date: Wed, 27 Jul 2005 16:17:03 +0800
Message-ID: <42E742FF.7050701@gmail.com>
References: <42E6D8CE.5080007@gmail.com> <Pine.LNX.4.62.0507271007530.9140@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dxh6N-00042y-Hp
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 01:17:19 -0700
Received: from wproxy.gmail.com ([64.233.184.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dxh6K-00023m-EH
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 01:17:19 -0700
Received: by wproxy.gmail.com with SMTP id i20so118476wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 27 Jul 2005 01:17:08 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0507271007530.9140@numbat.sonytel.be>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>

Geert Uytterhoeven wrote:

> 
> Is the screen still blanked (by setting all color registers to black in CLUT
> mode) if vga_compat is false?

Yes, it returns nonzero if not vga compatible.  This tells fbcon_blank to
soft blank the display.

Tony


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
