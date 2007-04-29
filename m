From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [PATCH 1/3] s3fb: updates
Date: Sun, 29 Apr 2007 18:31:11 +0200
Message-ID: <20070429163111.GD12218@localhost.localdomain>
References: <20070429162045.GA12218@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiCIs-0006ru-Kc for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Apr 2007 09:31:15 -0700
Received: from gateway.crfreenet.org
	([81.92.146.254] helo=mail.crfreenet.org ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiCIs-00037x-7u
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Apr 2007 09:31:14 -0700
Content-Disposition: inline
In-Reply-To: <20070429162045.GA12218@localhost.localdomain>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, Apr 29, 2007 at 06:20:45PM +0200, Ondrej Zajicek wrote:
> 
> Move s3fb_get_tilemax to svgalib.c as svga_get_tilemax,
> because it reports limitation of other code from svgalib
> (svga_settile, svga_tilecopy, ...)
> 
> Limit font width to 8 pixels in 4 bpp mode.

It is against 2.6.21-rc7-mm2 .

-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
