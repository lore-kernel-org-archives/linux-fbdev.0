From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: What is the linux-fbdev-devel's git address
 ?
Date: Wed, 5 Nov 2008 21:06:48 -0800
Message-ID: <20081105210648.a1541ede.rdunlap@xenotime.net>
References: <1225935191.7811.126.camel@localhost>
	<45a44e480811051746m1cbe7f17s82791d641ac4d853@mail.gmail.com>
	<1225944946.7337.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rdunlap@xenotime.net>) id 1KxxNw-0006gh-JC
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Nov 2008 05:26:24 +0000
Received: from xenotime.net ([72.52.64.118])
	by 29vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1KxxNs-0008MG-Rl for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Nov 2008 05:26:24 +0000
Received: from chimera.site ([71.117.247.66]) by xenotime.net for
	<linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 5 Nov 2008 21:07:14 -0800
In-Reply-To: <1225944946.7337.2.camel@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: stanley.miao@windriver.com
Cc: linux-fbdev-devel@lists.sourceforge.net, Jaya Kumar <jayakumar.lkml@gmail.com>

On Thu, 06 Nov 2008 12:15:46 +0800 stanley.miao wrote:

> Thanks, Jaya, 
> 
> Now there isn't a fbdev specific git tree, so who is responsible for
> pushing the fbdev patches into mainline tree ?

Andrew Morton is.  Please cc: akpm@linux-foundation.org on all fbdev patches.


> Stanley.
> 
> On Thu, 2008-11-06 at 09:46 +0800, Jaya Kumar wrote:
> > On Thu, Nov 6, 2008 at 9:33 AM, stanley.miao <stanley.miao@windriver.com> wrote:
> > > I want generate the diffs and submit my patch. so what is the git server
> > > address ?
> > >
> > > Thanks.
> > >
> > > Stanley.
> > 
> > Hi Stanley,
> > 
> > I don't think there is a fbdev specific git tree. I think the
> > encouraged practice is to submit against the mainline tree unless you
> > have specific dependencies on another tree.


---
~Randy

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
