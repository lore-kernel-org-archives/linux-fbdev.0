From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 3/5] pxafb: add shared
	framebuffer interface
Date: Sat, 2 Aug 2008 08:06:52 -0400
Message-ID: <45a44e480808020506k6a28205cp35abe709ac7dcec8@mail.gmail.com>
References: <1217422269-11093-1-git-send-email-jayakumar.lkml@gmail.com>
	<1217422269-11093-4-git-send-email-jayakumar.lkml@gmail.com>
	<20080731172841.103671c1.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KPFsu-0003Yv-7I for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Aug 2008 05:06:56 -0700
Received: from nf-out-0910.google.com ([64.233.182.185])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KPFst-0001Fx-Jh
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Aug 2008 05:06:56 -0700
Received: by nf-out-0910.google.com with SMTP id g16so448606nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Aug 2008 05:06:53 -0700 (PDT)
In-Reply-To: <20080731172841.103671c1.krzysztof.h1@poczta.fm>
Content-Disposition: inline
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, Jul 31, 2008 at 11:28 AM, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> On Wed, 30 Jul 2008 08:51:07 -0400
> Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>
>> These changes are to make it possible for a secondary driver to share the
>> pxafb framebuffer. The changes include:
>> - adding extra_video_mem entry so that a driver can tell pxafb of its
>>   additional needs.
>> - adding share_video_mem/unshare_video_mem callbacks to notify the secondary
>>   driver of the framebuffer address, to allow refcounting, and to cleanup on
>>   completion.
>>

Hi Krzysztof,

Thanks for the review. I have a feeling though that I have made a
design mistake. My approach has been too specific to pxafb and I think
the addition of callbacks to mach_pxa_info is not something that will
be acked. My apologies for that. So I'll go and take some time to
rethink my design and hopefully come up with something cleaner and
more generic. I have an idea of using fb notifiers which I think will
allow this all to work without needing any custom changes to pxafb.
I'm sorry for having taken up everyones time with the previous
approach.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
