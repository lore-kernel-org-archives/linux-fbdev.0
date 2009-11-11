From: InKi Dae <daeinki@gmail.com>
Subject: Re: [patch] added brightness feature to lcd class.
Date: Wed, 11 Nov 2009 15:17:36 +0900
Message-ID: <90b950fc0911102217o41aea871u3a5d9e44c947fe3c@mail.gmail.com>
References: <90b950fc0911020050q3bc3fae8j954ec6ed73d79b5@mail.gmail.com>
	 <1257809705.29038.82.camel@dax.rpnet.com>
	 <90b950fc0911091926v32dc1c44n1018322390282bc0@mail.gmail.com>
	 <1257842597.29038.162.camel@dax.rpnet.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751941AbZKKGRd@vger.kernel.org>
In-Reply-To: <1257842597.29038.162.camel@dax.rpnet.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@linux.intel.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

it's my comment below.

thank you.

2009/11/10 Richard Purdie <rpurdie@linux.intel.com>:
> On Tue, 2009-11-10 at 12:26 +0900, InKi Dae wrote:
>> Thank you for your comments.
>>
>> it is a good idea that lcd driver registers interfaces to lcd class
>> and backlight class.
>> but I think for AMOLED LCD Panel, backlight couldn't be real device so
>> power on/off
>> for backlight device doesn't make sense.
>
> The backlight power control can just turn the backlight level down to
> its lowest setting (off)?

>> I had tried lcd driver registers interfaces to lcd class and backlight
>> class as you said.
>> and also backlight fake driver as Pavel said.
>
> So you've tried this, what was the problem? Perhaps post this driver
> code to illustrate your problem?

all the cases worked fine.
it's not whether lcd driver has a problem or not.
I mean it's design issue of lcd class. AMOLED LCD Panel DOESN'T NEED
backlight device.
and I should have added brightness control feature to AMOLED LCD Panel
driver not using backlight class
because they have no BACKLIGHT DEVICE.

in point of view AMOLED LCD Panel, brightness control is perfomed by
gamma setting, not backlight power controlling.
