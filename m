From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [PATCH 2/9] viafb: VIA Frame Buffer Device
	Driver
Date: Thu, 8 May 2008 09:58:09 +0200
Message-ID: <20080508075809.GC11121@localhost.localdomain>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F67753@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ju118-00030z-L8 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 00:58:18 -0700
Received: from smtp1.kolej.mff.cuni.cz ([78.128.192.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ju118-0002RY-2K
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 00:58:18 -0700
Content-Disposition: inline
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F67753@exchtp03.taipei.via.com.tw>
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
To: JosephChan@via.com.tw
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org


On Wed, May 07, 2008 at 07:09:28PM +0800, JosephChan@via.com.tw wrote:
> +u16 red256[] = {
> +	0x0, 0x0, 0x0, 0x0, 0xa800, 0xa800, 0xa800, 0xa800, 0x5400, 0x5400,
> +	0x5400, 0x5400, 0xfc00, 0xfc00, 0xfc00, 0xfc00,

...

> +u16 green256[] =
> +    { 0x0, 0x0, 0xa800, 0xa800, 0x0, 0x0, 0x5400, 0xa800, 0x5400, 0x5400,
> +	0xfc00, 0xfc00, 0x5400, 0x5400, 0xfc00, 0xfc00,

...

> +};
> +u16 blue256[] =
> +    { 0x0, 0xa800, 0x0, 0xa800, 0x0, 0xa800, 0x0, 0xa800, 0x5400, 0xfc00,
> +	0x5400, 0xfc00, 0x5400, 0xfc00, 0x5400, 0xfc00,
> +	0x0, 0x1400, 0x2000, 0x2c00, 0x3800, 0x4400, 0x5000, 0x6000,

...

> +};
> +
> +struct fb_cmap viafb_256_colors = { 0, 256, red256, green256, blue256, NULL

Standard pattern is to allocate colormap using fb_alloc_cmap(). This function
also fills colormap with common default colormap. It is unnecessary to have
another default colormap.

-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
