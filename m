From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [RFC 2.6.28 1/2] fbdev: add ability to set
	damage
Date: Tue, 20 Jan 2009 13:17:53 +0900
Message-ID: <aec7e5c30901192017p44204224w70032c2f367cd5fc@mail.gmail.com>
References: <12319779622958-git-send-email-jayakumar.lkml@gmail.com>
	<45a44e480901150153ta1fbe5fk5480dc5630cf1d6b@mail.gmail.com>
	<aec7e5c30901150229g3e262adeje1776fc22cac1d64@mail.gmail.com>
	<45a44e480901150308l63b4ea97rd2fbfe4fa9e2cbb4@mail.gmail.com>
	<aec7e5c30901151909k1374ae65rf52c031e5b25387f@mail.gmail.com>
	<45a44e480901160124g54547437pf5eca85c8ee52be6@mail.gmail.com>
	<aec7e5c30901160308l3f3830c7gc53717ab8cce649e@mail.gmail.com>
	<45a44e480901161414r7f0d0bc4x582c1597d439d116@mail.gmail.com>
	<aec7e5c30901182044x2fbd49f2ve0aa1b433bb4ce14@mail.gmail.com>
	<45a44e480901190715x8de194bwd3c8383207488696@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <magnus.damm@gmail.com>) id 1LP83s-0006WY-RA
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jan 2009 04:18:00 +0000
Received: from mail-bw0-f21.google.com ([209.85.218.21])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LP83n-0002Cb-Um for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jan 2009 04:18:00 +0000
Received: by bwz14 with SMTP id 14so9545498bwz.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 19 Jan 2009 20:17:54 -0800 (PST)
In-Reply-To: <45a44e480901190715x8de194bwd3c8383207488696@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, armbru@redhat.com, lethal@linux-sh.org, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Jaya!

On Tue, Jan 20, 2009 at 12:15 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Mon, Jan 19, 2009 at 12:44 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>
>
> Wow, I think there's a lot to discuss and its late so I'll focus on
> one question for now.

Yeah. =)

>> I guess the main question is how the user space interface should look
>> like. Should it export hardware capabilities?
>>
>
> I agree that above is the key question for now. What is the best way
> for userspace to expose this information to the kernel? Two approaches
> have been proposed which are that userspace does:
>
> a) provide a tile based bitmap with bits set for modified tiles.
> driver will provide information about expected tile size.

Just to make sure we are on the same page: We could let user space
provide the bitmap for us - that may be interesting - but I think it's
good enough to keep your array of rectangles as interface. It's clean
and simple. The tile bitmap can be handled internally, so each damage
call with N rectangles gets all the rectangles applied to the tile
bitmap. This over and over until the frame gets updated and the tile
bitmap gets cleared. In this case there is no maximum rectangle count
provided to user space.

> b) provide an array of rectangles. driver will provide information
> about preferred rectangle count, preferred alignment. i took out
> overlap (since i think it is always preferable to not have any
> overlapping rectangles)
>
> Okay, since I have been backing approach b up till now, I will try to
> switch positions and defend a. The main benefit I see of point a is
> that it is always a fixed amount of memory to represent the updated
> pages. The other is that it would be fairly easy for this to hook into
> the deferred IO pagemap/tilemap approach. Are there other benefits?
> What are the weaknesses? Okay, I need to reread your mails and will
> try to summarize this tomorrow. Then I will do same for approach b.

The weakness IMO for a is that we're not clear how to transform the
tile bitmap data into DMA requests. Also, if passing the bitmap from
user space then copying an entire bitmap may be heavy on a big screen
if the tile size is small enough.

Regarding b, I'm not sure if maximum rectangle count is enough
information to allow user space to make smart decisions for a wide
range of hardware. And how this will work together with for instance
deferred io is a bit unclear to me.

Cheers,

/ magnus

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
