From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: deferred IO
Date: Fri, 6 Jun 2008 03:55:51 -0700
Message-ID: <45a44e480806060355u6068a92bladb6e13c383c66d6@mail.gmail.com>
References: <200806061134.13496.cuse@users.sourceforge.net>
	<45a44e480806060240j44887451q12c47595ca76df27@mail.gmail.com>
	<200806061251.26134.cuse@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4Zbs-00021i-3H for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 03:55:52 -0700
Received: from wf-out-1314.google.com ([209.85.200.171])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K4Zbr-0001aU-RW
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 03:55:52 -0700
Received: by wf-out-1314.google.com with SMTP id 27so911917wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 06 Jun 2008 03:55:51 -0700 (PDT)
In-Reply-To: <200806061251.26134.cuse@users.sourceforge.net>
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
To: Christian Schoenebeck <cuse@users.sourceforge.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, Jun 6, 2008 at 3:51 AM, Christian Schoenebeck
<cuse@users.sourceforge.net> wrote:
> Es geschah am Friday 06 June 2008 als Jaya Kumar schrieb:
>> On Fri, Jun 6, 2008 at 2:34 AM, Christian Schoenebeck
>>
>> <cuse@users.sourceforge.net> wrote:
>> > Hi!
>> >
>> > Is it possible that the deferred IO implementation in kernel 2.6.22 is
>> > buggy?
>>
>> Yes, that's possible. There was a key bug fixed in 2.6.25. You'll
>> probably want at least the following commit:
>>
>> commit        de7c6d15e354bc94a846f03749819768c331280a
>> fbdev: defio and Metronomefb
>
> Very good, thanks a lot!
> Is there an easy way to retrieve that specific patch?
>

I think git cherry-pick should be possible. Alternatively, I think you
can download just the fb_defio.c changes from:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=de7c6d15e354bc94a846f03749819768c331280a

and apply it that way. Hope that helps.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
