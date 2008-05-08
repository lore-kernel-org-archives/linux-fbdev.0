From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [PATCH 6/9] viafb: VIA Frame Buffer Device
	Driver
Date: Thu, 8 May 2008 09:18:09 +0200
Message-ID: <20080508071809.GA11121@localhost.localdomain>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F67759@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ju0P8-0007Qu-Fm for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 00:19:02 -0700
Received: from smtp1.kolej.mff.cuni.cz ([78.128.192.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ju0P3-0006XY-Q6
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 00:19:00 -0700
Content-Disposition: inline
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F67759@exchtp03.taipei.via.com.tw>
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

On Wed, May 07, 2008 at 07:09:42PM +0800, JosephChan@via.com.tw wrote:
> diff -Nur a/drivers/video/via/viafb.modes b/drivers/video/via/viafb.modes
> --- a/drivers/video/via/viafb.modes	1969-12-31 19:00:00.000000000 -0500
> +++ b/drivers/video/via/viafb.modes	2008-04-29 02:51:27.000000000 -0400
> @@ -0,0 +1,870 @@
> +#
> +#
> +#   These data are based on the CRTC parameters in
> +#
> +#       VIA Integration Graphics Chip
> +#       (C) 2004 VIA Technologies Inc.

Configuration file for fbset definitely shouldn't be here between C
source files. If it is needed, then it should be somewhere in
Documentation/fb .

BTW, Are these modes common VESA modes (DVT, GTF or CVT)  or some
other modes. In first case there is probably no reason to include
them.

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
