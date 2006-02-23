From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: atyfb, console, kernel 2.6.14 & Sony Vaio C1VE
Date: Thu, 23 Feb 2006 23:38:00 +0200
Message-ID: <20060223213800.GA9055@sci.fi>
References: <6f39f5aeb071b20c6b98c2847273d4cb@csi.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FCOA8-0005VN-1h
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 13:38:12 -0800
Received: from gw03.mail.saunalahti.fi ([195.197.172.111])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FCOA3-0008IU-Gn
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 13:38:12 -0800
Content-Disposition: inline
In-Reply-To: <6f39f5aeb071b20c6b98c2847273d4cb@csi.com>
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
Cc: Alexander Kern <alex.kern@gmx.de>

On Tue, Feb 21, 2006 at 08:07:23PM +0000, Fractallyte wrote:
> Dear List
>=20
> I'm running Linux with 2.6.14 kernel on a Vaio C1VE laptop.  The LCD=20
> panel size is 1024x480.  ATI Mach64 framebuffer support is compiled=20
> into the kernel; however, when booting into the console, the display is=
=20
> stretched horizontally to 80 columns, and fbset reports a 640x480=20
> display.  dmesg reports that the atyfb driver is detecting the correct=20
> geometry and timings for the panel (tested and working in Xorg), but=20
> the console insists on 80x30 rather than 128x30.

Try 2.6.15. It should get the timings from the BIOS.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
