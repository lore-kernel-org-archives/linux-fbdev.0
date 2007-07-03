From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: [PATCH] pxafb: Add support for other
	palette formats
Date: Tue, 3 Jul 2007 17:03:52 +0200
Message-ID: <200707031703.53102.hjk@linutronix.de>
References: <200707031607.08511.hjk@linutronix.de>
	<468A6159.6000808@grupopie.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5jva-0000hT-6T for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 08:04:30 -0700
Received: from www.osadl.org ([213.239.205.134] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I5jvZ-0002M7-NZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 08:04:30 -0700
In-Reply-To: <468A6159.6000808@grupopie.com>
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
To: Paulo Marques <pmarques@grupopie.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

Am Dienstag 03 Juli 2007 16:46 schrieb Paulo Marques:
> Hans-J=FCrgen Koch wrote:
> > This patch adds support for the other three palette formats possible wi=
th =

> > the PXA LCD controller. This is required on boards where an LCD is conn=
ected
> > with all its 18 bits. With this patch, it's possible to use an 8-bit mo=
de
> > with 18-bit palette entries.
> =

> I've been working on getting the non-palletized 18bpp modes working and =

> had a preliminar patch that just didn't support packed mode yet (using =

> 24 bits per pixel).

Can userspace applications work with such a weired format?
If yes, I'm looking forward to your patch.

> =

> We can either apply this patch as is and I'll just merge my work later, =

> or I can try to merge both patches and send a single patch upstream. =

> Either way is fine by me.

It's probably cleaner to merge two small patches than a big one.

> =

> For what is worth, this patch seems ok to me as is:
> =

> Acked-by: Paulo Marques <pmarques@grupopie.com>
> =


Thanks,
Hans


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
