From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.27 1/2] fbdev: add E-Ink
	Broadsheet controller support
Date: Tue, 23 Dec 2008 23:30:46 -0500
Message-ID: <45a44e480812232030h4926f740ld0a0c8d3cbd00f1d@mail.gmail.com>
References: <12298571743158-git-send-email-jayakumar.lkml@gmail.com>
	<aec7e5c30812210658m4fe9b00eibc8f68dd5216b756@mail.gmail.com>
	<aec7e5c30812211812g1bd53dex5985b30dfeaece64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LFLOV-0005wd-1U
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Dec 2008 04:30:51 +0000
Received: from nf-out-0910.google.com ([64.233.182.185])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LFLOS-0002pY-U5 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Dec 2008 04:30:51 +0000
Received: by nf-out-0910.google.com with SMTP id g16so346352nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 23 Dec 2008 20:30:46 -0800 (PST)
In-Reply-To: <aec7e5c30812211812g1bd53dex5985b30dfeaece64@mail.gmail.com>
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
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Eric Miao <eric.miao@marvell.com>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sun, Dec 21, 2008 at 9:12 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> I'm still not sure if it's a sane idea to modify the fb console so it
> fsyncs. It's a separate issue I guess. Anyway, fsyncing data for each
> accelerated operation sounds a bit slow to me, especially if that
> triggers a full screen update. Think softcursor modifying a tiny part
> of the screen and we redraw the entire screen. Otoh, console may not
> be the biggest use case for deferred io. =)

Yes, you are correct that console isn't a good fit for e-ink displays
because drawing a flashing cursor will cause the whole screen to flash
every second (800ms is the minimum latency and yes, there's no partial
update capability on the metronome controller).

>
> I may hack up some shared some code later this week that triggers the
> delayed work for sys_xxx operations - same type of delayed flushing as
> my sh_mobile_lcdcfb driver. I plan on putting it in fb_defio.c and
> letting it call the sys operations. Then the deferred io drivers can
> install those callbacks into struct fb_ops directly. That way we can
> remove similar code in 3 drivers at least. I'll begin with
> sh_mobile_lcdcfb and we can do the other drivers one by one later on.
>
> I'm not sure if you think it's a good idea. It's a bit different from
> the direct fsyncing like you do today.
>

In general, your proposal sounds like a good idea to me. I'll take a
look at your patches now to understand if we're thinking the same
thing.

Thanks,
jaya

------------------------------------------------------------------------------
