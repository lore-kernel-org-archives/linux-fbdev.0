From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH] remove tx3912fb
Date: Mon, 25 Sep 2006 11:47:28 +0900
Message-ID: <20060925114728.3c82b654.yoichi_yuasa@tripeaks.co.jp>
References: <20060922020202.31b2b537.yoichi_yuasa@tripeaks.co.jp>
	<816d36d30609221012j452e6b03raa1ef1c72bb494d@mail.gmail.com>
	<20060924214306.40133dee.yoichi_yuasa@tripeaks.co.jp>
	<816d36d30609240819q59edce51p91a7aa66dbc8dc43@mail.gmail.com>
	<816d36d30609240821x31035d3cw8170ace7de43abe5@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRgVQ-0001gP-IN for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Sep 2006 19:47:40 -0700
Received: from mo30.po.2iij.net ([210.128.50.53])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GRgVO-0008Lm-2O
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Sep 2006 19:47:40 -0700
In-Reply-To: <816d36d30609240821x31035d3cw8170ace7de43abe5@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Ricardo Mendoza <mendoza.ricardo@gmail.com>, linux-mips@linux-mips.org

Hi,

Ricardo will add support of Nino and others again.
Please ignore this patch.

Yoichi

On Sun, 24 Sep 2006 11:21:37 -0400
"Ricardo Mendoza" <mendoza.ricardo@gmail.com> wrote:

> On 9/24/06, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > Hello,
> >
> > On Fri, 22 Sep 2006 13:12:44 -0400
> > "Ricardo Mendoza" <mendoza.ricardo@gmail.com> wrote:
> >
> > > On 9/21/06, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > > > Hi,
> > > >
> > > > NINO support has already dropped.
> > > > Nothing is using tx3912fb.
> > > >
> > > > Yoichi
> > > >
> > > > Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> > > >
> > > > ...
> > >
> > > Hello Yoichi!
> > >
> > > If you don't mind I would ask to keep this driver up, I will soon add
> > > tx3912 support back up because I have a couple PDAs that use it, and
> > > there are still a few boards that run on it.
> >
> > Do you add the support of which PDA?
> 
> Philips Nino and Velo series and the old Sharp Mobilon series; both
> run on PR31700/TX3912 SoCs. Steven Hill had a port for the Nino board
> on early 2.4, but it was dropped as of 2.4.17 if I recall correctly,
> it never made it to 2.6.
> 
>      Ricardo
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
