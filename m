From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: radeonfb monid i2c bus
Date: Mon, 9 Jun 2008 09:02:07 -0400
Message-ID: <a728f9f90806090602n439ec4dbqd9c59ba901ce0275@mail.gmail.com>
References: <20080606120151.7976df45@hyperion.delvare>
	<1212760218.12464.33.camel@pasglop>
	<20080608162023.431083c7@hyperion.delvare>
	<a728f9f90806082215x35c81364q45583a3742bc5d2@mail.gmail.com>
	<20080609091414.2502c49d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K5h0j-0002U1-Bd for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Jun 2008 06:02:10 -0700
Received: from rv-out-0708.google.com ([209.85.198.250])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K5h0h-0001HD-N3
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Jun 2008 06:02:09 -0700
Received: by rv-out-0708.google.com with SMTP id f25so1857557rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 09 Jun 2008 06:02:07 -0700 (PDT)
In-Reply-To: <20080609091414.2502c49d@hyperion.delvare>
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

On Mon, Jun 9, 2008 at 3:14 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Alex,
>
> Thanks for your answers.
>
> On Mon, 9 Jun 2008 01:15:00 -0400, Alex Deucher wrote:
>> On Sun, Jun 8, 2008 at 10:20 AM, Jean Delvare <khali@linux-fr.org> wrote:
>> > But apparently not all chips have the "monid" bus? Or is it a card
>> > property, and other cards using the same Radeon 9200 might have it
>> > while mine doesn't? I wouldn't care about an empty i2c bus, but a
>> > broken bus as I get now affects the whole i2c subsystem and its users
>> > in unpleasant ways. That's why I am wondering if there's a way to avoid
>> > it.
>>
>> They are just gpio pads.  All the cards supported by radeonfb have
>> then, but only certain ones are wired up as per the bios connector
>> tables on x86 cards.  Mac cards and we currently hard code them based
>> on lots of investigation.  I suppose, ideally, you check the connector
>> tables and some of the other bios tables (powerplay, external tmds,
>> ext dac, multimedia. etc.) and only init the buses you have a
>> particular card.
>
> That would indeed make sense. If these are GPIOs, do we even have any
> guarantee that they aren't used for other purposes when not used for
> I2C? I've always considered the monid I2C bus on my adapters to be
> non-existent (i2c-algo-bit can't control the lines) and that's the
> reason why I wanted it to not be created, but maybe the GPIO lines are
> actually used for something different and creating the non-existent I2C
> bus could break that?

In theory they could be used for other things, but I'm pretty sure
this set (monid, dvi, vga, crt2) is only used for i2c.

>
> So if it is possible to create the I2C buses (by default, at least)
> only when the BIOS connector tables say they are present, I'm in favor
> of doing that.

That would be ideal, unfortunately, I don't have the time to implement
anything like that for radonhd.  For anyone interested, the code in
the Xorg radeon driver would be a good guide.  The drm modesetting
work should also alleviate this, once it's done for radeon hw.

Alex

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
