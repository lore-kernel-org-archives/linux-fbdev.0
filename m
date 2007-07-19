From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [git patches] two warning fixes
Date: Thu, 19 Jul 2007 19:20:37 +0100
Message-ID: <20070719192037.687e3608@oldman>
References: <20070718235504.GA9601@havoc.gtf.org>
	<alpine.LFD.0.999.0707181834070.27353@woody.linux-foundation.org>
	<469ECD29.2010909@garzik.org> <m3r6n4bjgg.fsf@maximus.localdomain>
	<alpine.LFD.0.999.0707191100480.27353@woody.linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBacK-0006nb-B9 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Jul 2007 11:20:52 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IBacI-0005aM-P1
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Jul 2007 11:20:48 -0700
Received: from oldman ([87.192.216.40]) (authenticated bits=0)
	by smtp2.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id
	l6JIKYL6007563
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 19 Jul 2007 11:20:38 -0700
In-Reply-To: <alpine.LFD.0.999.0707191100480.27353@woody.linux-foundation.org>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Thu, 19 Jul 2007 11:04:29 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Thu, 19 Jul 2007, Krzysztof Halasa wrote:
> >
> > Jeff Garzik <jeff@garzik.org> writes:
> > 
> > > My overall goal is killing useless warnings
> > > that continually obscure real ones.
> > 
> > Precisely, the goal should be to make must_check (and similar things)
> > warn only in real cases.
> 
> .. the problem with that mentality is that it's not how people work.
> 
> People shut up warnings by adding code.
> 
> Adding code tends to add bugs.
> 
> People don't generally think "maybe that warning was bogus".
> 
> More people *should* generally ask themselves: "was the warning worth it?" 
> and then, if the answer is "no", they shouldn't add code, they should 
> remove the thing that causes the warning in the first place.
> 
> For example, for compiler options, the correct thign is often to just say 
> "that option was broken", and not use "-fsign-warning", for example. We've 
> literally have had bugs *added* because people "fixed" a sign warning. 
> More than once, in fact.
> 
> Every time you see a warning, you should ask yourself: is the warning 
> interesting, correct and valid? And if it isn't all three, then the 
> problem is whatever *causes* the warning, not the code itself.
> 
> 			Linus

Can we ever get the gcc developers to fix all the bogus warnings
about variables that "might not be set"?

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
