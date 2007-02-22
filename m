From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] nvidiafb: allow ignoring EDID info
Date: Fri, 23 Feb 2007 07:34:09 +0800
Message-ID: <1172187249.4279.7.camel@daplas>
References: <ephv35$4i3$1@sea.gmane.org>
	<Pine.LNX.4.64.0702062034380.9224@pentafluge.infradead.org>
	<cb7bb73a0702061508x767882dcia1b13f85d898b6e7@mail.gmail.com>
	<1172101406.4217.16.camel@daplas>
	<cb7bb73a0702220001u6acbdd95ncdc9fad10d06b421@mail.gmail.com>
	<1172133646.4086.5.camel@daplas>
	<cb7bb73a0702220548s55380f7fk995726ffd349823b@mail.gmail.com>
	<1172153358.4306.17.camel@daplas>
	<cb7bb73a0702220755y3eb2e5b1r8e7908ae0c1720c9@mail.gmail.com>
	<1172161290.4198.12.camel@daplas>
	<cb7bb73a0702221108r161441ebt61886ce67746f389@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKNPV-0005Zz-3l for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 15:31:37 -0800
Received: from py-out-1112.google.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKNPT-0005kv-Jw
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 15:31:37 -0800
Received: by py-out-1112.google.com with SMTP id a29so160125pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 22 Feb 2007 15:31:35 -0800 (PST)
In-Reply-To: <cb7bb73a0702221108r161441ebt61886ce67746f389@mail.gmail.com>
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
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Luca Tettamanti <kronos@people.it>, linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>, Dave Airlie <airlied@gmail.com>

On Thu, 2007-02-22 at 20:08 +0100, Giuseppe Bilotta wrote:
> On 2/22/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > On Thu, 2007-02-22 at 16:55 +0100, Giuseppe Bilotta wrote:
> > >
> > > However, I'm still getting the same snowy effects, which doesn't come
> > > as a surprise since the actual mode timings used are just the same ...
> >
> > Yes, because the EDID has only 1 mode entry. But now you can use 'fbset
> > 1024x768-60' (or any mode smaller than 1600x1200-60) for example and it
> > should work.
> 
> No, it doesn't. I've tried all the methods from 640x480 to 1600x1200,
> and they /all/ come up snowy. This is starting to look queerer and
> queerer. I've also tried changing vf min and max as you suggested:

Before we proceed, do you agree that the patch will allow you to change
video modes without disabling DDC support?  So this is still a valid
fix?

> 
> >  You might want to change  vfmin and vfmax to 59 and 61
> 
> and even the M and MR methods which you suggested in the other email.
> Since nvidiafb is being loaded from the command line because it's a
> blacklisted module otherwise, I've been using the mode_option option.
> However, neither the mode_option nor fbset seem to give me anything
> not snowy.

When does your display become snowy? Is the snow constant or does it
only snow when doing heavy text operations, such as scrolling?

I presume that X's nv driver or vesafb does not exhibit this problem?

Tony



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
