From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Framebuffer display corruption on 2.6.12
Date: Fri, 12 Aug 2005 22:11:47 +0300
Message-ID: <20050812191147.GA27448@sci.fi>
References: <42FCD122.4070705@gentoo.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3ewc-0007qB-2D
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Aug 2005 12:11:54 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E3ewa-00046F-Hn
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Aug 2005 12:11:53 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 9C93DD0FF5
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Aug 2005 22:11:47 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <42FCD122.4070705@gentoo.org>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

On Fri, Aug 12, 2005 at 05:41:06PM +0100, Daniel Drake wrote:
> Hi,
>=20
> This looks like a userspace issue, but apparently it only appears after=
=20
> upgrading from 2.6.11 to 2.6.12...
>=20
> Some Gentoo users have reported display corruption when using the=20
> framebuffer, easily visible in dialog-based applications. Sample screen=
shot:
>=20
> https://bugs.gentoo.org/attachment.cgi?id=3D63264

I got similar looking corruption when I switched to unicode. Recompiling=20
ncurses and slang with USE=3Dunicode fixed it. alsamixer and menuconfig=20
are still corrupted in the console but work fine under gnome-terminal=20
whereas mc and ufed work in both environments. A case of linking with=20
libncurses instead of libncursesw I guess...

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
