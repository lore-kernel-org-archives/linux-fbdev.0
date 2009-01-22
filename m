From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.28 1/2] fbdev: add ability to set
	damage
Date: Fri, 23 Jan 2009 05:51:10 +0800
Message-ID: <45a44e480901221351y17c2224ci321657c797d57480@mail.gmail.com>
References: <12319779622958-git-send-email-jayakumar.lkml@gmail.com>
	<aec7e5c30901151909k1374ae65rf52c031e5b25387f@mail.gmail.com>
	<45a44e480901160124g54547437pf5eca85c8ee52be6@mail.gmail.com>
	<aec7e5c30901160308l3f3830c7gc53717ab8cce649e@mail.gmail.com>
	<45a44e480901161414r7f0d0bc4x582c1597d439d116@mail.gmail.com>
	<aec7e5c30901182044x2fbd49f2ve0aa1b433bb4ce14@mail.gmail.com>
	<45a44e480901190715x8de194bwd3c8383207488696@mail.gmail.com>
	<aec7e5c30901192017p44204224w70032c2f367cd5fc@mail.gmail.com>
	<8763ka4ngd.fsf@frontier.dottedmag.net>
	<aec7e5c30901192034o5bf8b29av2f409357553338a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LQ7wf-0005jN-1f
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jan 2009 22:22:41 +0000
Received: from wf-out-1314.google.com ([209.85.200.173])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LQ7wa-0008Oy-3v for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jan 2009 22:22:40 +0000
Received: by wf-out-1314.google.com with SMTP id 27so5185307wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 22 Jan 2009 14:22:35 -0800 (PST)
In-Reply-To: <aec7e5c30901192034o5bf8b29av2f409357553338a2@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, armbru@redhat.com, lethal@linux-sh.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Tue, Jan 20, 2009 at 12:34 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> I'm not against rectangles or the damage interface at all, I'm just
> wondering how we're supposed to tie it all together. In a frame buffer

Yup, no problems. I understand your position and agree that the issue
of combining everything cleanly is a question we haven't yet answered.

> driver we receive data from multiple interfaces:
>
> 1) read/write
> 2) fillrect/copyarea/imageblit
> 3) deferred io mmap pages
> 4) damage api
>

Ok, this is an interesting one to discuss. In the broadsheetfb damage
patch, currently write() and defio-mmap are treated together as they
both deliver via the pagemap. [ write() could achieve better
granularity than defio-mmap if we delivered via rects or a tilemap. ]
damage is handled separately where it delivers to an accumulating
rectlist. Then at actual transfer time (induced via defio), I check
whether we a) have damage info or b) just pagemap. If damage is
available then I treat it as the more accurate source and discard all
defio pagemap info.

This works fine for broadsheetfb because I haven't tried or really
needed to support multiple simultaneous fbdev clients. That is, I just
run X and X11 apps. I don't run X and another fbdev client, say fbcon
or say mplayer-fbdev, simultaneously or within a single defio
interval. At any one point in time, I only expect there to be one
source of data so picking the most accurate source and discarding the
others seemed reasonable.

I can see that this assumption may not hold true for the general case.
A basic case would be a user switching from X to mplayer-fbdev and
then back within a single defio interval. In that scenario, we would
receive separate sources of data. I believe it would be possible to
address this issue. I'll try to sketch some code to handle this soon.

> I'm wondering if we can tie in 1->4 using bitmaps and generate dma
> requests from that. I guess everyone else talks about 4 only. =)
>

That's what I'm wondering about too and yes, previously I had only
considered 4, but now I'll think about the bigger picture as you
suggested.

Thanks,
jaya

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
