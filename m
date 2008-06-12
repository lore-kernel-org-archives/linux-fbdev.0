From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RFC 2.6.26-rc3 1/7] pxafb: module
	unloading support
Date: Thu, 12 Jun 2008 07:25:34 +0200
Message-ID: <20080612072534.adc46a9e.krzysztof.h1@poczta.fm>
References: <1212814166-10313-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212814166-10313-2-git-send-email-jayakumar.lkml@gmail.com>
	<18510.8821.785915.671710@ipc1.ka-ro> <484E30E6.8090204@gmail.com>
	<45a44e480806112136j7f96cc68ga4c92d796f64b057@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6fkR-0002JA-QF for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Jun 2008 22:53:23 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K6fkQ-0008P8-DN
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Jun 2008 22:53:23 -0700
In-Reply-To: <45a44e480806112136j7f96cc68ga4c92d796f64b057@mail.gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, ymiao3@marvell.com, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

On Wed, 11 Jun 2008 21:36:04 -0700
"Jaya Kumar" <jayakumar.lkml@gmail.com> wrote:

> On Tue, Jun 10, 2008 at 12:44 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> > Lothar Wa=DFmann wrote:
> >> Jaya Kumar wrote:
> >>> @@ -1587,7 +1587,7 @@ static int __init pxafb_parse_options(struct de=
vice *dev, char *options)
> >>>  static char g_options[256] __devinitdata =3D "";
> >>>
> >>>  #ifndef CONFIG_MODULES
> >>            ^^^^^^^^^^^^^^
> >>> -static int __devinit pxafb_setup_options(void)
> >>> +static int __init pxafb_setup_options(void)
> >>>
> >> That should be '#ifndef MODULE'.
> >> Otherwise support for cmdline options for the built-in driver will
> >> only be enabled if the kernel is compiled without module support.
> >>
> >
> > Yes, indeed. It requires another fix patch for this.
> >
> =

> Hi Eric, Lothar,
> =

> That CONFIG_MODULES is from the pxafb code. It is not part of the
> changes that I made to pxafb.
> =


I support Jaya position on this. The offending line is not part of his
patch. I think that this set of patches can be accepted with additional
patch which corrects existing pxafb problems (not related to his changes).
He may even post this patch before his set if this is required this way.

Regards,
Krzysztof


----------------------------------------------------------------------
Podbij Dziki Zachod!Gra strategiczna online
Sprawdz >>> http://link.interia.pl/f1dff


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
