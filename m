From: Michal Suchanek <hramrach@centrum.cz>
Subject: Re: [RFC 2.6.28 1/2] fbdev: add ability to set
	damage
Date: Tue, 20 Jan 2009 11:22:24 +0100
Message-ID: <a5d587fb0901200222t66706941ne41d280ea4d398df@mail.gmail.com>
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
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hramrach@gmail.com>) id 1LPDkd-0008P8-AK
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jan 2009 10:22:31 +0000
Received: from fg-out-1718.google.com ([72.14.220.159])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LPDkY-0005Zn-9f for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jan 2009 10:22:31 +0000
Received: by fg-out-1718.google.com with SMTP id d23so1426942fga.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 20 Jan 2009 02:22:24 -0800 (PST)
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
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Jaya Kumar <jayakumar.lkml@gmail.com>, armbru@redhat.com, lethal@linux-sh.org, Geert Uytterhoeven <geert@linux-m68k.org>

2009/1/20 Magnus Damm <magnus.damm@gmail.com>:
> On Tue, Jan 20, 2009 at 1:21 PM, Mikhail Gusarov
> <dottedmag@dottedmag.net> wrote:
>>
>> Twas brillig at 13:17:53 20.01.2009 UTC+09 when magnus.damm@gmail.com did gyre and gimble:
>>
>>  MD> but I think it's good enough to keep your array of rectangles as
>>  MD> interface. It's clean and simple.
>>
>> It also matches some hardware's interfaces -- there are e-ink
>> controllers which can update specified rectangles on screen, so damage
>> bitmap is not needed for such controllers at all.
>
> Well, needed or not probably depends on what the aim for all this is. =)
>
> I'm not against rectangles or the damage interface at all, I'm just
> wondering how we're supposed to tie it all together. In a frame buffer
> driver we receive data from multiple interfaces:
>
> 1) read/write
> 2) fillrect/copyarea/imageblit
> 3) deferred io mmap pages
> 4) damage api
>
> I'm wondering if we can tie in 1->4 using bitmaps and generate dma
> requests from that. I guess everyone else talks about 4 only. =)
>

Perhaps it would not be unreasonable to provide an userspace tool such
as a library or a daemon that keeps track of the framebuffer state and
tells each driver exactly what it is supposed to do, exactly in the
way which is suitable for that particular hardware.

Since this is about creating a new interface which would be used only
on a specialized hardware I do not think introducing an userspace
component would be a problem.

Thanks

Michal

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
