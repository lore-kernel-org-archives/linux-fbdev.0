From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 1/5] pxafb: add shared
	framebuffer interface
Date: Wed, 16 Jul 2008 19:10:14 +0800
Message-ID: <45a44e480807160410s2789d08dwb62e9b31837ae4f9@mail.gmail.com>
References: <1215955587-20367-1-git-send-email-jayakumar.lkml@gmail.com>
	<1215955587-20367-2-git-send-email-jayakumar.lkml@gmail.com>
	<f17812d70807160000y4fb9e543gdd25d6b6937af81e@mail.gmail.com>
	<45a44e480807160159j62b9f989l2ae99bd94d24a95f@mail.gmail.com>
	<f17812d70807160208m47c7a5f7s3e847558a89531b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KJ4tl-00041y-Jh for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 04:10:17 -0700
Received: from nf-out-0910.google.com ([64.233.182.188])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KJ4tj-0005Yf-W2
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 04:10:17 -0700
Received: by nf-out-0910.google.com with SMTP id g16so1579412nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 Jul 2008 04:10:14 -0700 (PDT)
In-Reply-To: <f17812d70807160208m47c7a5f7s3e847558a89531b3@mail.gmail.com>
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
To: eric miao <eric.y.miao@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Wed, Jul 16, 2008 at 5:08 PM, eric miao <eric.y.miao@gmail.com> wrote:
> On Wed, Jul 16, 2008 at 4:59 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>> On Wed, Jul 16, 2008 at 12:00 AM, eric miao <eric.y.miao@gmail.com> wrote:
>>> On Sun, Jul 13, 2008 at 9:26 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>>>> These changes are to make it possible for a secondary driver to share the
>>>> pxafb framebuffer. The changes include:
>>>> - adding clkdev entry in pxafb_mach_info so that a driver can pass in the
>>>>  correct struct device owner for the LCDCLK.
>>>
>>> Is it possible that LCDCLK being requested by device other than
>>> pxa_device_fb?? Could you give an example and we may work out
>>> a better solution.
>>>
>>
>> Hi Eric,
>>
>> You're right. I think LCDCLK is only ever requested by pxa_device_fb.
>>
>> I see now that instead of doing:
>> -       fbi->clk = clk_get(dev, "LCDCLK");
>> +       fbi->clk = clk_get(inf->clkdev, "LCDCLK");
>>
>> a better solution would be to directly use pxa_device_fb:
>> -       fbi->clk = clk_get(dev, "LCDCLK");
>> +       fbi->clk = clk_get(pxa_device_fb.dev, "LCDCLK");
>>
>> and then I can avoid doing the clkdev ugliness.
>>
>
> Mmm... but is there any case that (dev != pxa_device_fb.dev) ??
>

Yes. In this case, am200epd because it has a different
platform_device. This is because am200epd doesn't call set_pxa_fb_info
so that it can be unloaded.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
