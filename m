From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.28 1/2] fbdev: add ability to set
	damage
Date: Mon, 19 Jan 2009 23:15:36 +0800
Message-ID: <45a44e480901190715x8de194bwd3c8383207488696@mail.gmail.com>
References: <12319779622958-git-send-email-jayakumar.lkml@gmail.com>
	<1232011502.900.107.camel@tubuntu>
	<45a44e480901150153ta1fbe5fk5480dc5630cf1d6b@mail.gmail.com>
	<aec7e5c30901150229g3e262adeje1776fc22cac1d64@mail.gmail.com>
	<45a44e480901150308l63b4ea97rd2fbfe4fa9e2cbb4@mail.gmail.com>
	<aec7e5c30901151909k1374ae65rf52c031e5b25387f@mail.gmail.com>
	<45a44e480901160124g54547437pf5eca85c8ee52be6@mail.gmail.com>
	<aec7e5c30901160308l3f3830c7gc53717ab8cce649e@mail.gmail.com>
	<45a44e480901161414r7f0d0bc4x582c1597d439d116@mail.gmail.com>
	<aec7e5c30901182044x2fbd49f2ve0aa1b433bb4ce14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LOvqr-00067r-Sc
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jan 2009 15:15:45 +0000
Received: from yx-out-1718.google.com ([74.125.44.158])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LOvqj-0000ic-4Z for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jan 2009 15:15:45 +0000
Received: by yx-out-1718.google.com with SMTP id 3so1133896yxi.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 19 Jan 2009 07:15:36 -0800 (PST)
In-Reply-To: <aec7e5c30901182044x2fbd49f2ve0aa1b433bb4ce14@mail.gmail.com>
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

On Mon, Jan 19, 2009 at 12:44 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>

Wow, I think there's a lot to discuss and its late so I'll focus on
one question for now.

>
> I guess the main question is how the user space interface should look
> like. Should it export hardware capabilities?
>

I agree that above is the key question for now. What is the best way
for userspace to expose this information to the kernel? Two approaches
have been proposed which are that userspace does:

a) provide a tile based bitmap with bits set for modified tiles.
driver will provide information about expected tile size.
b) provide an array of rectangles. driver will provide information
about preferred rectangle count, preferred alignment. i took out
overlap (since i think it is always preferable to not have any
overlapping rectangles)

Okay, since I have been backing approach b up till now, I will try to
switch positions and defend a. The main benefit I see of point a is
that it is always a fixed amount of memory to represent the updated
pages. The other is that it would be fairly easy for this to hook into
the deferred IO pagemap/tilemap approach. Are there other benefits?
What are the weaknesses? Okay, I need to reread your mails and will
try to summarize this tomorrow. Then I will do same for approach b.

Thanks,
jaya

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
