From: Luca <kronos.it@gmail.com>
Subject: Re: [PATCH] radeonfb: add support for newer
	cards
Date: Tue, 2 Jan 2007 01:38:17 +0100
Message-ID: <68676e00701011638h55264e00g16504b0e3acdad7f@mail.gmail.com>
References: <20070101212551.GA19598@dreamland.darkstar.lan>
	<20070101214442.GA21950@dreamland.darkstar.lan>
	<1167696853.23340.156.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1XfW-0008NJ-CT for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 16:38:18 -0800
Received: from nf-out-0910.google.com ([64.233.182.190])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H1XfW-0007Sq-0S
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 16:38:18 -0800
Received: by nf-out-0910.google.com with SMTP id c31so10881548nfb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 01 Jan 2007 16:38:17 -0800 (PST)
In-Reply-To: <1167696853.23340.156.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Solomon Peachy <pizza@shaftnet.org>, linux-kernel@vger.kernel.org

On 1/2/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Mon, 2007-01-01 at 22:44 +0100, Luca Tettamanti wrote:
> > Il Mon, Jan 01, 2007 at 10:25:51PM +0100, Luca Tettamanti ha scritto:
> > > Hi Ben, Andrew,
> > > I've rebased 'ATOM BIOS patch' from Solomon Peachy to apply to 2.6.20.
> > > The patch adds support for newer Radeon cards and is mainly based on
> > > X.Org code.
> >
> > And - for an easier review - this is the diff between
> > radeonfb-atom-2.6.19-v6a.diff from Solomon and my patch (whitespace-only
> > changes not included).
>
> Ah good, what I was asking for :-) I'll try to get a new patch combining
> everything out asap.

Great, I didn't know you were working on this, I feared that the patch
had been forgotten.
I've a X850 (R480) here, feel free to send me any patch for testing.

Luca

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
