From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [PATCH v4] fbdev: add new TMIO framebuffer
	driver
Date: Wed, 8 Oct 2008 22:52:19 +0400
Message-ID: <bc64b4640810081152v36a35913n5f4f5f6a03484bff@mail.gmail.com>
References: <1223463303-32700-1-git-send-email-dbaryshkov@gmail.com>
	<20081008171546.GA4766@localdomain> <gcisol$ico$1@ger.gmane.org>
	<20081008111653.67c55f12.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dbaryshkov@gmail.com>) id 1Kne98-0003MR-5V
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Oct 2008 18:52:30 +0000
Received: from mail-gx0-f19.google.com ([209.85.217.19])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Kne8z-0002Ix-CD for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Oct 2008 18:52:30 +0000
Received: by gxk12 with SMTP id 12so9146124gxk.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 08 Oct 2008 11:52:20 -0700 (PDT)
In-Reply-To: <20081008111653.67c55f12.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

2008/10/8 Andrew Morton <akpm@linux-foundation.org>:
>
> Please never change the Cc: list.  Just do reply-to-all all the time.

I do reply-to-all, when I use mail client. However sometimes I use gmane, and so
all to:/cc: list is dropped.

>
> On Wed, 8 Oct 2008 18:05:09 +0000 (UTC) Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:
>
>> Samuel Ortiz wrote:
>>
>> > On Wed, Oct 08, 2008 at 02:55:03PM +0400, Dmitry Baryshkov wrote:
>> >> Add driver for TMIO framebuffer cells as found e.g. in Toshiba TC6393XB
>> >> chips.
>> >>
>> >> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com> Cc: Ian Molton
>> >> <spyro@f2s.com>
>> >> Cc: Samuel Ortiz <sameo@openedhand.com>
>> > Acked-by: Samuel Ortiz <sameo@openedhand.com>
>>
>> Thanks. And as Kristoffer acked one of previous revisions of this driver,
>> I hope he will also ack this one. Now the question is: via which tree should
>> this driver be merged? Is there any specific FB tree? Or should I send pull
>> request directly to Linus when the window will open :) ?
>
> fbdev patches are meged via the -mm tree.  I have this email thread
> saved away for review-and-merge.  It might take me a few days - I like
> to leave things, to let the dust settle.

Fine with me, thank you. I just wanted to know the way for fbdev patches.

-- 
With best wishes
Dmitry

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
