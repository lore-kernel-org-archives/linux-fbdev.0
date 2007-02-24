From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.20 1/1] fbdev,
	mm: Deferred IO and hecubafb driver
Date: Sat, 24 Feb 2007 03:24:20 -0500
Message-ID: <45a44e480702240024w30c0c2e2uaa01f3ed8f7457c2@mail.gmail.com>
References: <20070223063228.GA9906@localhost>
	<20070223092237.GA16889@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKsCe-0002wW-1g for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Feb 2007 00:24:25 -0800
Received: from nf-out-0910.google.com ([64.233.182.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKsCc-0005bW-JQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Feb 2007 00:24:23 -0800
Received: by nf-out-0910.google.com with SMTP id c31so2075783nfb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 24 Feb 2007 00:24:21 -0800 (PST)
In-Reply-To: <20070223092237.GA16889@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org

On 2/23/07, Paul Mundt <lethal@linux-sh.org> wrote:
> On Fri, Feb 23, 2007 at 07:32:28AM +0100, Jaya Kumar wrote:
> > This is a first pass at abstracting deferred IO out from hecubafb and
> > into fbdev as was discussed before:
> > http://marc.theaimsgroup.com/?l=linux-fbdev-devel&m=117187443327466&w=2
> >
> > Please let me know your feedback and if it looks okay so far.
> >
> How about this for an fsync()? I wonder if this will be sufficient for
> msync() based flushing, or whether the ->sync VMA op is needed again..
>

Looks fine to me.

Thanks,
jaya

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
