From: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
Subject: Re: [REGRESSION] i810fb: console switch causes
	pixel waste since 2.6.25-rc1
Date: Sun, 16 Mar 2008 17:33:00 +0100
Message-ID: <200803161733.01055.stefan.bauer@cs.tu-chemnitz.de>
References: <200803160133.19948.stefan.bauer@cs.tu-chemnitz.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JavnR-0000Xe-Lh for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 16 Mar 2008 09:33:27 -0700
Received: from lana.hrz.tu-chemnitz.de ([134.109.132.3])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JavnP-0004Cc-Sa
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 16 Mar 2008 09:33:17 -0700
Received: from v0026.v.pppool.de ([89.57.0.38] helo=noname)
	by lana.hrz.tu-chemnitz.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66) (envelope-from <stefan.bauer@informatik.tu-chemnitz.de>)
	id 1JavnL-0004Ae-VK for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 16 Mar 2008 17:33:12 +0100
In-Reply-To: <200803160133.19948.stefan.bauer@cs.tu-chemnitz.de>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

Am Sonntag, 16. M=E4rz 2008 01:33 schrieb Stefan Bauer:
> I will continue tomorrow figuring out since when agpgart is broken and
> since when it works again. Possibly that problem also causes this
> regression.

That wasn't the case. As I wrote, agpgart was broken since 266b9f8 (x86: fi=
x =

ioremap RAM check), but works well again since 38cb47b (x86: relax RAM chec=
k =

in ioremap()).

So I restarted bisecting, finding this one:

commit eaa0ff15c30dc9799eb4d12660edb73aeb6d32c5
Author: Alexey Dobriyan <adobriyan@gmail.com>
Date:   Wed Feb 6 01:36:06 2008 -0800

    fix ! versus & precedence in various places

    Fix various instances of

        if (!expr & mask)

    which should probably have been

        if (!(expr & mask))

    Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
    Cc: Jens Axboe <jens.axboe@oracle.com>
    Cc: Peter Osterlund <petero2@telia.com>
    Cc: Karsten Keil <kkeil@suse.de>
    Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
    Cc: "Antonino A. Daplas" <adaplas@pol.net>
    Cc: Mark Fasheh <mark.fasheh@oracle.com>
    Cc: "David S. Miller" <davem@davemloft.net>
    Cc: Jeff Garzik <jeff@garzik.org>
    Cc: Al Viro <viro@zeniv.linux.org.uk>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

So the regression was in since -rc1.

	Regards,
		Stefan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
