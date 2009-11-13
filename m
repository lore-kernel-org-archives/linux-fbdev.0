From: InKi Dae <daeinki@gmail.com>
Subject: Re: [patch] added brightness feature to lcd class.
Date: Fri, 13 Nov 2009 12:13:54 +0900
Message-ID: <90b950fc0911121913o2b5285f5w23c706aed3203e65@mail.gmail.com>
References: <90b950fc0911020050q3bc3fae8j954ec6ed73d79b5@mail.gmail.com>
	 <1257809705.29038.82.camel@dax.rpnet.com>
	 <90b950fc0911091926v32dc1c44n1018322390282bc0@mail.gmail.com>
	 <1257842597.29038.162.camel@dax.rpnet.com>
	 <90b950fc0911102217o41aea871u3a5d9e44c947fe3c@mail.gmail.com>
	 <1257931717.29038.298.camel@dax.rpnet.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755444AbZKMDN5@vger.kernel.org>
In-Reply-To: <1257931717.29038.298.camel@dax.rpnet.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@linux.intel.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

Ok, I understood your answer.
Just it was my idea for AMOLED LCD Panel.
Both of them (AMOLED, TFT-LCD) do same thing in terms of brightness
control as you said.

Thank you, Richard.

Best Regards,
InKi Dae.

2009/11/11 Richard Purdie <rpurdie@linux.intel.com>:
> On Wed, 2009-11-11 at 15:17 +0900, InKi Dae wrote:
>> 2009/11/10 Richard Purdie <rpurdie@linux.intel.com>:
>> > So you've tried this, what was the problem? Perhaps post this driver
>> > code to illustrate your problem?
>>
>> all the cases worked fine.
>> it's not whether lcd driver has a problem or not.
>> I mean it's design issue of lcd class. AMOLED LCD Panel DOESN'T NEED
>> backlight device.
>> and I should have added brightness control feature to AMOLED LCD Panel
>> driver not using backlight class
>> because they have no BACKLIGHT DEVICE.
>>
>> in point of view AMOLED LCD Panel, brightness control is perfomed by
>> gamma setting, not backlight power controlling.
>
> The question is whether this gamma control does the same thing as what
> we've traditionally used the backlight brightness control for. As I
> understand it, the answer is yes and to userspace making it appear as a
> backlight brightness control makes sense.
>
> The userspace view of the world is key and the fact there is not a
> traditional physical backlight in the hardware isn't really an issue.
>
> Why would we want to create two userspace interfaces doing the same
> thing which would mean we just have to complicate userspace drivers?
> Symlinking just makes things confusing.
>
> Cheers,
>
> Richard
>
>
>
