From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re: [Linux-fbdev-devel] Redesign of kernel
	graphics interface
Date: Mon, 17 May 2004 18:40:27 +0100
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <1084815625.9689.25.camel@localhost.localdomain>
References: <20040514184004.16621.qmail@web14930.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <20040514184004.16621.qmail@web14930.mail.yahoo.com>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: text/plain; charset="us-ascii"
To: DRI Devel <dri-devel@lists.sourceforge.net>
Cc: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Gwe, 2004-05-14 at 19:40, Jon Smirl wrote:
> Does DirectFB work on anything beside Matrox now?

Most cards, accelerated on quite a few including VIA. This is getting
into detail. If your 3D sucks you dont us OpenGL as the basis of your
whizzo console driver - just as MS plan to support the older UI for
older hardware.

> the effects are achieved with pixel shaders. xserver features a fully composited
> window manager, it needs these features to have a fast response time.

You need a 1mS response time at the most extreme. Indeed at 70Hz you
need a lot less

> What would be reasons for picking another API?

Its large, doesn't cover some functionality and doesn't map well to some
hardware. If you've got a DRI layer you don't have to *care*
what user space library is used and you certainly don't want to dictate
it



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
