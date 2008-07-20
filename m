From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 1/5] pxafb: add shared
	framebuffer interface
Date: Sat, 19 Jul 2008 22:41:38 -0400
Message-ID: <45a44e480807191941pb05934ay33c519c586572861@mail.gmail.com>
References: <1215955587-20367-1-git-send-email-jayakumar.lkml@gmail.com>
	<1215955587-20367-2-git-send-email-jayakumar.lkml@gmail.com>
	<f17812d70807160000y4fb9e543gdd25d6b6937af81e@mail.gmail.com>
	<45a44e480807160159j62b9f989l2ae99bd94d24a95f@mail.gmail.com>
	<20080716093855.GC23468@flint.arm.linux.org.uk>
	<45a44e480807160418g10090321uc57c338987d74b30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KKOrl-0002Ss-98 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 19 Jul 2008 19:41:41 -0700
Received: from nf-out-0910.google.com ([64.233.182.186])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KKOrj-0000X1-Lu
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 19 Jul 2008 19:41:41 -0700
Received: by nf-out-0910.google.com with SMTP id g16so251134nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 19 Jul 2008 19:41:38 -0700 (PDT)
In-Reply-To: <45a44e480807160418g10090321uc57c338987d74b30@mail.gmail.com>
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
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, ymiao3@marvell.com, eric miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

On Wed, Jul 16, 2008 at 7:18 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Wed, Jul 16, 2008 at 5:38 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Wed, Jul 16, 2008 at 01:59:42AM -0700, Jaya Kumar wrote:
>>> On Wed, Jul 16, 2008 at 12:00 AM, eric miao <eric.y.miao@gmail.com> wrote:
>>> > On Sun, Jul 13, 2008 at 9:26 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>>> >> These changes are to make it possible for a secondary driver to share the
>>> >> pxafb framebuffer. The changes include:
>>> >> - adding clkdev entry in pxafb_mach_info so that a driver can pass in the
>>> >>  correct struct device owner for the LCDCLK.
>>> >
>>> > Is it possible that LCDCLK being requested by device other than
>>> > pxa_device_fb?? Could you give an example and we may work out
>>> > a better solution.
>>>
>>> You're right. I think LCDCLK is only ever requested by pxa_device_fb.
>>>
>>> I see now that instead of doing:
>>> -       fbi->clk = clk_get(dev, "LCDCLK");
>>> +       fbi->clk = clk_get(inf->clkdev, "LCDCLK");
>>>
>>> a better solution would be to directly use pxa_device_fb:
>>> -       fbi->clk = clk_get(dev, "LCDCLK");
>>> +       fbi->clk = clk_get(pxa_device_fb.dev, "LCDCLK");
>>>
>>> and then I can avoid doing the clkdev ugliness.
>>
>> PXA devices (intentionally) aren't exported.  Nor are they going to be,
>> so the above will fail if built as a module.
>>
>
> Ah... I think this may be the cause of all my troubles. I've been
> trying to support am200epd working as a module, and allow it to rmmod
> cleanly, hence the inability to use pxa_device_fb through
> set_pxa_fb_info. If module support isn't important then I can happily
> take out unload support from am200epd and probably can then use
> set_pxa_fb_info and also reduce complexity in other parts of the
> metronomefb, am200epd, pxafb code.
>

Hi Eric,

I've run into some difficulties. set_pxa_fb_info is:

void __init set_pxa_fb_info(struct pxafb_mach_info *info)

and not exported. Therefore am200epd can't be built as a module now
that it depends on set_pxa_fb_info. That is fine, I switched am200epd
to a built-in. But then because set_pxa_fb_info is __init, it
disappears before am200epd is ready to call it. This is because
am200epd needs metronomefb's framebuffer size and info which it only
finds out after full boot into userspace when it gets its firmware
from a udev script. I think this means that I would also need to make
metronomefb a built-in and figure out how to compile in metronome's
firmware. I haven't figured out how to do the latter yet.

I started thinking about maybe creating something different, like
maybe set_mod_pxa_fb_info that would work more dynamically (ie: alloc
a platform_device dynamically, thus making it possible for
device_release to work, rather than using a static struct
pxa_device_fb) and allow for module support without requiring any
exports other than itself. Is this something that's of interest  or
should I focus on the former?

Thanks,
jaya

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
