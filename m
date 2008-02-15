From: krzysztof.h1@poczta.fm
Subject: Re: [PATCH] pm2fb: change option mode to
	mode_option
Date: 15 Feb 2008 15:15:25 +0100
Message-ID: <20080215141527.C0C0A860C75@f23.poczta.interia.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JQ1Lg-0004Jj-GX for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 15 Feb 2008 06:15:32 -0800
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JQ1Lf-0006ol-1U
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 15 Feb 2008 06:15:32 -0800
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
Content-Type: text/plain; charset="iso-8859-1"
To: Andrew Morton <akpm@linux-foundation.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>, linux-fbdev-devel@lists.sourceforge.net, miki@dds.nl, adaplas@gmail.com

Andrew Morton napisa=B3(a):
> On Thu, 14 Feb 2008 22:52:13 +0100
> Krzysztof Helt >krzysztof.h1@poczta.fm> wrote:
> =

> > From: Krzysztof Helt >krzysztof.h1@wp.pl>
> > =

> > This patch changes the option "mode_option" into "mode".
> > =

> > ...
> >  =

> > -module_param(mode, charp, 0);
> > -MODULE_PARM_DESC(mode, "Preferred video mode e.g. &#039;648x480-8@60&#=
039;");
> > +module_param(mode_option, charp, 0);
> > +MODULE_PARM_DESC(mode_option, "Initial video mode e.g.
> &#039;648x480-8@60&#039;");
> >  module_param(lowhsync, bool, 0);
> >  MODULE_PARM_DESC(lowhsync, "Force horizontal sync low regardless of
> mode");
> >  module_param(lowvsync, bool, 0);
> =

> But it&#039;s not backward compatible.  We&#039;ll break people&#039;s se=
tups.
> =

> Not _much_, and we can probably live with it.  But surely it&#039;d be pr=
etty
> simple to retain the old option as well?
> =

> =

I'll fix this issue in all patches.

The changed drivers are relatively new. They were added or reworked not lon=
ger than 1 year ago (around 2.6.22).

Regards,
Krzysztof



----------------------------------------------------------------------
Masz ostatnia szanse !
Sprawdz >>> http://link.interia.pl/f1d02  =



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
