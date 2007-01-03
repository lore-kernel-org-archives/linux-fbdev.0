From: Luca <kronos.it@gmail.com>
Subject: Re: [PATCH] radeonfb: add support for newer
	cards
Date: Wed, 3 Jan 2007 22:34:12 +0100
Message-ID: <68676e00701031334t746eee57j9872528a16af30e2@mail.gmail.com>
References: <20070101212551.GA19598@dreamland.darkstar.lan>
	<20070101214442.GA21950@dreamland.darkstar.lan>
	<1167696853.23340.156.camel@localhost.localdomain>
	<68676e00701011638h55264e00g16504b0e3acdad7f@mail.gmail.com>
	<Pine.LNX.4.64.0701031556370.5730@mtl.rackplans.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H2DkU-0005iW-RM for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Jan 2007 13:34:15 -0800
Received: from wr-out-0506.google.com ([64.233.184.227])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H2DkT-0006dG-HQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Jan 2007 13:34:14 -0800
Received: by wr-out-0506.google.com with SMTP id i4so1061823wra
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 03 Jan 2007 13:34:12 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0701031556370.5730@mtl.rackplans.net>
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
To: Gerhard Mack <gmack@innerfire.net>
Cc: Andrew Morton <akpm@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net, Solomon Peachy <pizza@shaftnet.org>, linux-kernel@vger.kernel.org

On 1/3/07, Gerhard Mack <gmack@innerfire.net> wrote:
> On Tue, 2 Jan 2007, Luca wrote:
>
> > Date: Tue, 2 Jan 2007 01:38:17 +0100
> > From: Luca <kronos.it@gmail.com>
> > To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Andrew Morton <akpm@osdl.org>, Solomon Peachy <pizza@shaftnet.org>,
> >     linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
> > Subject: Re: [PATCH] radeonfb: add support for newer cards
> >
> > On 1/2/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > On Mon, 2007-01-01 at 22:44 +0100, Luca Tettamanti wrote:
> > > > Il Mon, Jan 01, 2007 at 10:25:51PM +0100, Luca Tettamanti ha scritto:
> > > > > Hi Ben, Andrew,
> > > > > I've rebased 'ATOM BIOS patch' from Solomon Peachy to apply to 2.6.20.
> > > > > The patch adds support for newer Radeon cards and is mainly based on
> > > > > X.Org code.
> > > >
> > > > And - for an easier review - this is the diff between
> > > > radeonfb-atom-2.6.19-v6a.diff from Solomon and my patch (whitespace-only
> > > > changes not included).
> > >
> > > Ah good, what I was asking for :-) I'll try to get a new patch combining
> > > everything out asap.
> >
> > Great, I didn't know you were working on this, I feared that the patch
> > had been forgotten.
> > I've a X850 (R480) here, feel free to send me any patch for testing.
>
> Is there a list of cards this adds support for?  I'm waiting on support
> for the X1600

The patch is for the "old" generation, R400, R480 and their mobile
versions. Unfortunately the new engine used in X1xxx cards is very
different and no docs are available from ATI.

Luca

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
