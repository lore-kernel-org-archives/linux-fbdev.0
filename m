From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 27/41] fbdev: Advertise limitation
 of drawing engine
Date: Thu, 26 Apr 2007 08:38:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704260836150.9880@anakin>
References: <462EFBB4.1080900@gmail.com>
	<20070425212327.GA7956@localhost.localdomain>
	<1177542624.4655.6.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgxcY-0002KS-D9 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 23:38:26 -0700
Received: from astra.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgxcX-0007kG-NK
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 23:38:26 -0700
In-Reply-To: <1177542624.4655.6.camel@daplas>
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
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 26 Apr 2007, Antonino A. Daplas wrote:
> On Wed, 2007-04-25 at 23:23 +0200, Ondrej Zajicek wrote:
> > On Wed, Apr 25, 2007 at 02:56:52PM +0800, Antonino A. Daplas wrote:
> > > A few drivers are not capable of blitting rectangles of any dimension.
> > > vga16fb can only blit 8-pixel wide rectangles, while s3fb (in tileblitting
> > > mode) can only blit 8x16 rectangles.
> > 
> > I have two new drivers which use tileblit. Where i can get diff of your
> > tree (not splitted to fifty parts and mixed with mail) to be able to
> 
> No public tree, and I don't have CVS access to fbdev-devel.

That can be arranged, if you want it... ;-)

Another option is a subdirectory on
http://www.kernel.org/pub/linux/kernel/people/, where you can host a git
tree, patches, ...?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
