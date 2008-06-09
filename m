From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: radeonfb monid i2c bus
Date: Mon, 9 Jun 2008 01:15:00 -0400
Message-ID: <a728f9f90806082215x35c81364q45583a3742bc5d2@mail.gmail.com>
References: <20080606120151.7976df45@hyperion.delvare>
	<1212760218.12464.33.camel@pasglop>
	<20080608162023.431083c7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K5Zih-00044Z-6k for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Jun 2008 22:15:04 -0700
Received: from rv-out-0708.google.com ([209.85.198.245])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K5Zif-00034n-2g
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Jun 2008 22:15:01 -0700
Received: by rv-out-0708.google.com with SMTP id f25so1734465rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 08 Jun 2008 22:15:00 -0700 (PDT)
In-Reply-To: <20080608162023.431083c7@hyperion.delvare>
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
To: Jean Delvare <khali@linux-fr.org>
Cc: benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net

On Sun, Jun 8, 2008 at 10:20 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Fri, 06 Jun 2008 23:50:18 +1000, Benjamin Herrenschmidt wrote:
>> On Fri, 2008-06-06 at 12:01 +0200, Jean Delvare wrote:
>> > Can you explain what is the "monid" i2c bus on Radeon adapters? I have
>> > two Radeon chips here, an M6 in my old laptop and a 9200 in my desktop
>> > system. On the M6 there is nothing on the monid bus. On the 9200, the
>> > monid bus doesn't even work, every access results in timeout. The
>> > radeonfb driver doesn't even look for EDID EEPROMs on that bus (except
>> > in debug code.)
>> >
>> > So I'm curious why you create this i2c bus if you don't need it.
>> > Have you ever seen a Radeon adapter where there is something on that
>> > bus?
>>
>> The BIOS connector tables might make us use it.
>
> Where is the code handling this? In radeon_monitor.c I can only see
> radeon_probe_i2c_connector() being called on ddc_vga, ddc_dvi and
> ddc_crt2. No reference to ddc_monid.

There are 4 or 5 ddc buses (really just gpios) and each oem can choose
to wire up to a connector.  The bios connector table contains this
map.  ddc_vga and ddc_dvi are the most commonly used, but I've seen
cards with other settings.  If you want the full story take a look at
the xorg radeon driver (xf86-video-ati).

>
>>                                                 Otherwise, it tends to
>> have the external TMDS transmitter on it for which we'll one day get
>> proper support for re-initializing on wakeup from sleep...
>
> But apparently not all chips have the "monid" bus? Or is it a card
> property, and other cards using the same Radeon 9200 might have it
> while mine doesn't? I wouldn't care about an empty i2c bus, but a
> broken bus as I get now affects the whole i2c subsystem and its users
> in unpleasant ways. That's why I am wondering if there's a way to avoid
> it.
>

They are just gpio pads.  All the cards supported by radeonfb have
then, but only certain ones are wired up as per the bios connector
tables on x86 cards.  Mac cards and we currently hard code them based
on lots of investigation.  I suppose, ideally, you check the connector
tables and some of the other bios tables (powerplay, external tmds,
ext dac, multimedia. etc.) and only init the buses you have a
particular card.

Alex

> Thanks,
> --
> Jean Delvare
>
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
