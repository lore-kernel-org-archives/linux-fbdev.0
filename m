From: Eric Miao <eric.y.miao@gmail.com>
Date: Tue, 15 Feb 2011 11:43:07 +0000
Subject: Re: [PATCH] ARM: PXA: Make PXA27x/PXA3xx overlay actually work
Message-Id: <AANLkTiniWVt-EA94vFx9f1gCO1oFdoEXrEtnW578qdTo@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1296679619-32666-1-git-send-email-anarsoul@gmail.com>
	<AANLkTi=AfxN73pSNZ5RiTiTWfxR7PhcyJUyXzzeaYNWw@mail.gmail.com>
	<20110215094808.GB4152@n2100.arm.linux.org.uk>
In-Reply-To: <20110215094808.GB4152@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 15, 2011 at 5:48 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 15, 2011 at 03:35:44PM +0800, Eric Miao wrote:
>> > @@ -720,12 +726,10 @@ static int overlayfb_open(struct fb_info *info, int user)
>> >        if (user = 0)
>> >                return -ENODEV;
>> >
>> > -       /* allow only one user at a time */
>> > -       if (atomic_inc_and_test(&ofb->usage))
>> > -               return -EBUSY;
>> > +       if (ofb->usage++ = 0)
>> > +               /* unblank the base framebuffer */
>> > +               fb_blank(&ofb->fbi->fb, FB_BLANK_UNBLANK);
>>
>> The change above allows multiple user at a time? Then I guess
>> some other places need to be changed accordingly to avoid the
>> racing conditions.
>
> You can't prevent multiple users.  Think threaded applications which
> share the same set of fds.
>
> Any driver which tries to do so by restricting the number of open()s is
> simply buggy.
>

OK, let's go ahead fix the racing conditions later.
