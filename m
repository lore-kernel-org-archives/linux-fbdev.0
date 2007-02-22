From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] nvidiafb: allow ignoring EDID info
Date: Fri, 23 Feb 2007 07:34:11 +0800
Message-ID: <1172187251.4279.9.camel@daplas>
References: <21d7e9970701281612q56b694edp6efd1a5556dea3fe@mail.gmail.com>
	<20070128162907.370f5476.akpm@osdl.org>
	<21d7e9970701281639w57edc2efw4ba620d4c1bdcee7@mail.gmail.com>
	<cb7bb73a0701290637q2ce0ff16t28f82d0c0339a2ba@mail.gmail.com>
	<20070130203301.GA15067@dreamland.darkstar.lan>
	<20070204201713.GA12867@dreamland.darkstar.lan>
	<Pine.LNX.4.64.0702062034380.9224@pentafluge.infradead.org>
	<cb7bb73a0702061508x767882dcia1b13f85d898b6e7@mail.gmail.com>
	<1172101406.4217.16.camel@daplas>
	<cb7bb73a0702220001u6acbdd95ncdc9fad10d06b421@mail.gmail.com>
	<20070222203904.GA15349@dreamland.darkstar.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKNQ8-0005fr-EW for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 15:32:16 -0800
Received: from nz-out-0506.google.com ([64.233.162.226])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKNQ7-0000ss-5r
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 15:32:16 -0800
Received: by nz-out-0506.google.com with SMTP id i11so557314nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 22 Feb 2007 15:32:14 -0800 (PST)
In-Reply-To: <20070222203904.GA15349@dreamland.darkstar.lan>
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
To: Luca Tettamanti <kronos@people.it>
Cc: Andrew Morton <akpm@osdl.org>, James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, Dave Airlie <airlied@gmail.com>

On Thu, 2007-02-22 at 21:39 +0100, Luca Tettamanti wrote:
> Il Thu, Feb 22, 2007 at 09:01:52AM +0100, Giuseppe Bilotta ha scritto: 
> > On 2/22/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > >On Wed, 2007-02-07 at 00:08 +0100, Giuseppe Bilotta wrote:

> 
> Still scratching my head :|
> 
> Tony,
> this is the patch (modulo cosmetic stuff) that I sent to Giuseppe. I
> believe it's correct (I cross checked with X.org driver):
> 

Yes, the patch does look correct.  I also don't understand why
Giuseppe's hardware failed to do i2c with this...

Tony



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
