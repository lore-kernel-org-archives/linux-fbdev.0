From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [RFC 2.6.27 1/2] fbdev: add E-Ink
	Broadsheet controller support
Date: Mon, 22 Dec 2008 11:12:04 +0900
Message-ID: <aec7e5c30812211812g1bd53dex5985b30dfeaece64@mail.gmail.com>
References: <12298571743158-git-send-email-jayakumar.lkml@gmail.com>
	<aec7e5c30812210658m4fe9b00eibc8f68dd5216b756@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <magnus.damm@gmail.com>) id 1LEaH9-0003lX-Ji
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Dec 2008 02:12:07 +0000
Received: from wf-out-1314.google.com ([209.85.200.169])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LEaH8-0008HC-1o for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Dec 2008 02:12:07 +0000
Received: by wf-out-1314.google.com with SMTP id 27so1930305wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 21 Dec 2008 18:12:04 -0800 (PST)
In-Reply-To: <aec7e5c30812210658m4fe9b00eibc8f68dd5216b756@mail.gmail.com>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Eric Miao <eric.miao@marvell.com>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sun, Dec 21, 2008 at 11:58 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Hi Jaya,
>
> On Sun, Dec 21, 2008 at 7:59 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>> This patch adds support for the E-Ink Broadsheet display controller
>
> Looking good. While at the topic of deferred io I took the opportunity
> to ask a bit about that below.
>
> I sort of expected to see fb_sys_write here. Same thing for
> metronomefb. I wonder why you chose a custom write callback instead of
> fb_sys_write. Maybe I need to do the same thing for sh_mobile_lcdcfb
> and if so then we could hopefully share that code between our drivers.
> =)
>
> By using the xxx_dpy_update() function these drivers seem to force a
> full screen update in their write() path. I'm not sure why though,
> shouldn't the write() case should just let the fb_sync callback do the
> sync for you? The fb_sys_write() function calls fb_sync _before_
> writing though, I wonder why. Doesn't make sense to me - _after_
> copying data sounds like a better place to flush. I don't know the
> history of the code though, so there may be a good reason for this.

Ok, I think I can answer that myself now:
The fb_sync() callback is used to synchronize hardware acceleration,
not to flush data. That's why it is syncing before the write
operation. My bad, I mixed fb_sync() up with the fsync() operation.

> Also, this brings up to another interesting topic. While I was hacking
> on deferred io for the sh_mobile_lcdcfb driver I realized that I
> needed hooks to update the screen for the callbacks fb_fillarea,
> fb_copyarea and fb_imageblit. The metronomefb driver and this one both
> force a full screen update for each operation. In sh_mobile_lcdcfb I
> chose to just schedule the delayed work instead. Either way is fine of
> course, but this issue does not seem driver specific to me. So I
> wonder if it is worth breaking out these sys-functions and handle all
> that in fb_defio.c instead. But maybe we're just covering for the fact
> that the fb console isn't syncing as it should?

I'm still not sure if it's a sane idea to modify the fb console so it
fsyncs. It's a separate issue I guess. Anyway, fsyncing data for each
accelerated operation sounds a bit slow to me, especially if that
triggers a full screen update. Think softcursor modifying a tiny part
of the screen and we redraw the entire screen. Otoh, console may not
be the biggest use case for deferred io. =)

I may hack up some shared some code later this week that triggers the
delayed work for sys_xxx operations - same type of delayed flushing as
my sh_mobile_lcdcfb driver. I plan on putting it in fb_defio.c and
letting it call the sys operations. Then the deferred io drivers can
install those callbacks into struct fb_ops directly. That way we can
remove similar code in 3 drivers at least. I'll begin with
sh_mobile_lcdcfb and we can do the other drivers one by one later on.

I'm not sure if you think it's a good idea. It's a bit different from
the direct fsyncing like you do today.

Thanks for your help!

/ magnus

------------------------------------------------------------------------------
