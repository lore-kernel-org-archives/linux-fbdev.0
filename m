From: Jiri Kosina <jkosina@suse.cz>
Date: Thu, 25 Feb 2010 15:18:08 +0000
Subject: Re: [PATCH 1/3] picolcd: driver for PicoLCD HID device
Message-Id: <alpine.LNX.2.00.1002251615570.30967@pobox.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100221002001.0a7e05a7@neptune.home> <20100224170049.0d04af3c@neptune.home> <alpine.LNX.2.00.1002251201430.30967@pobox.suse.cz> <20100225123214.0523a310@neptune.home>
In-Reply-To: <20100225123214.0523a310@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>

On Thu, 25 Feb 2010, Bruno Pr=E9mont wrote:

> For the two sysfs attributes I currently use, the 'reset' one shall=20
> probably be moved to debugfs (I would like to place it under=20
> /sys/kernel/debug/hid/$device/ next to rdesc and event).

Yes, that would make sense.

( ... which reminds me to finally to the Documentation/ABI part in sync=20
with respect to current HID code again ... )

> By the way, I'm wondering why event does not list any of the reports=20
> coming from my device though as I understand the code it should be doing =

> that before my raw_event function gets called...

Sorry, what 'event' do you mean in 'event does not list any of the=20
reports'?

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
