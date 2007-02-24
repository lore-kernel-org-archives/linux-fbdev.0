From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] nvidiafb: allow ignoring EDID info
Date: Sat, 24 Feb 2007 10:16:06 +0100
Message-ID: <cb7bb73a0702240116g33a9b5bv2e3668a536a70938@mail.gmail.com>
References: <ephv35$4i3$1@sea.gmane.org> <1172133646.4086.5.camel@daplas>
	<cb7bb73a0702220548s55380f7fk995726ffd349823b@mail.gmail.com>
	<1172153358.4306.17.camel@daplas>
	<cb7bb73a0702220755y3eb2e5b1r8e7908ae0c1720c9@mail.gmail.com>
	<1172161290.4198.12.camel@daplas>
	<cb7bb73a0702221108r161441ebt61886ce67746f389@mail.gmail.com>
	<1172187249.4279.7.camel@daplas>
	<cb7bb73a0702230534o4e2c7e9frd5f2b05accf18c05@mail.gmail.com>
	<1172300694.4109.50.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKt0l-0007ul-RW for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Feb 2007 01:16:11 -0800
Received: from wx-out-0506.google.com ([66.249.82.230])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKt0h-0001YW-F6
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Feb 2007 01:16:08 -0800
Received: by wx-out-0506.google.com with SMTP id i30so1186996wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 24 Feb 2007 01:16:06 -0800 (PST)
In-Reply-To: <1172300694.4109.50.camel@daplas>
Content-Disposition: inline
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
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Luca Tettamanti <kronos@people.it>, linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>, Dave Airlie <airlied@gmail.com>

On 2/24/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> On Fri, 2007-02-23 at 14:34 +0100, Giuseppe Bilotta wrote:
> >
> > The snowy is constant and abundant, and it seems to be independent of
> > video size (640 through 1600) and screen occupation (single prompt
> > line to fullscreen mc session) and usage.
> >
> > > I presume that X's nv driver or vesafb does not exhibit this problem?
> >
> > X's nv gives a very clean display, /unless/ I load nvidiafb before: if
> > I modprobe nvidiafb (it's a module, and it's blacklisted precisely for
> > this reason), then the screen is very snowy with X's nv too.
> >
>
> Hmm..., I really don't know how to fix this except to look at Xorg's
> code and look for a difference.

Keep in mind that setting nvidiafb to totally ignore the EDID (either
by not compiling in EDID support or by using e.g. the ignoreedid patch
I had proposed) the snow effect is extremely reduced, to the point of
being barely perceptible during normal usage (not as clean as X, but
still very good).

Also, I'm wondering if it might be worth looking at the progress done
in nouveau, and the drm stuff they've implemented (or at least the new
memory management and maybe some of the 2D stuff).

-- 
Giuseppe "Oblomov" Bilotta

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
