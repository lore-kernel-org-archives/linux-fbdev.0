From: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH] radeonfb: prevent spurious recompilations
Date: Wed, 12 Oct 2005 10:31:54 +0200 (CEST)
Message-ID: <q2tzm25j.1129105914.0394050.khali@localhost>
References: <1129064342.17365.213.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EPcCq-0002Va-KI
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Oct 2005 01:43:24 -0700
Received: from [213.91.10.50] (helo=zone4.gcu-squad.org ident=root)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EPcCq-0008Le-17
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Oct 2005 01:43:24 -0700
In-Reply-To: <1129064342.17365.213.camel@gaston>
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
To: benh@kernel.crashing.org
Cc: linux-fbdev-devel@lists.sourceforge.net


Hi Ben,

On 2005-10-11 Jean Delvare wrote:
> > I'm doing frequent changes to the i2c header files, and noticed that
> > the radeonfb driver was recompiled each time I do, although I did not
> > include the I2C/DDC support. This is due to i2c header files being
> > included when they are not needed. Here is a patch fixing the problem.
> > Please consider applying it.

On 2005-10-11, Benjamin Herrenschmidt wrote:
> I generally quite dislike such #ifdef clutter ...

#ifdef CONFIG_FB_RADEON_I2C is already used 12 times in the radeonfb
driver, I don't think one more time will really make a difference.

Or do you have a different fix for my problem, that you would prefer?

Thanks,
--
Jean Delvare


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
