From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH v2] viafb: 2D engine rewrite (and
 viafb patches in general)
Date: Sun, 06 Sep 2009 02:38:37 +0200
Message-ID: <4AA3048D.2090605@gmx.de>
References: <1251666438-5448-1-git-send-email-FlorianSchandinat@gmx.de>	<1252097032-3568-1-git-send-email-FlorianSchandinat@gmx.de>	<20090905161645.74a49a84@bike.lwn.net>
	<20090905160140.7b36527f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <FlorianSchandinat@gmx.de>) id 1Mk5mY-0006Tb-3R
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 06 Sep 2009 00:39:02 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 29vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1Mk5mV-0005SO-Pr for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 06 Sep 2009 00:39:00 +0000
In-Reply-To: <20090905160140.7b36527f.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: JosephChan@via.com.tw, ScottFang@viatech.com.cn, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>

Andrew Morton schrieb:
> On Sat, 5 Sep 2009 16:16:45 -0600 Jonathan Corbet <corbet@lwn.net> wrote:
> 
>> On Fri,  4 Sep 2009 20:43:52 +0000
>> Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
>>
>>> This patch is a completly rewritten 2D engine. The engine is no longer
>>> in a default state but reinitialized every time to allow usage for both
>>> framebuffers regardless of their settings.
>>> The whole engine handling is concentrated in a big function which takes
>>> 16 parameters.
>> Ouch, that's a lot of parameters.  Might it be better to create a
>> structure to encapsulate all of those drawing parameters?
> 
> I was wondering that.  There's less advantage to that than usual
> because the call graph is not at all deep.

I thought about encapsulating the geometric surface parameter (base, 
pitch, x, y) for source and destination as they somehow belong together. 
That would reduce it to 10 parameters but I don't know whether it's 
worth the effort. The number of parameters simply resulted from the idea 
to have one central function which needs to be changed if the engine 
changes and that allows a 2D acceleration in a completely state 
independent manner to allow using it for for 2 or more framebuffers or 
whatever one wants to blit in the video memory.

>> On a more general level: is anybody maintaining a tree for patches to
>> the viafb driver?
> 
> -mm.

I just pushed all my patches (also in -mm) up there:
http://github.com/schandinat/linux-2.6-viafb/commits/master
But to get something included in the driver one should really send it to 
Andrew.

>>  I'm going to be doing some work here (writing a
>> driver for the video capture engine), and there's patches sitting in
>> Harald's tree and the OLPC tree.
> 
> As far as the rest of the world is concerned, that stuff doesn't exist.

I'll try to sort out the patches that still add anything to my stuff. I 
know Harald's tree and I know that I probably broke every of his 
patches. However, he seems to not have done anything for about 3 months 
so I rebased/rewrote my patches on linux-2.6 and started sending. I 
guess in the meantime I obsolated about half of his patches but there 
are still some things I'd like to have (PCI rework, VX855/OLPC support). 
Although I'm a bit unsure how to take these things, fix them to apply on 
top of my changes and correctly give the original author credit for it.

Do you have a pointer to the OLPC tree?

I'd really like to see VX855/OLPC support in mainline as soon as 
possible as I consider it a good thing to support "new" hardware early. 
However even if I am capable to write such support based on Haralds work 
I don't want to see it in mainline as long as no one with that hardware 
tested it.

>>  It seems like a central merge point
>> might be a nice thing to have.
>>
>> I'd be happy to run such a tree.  I'm really *not* qualified to be
>> passing judgment on patches to the framebuffer driver at this point,
>> though, so I'm not sure that I'm the best person for the job.
> 
> Send 'em over.  I haven't heard anything from the original viafb
> submitters for a long time.  Hopefully Florian has time to help out
> with some review-n-test.

I do not object against a tree that collects all viafb patches, I even 
could do it. But one should really send the patches to Andrew ASAP as 
otherwise we may end up with a dead forest ;)
Actually it would be very nice to see some more activity around viafb. 
It might be bad if I'm the only one who patches it and who knows how it 
works. Discussion can be quite inspiring.

I'll do the things I can. But in the next few weeks I'll be probably a 
bit short on time. Okay I guess I won't do any big patches for a while 
but wait until some patches advance or receive some comments. So I still 
have some time to review-n-test but expect some delay. In the long run 
my test platform might become better as I'll be able to 'revive' some 
old VIA boards currently not available for testing.


Regards,

Florian Tobias Schandinat

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
