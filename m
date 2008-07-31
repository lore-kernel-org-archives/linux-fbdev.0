From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb: Revert "Fix radeon
	DDC	regression"
Date: Thu, 31 Jul 2008 19:12:36 +1000
Message-ID: <1217495556.11188.443.camel@pasglop>
References: <20080606112116.3aa37dfd@hyperion.delvare>
	<1212794511.12464.38.camel@pasglop>
	<20080731015913.9d165c6d.akpm@linux-foundation.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOUDH-0002n1-07 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 02:12:47 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1/ND31OMJlWPI/OT+QLdzOiryrDLPUoxaA=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KOUDG-0001HJ-CC
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 02:12:46 -0700
In-Reply-To: <20080731015913.9d165c6d.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jean Delvare <khali@linux-fr.org>, linux-fbdev-devel@lists.sourceforge.net

On Thu, 2008-07-31 at 01:59 -0700, Andrew Morton wrote:
> On Sat, 07 Jun 2008 09:21:51 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Fri, 2008-06-06 at 11:21 +0200, Jean Delvare wrote:
> > > The bug was in fb_ddc and was fixed by commit
> > > b64d70825abbf706bbe80be1b11b09514b71f45e (fb_ddc: fix DDC lines quirk)
> > > so the workaround in radeonfb can be removed now.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > ---
> > 
> > I need to verify that on my Apple monitor which would switch off
> > if that is wrong. Will try to do that this week-end. Without news
> > from me next week, then just commit the bloody thing :-)
> > 
> 
> I queued this for 2.6.28.

Ok. The monitor that was having problem is hooked on some other
stuff and I don't have the radeon machine in the same building
so unless people complain, I think this patch will do.

Ben.



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
