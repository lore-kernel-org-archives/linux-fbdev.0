From: James Cloos <cloos@jhcloos.com>
Subject: Re: radeonfb lockup in .28-rc (bisected)
Date: Mon, 27 Oct 2008 21:46:52 -0400
Message-ID: <m3vdvdij8c.fsf@lugabout.jhcloos.org>
References: <m31vy1k3ea.fsf@lugabout.jhcloos.org>
	<20081027.170008.112856238.davem@davemloft.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752680AbYJ1Brn@vger.kernel.org>
In-Reply-To: <20081027.170008.112856238.davem@davemloft.net> (David Miller's
	message of "Mon, 27 Oct 2008 17:00:08 -0700 (PDT)")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, khc@pm.waw.pl, linux-fbdev-devel@lists.sourceforge.net

>>>>> "David" == David Miller <davem@davemloft.net> writes:

David> Please quote at least the headerline of the commit so that it can
David> come into our memory quickly when reading your report.

Good point.

David> The actual key here is that when setfont runs, the framebuffer
David> layer sets the acceleration options for the framebuffer for the
David> first time to their final settings.

Explains why it breaks.  Thanks!

>> -Memory: 512232k/524200k available (4376k kernel code, 11428k reserved, 1707k data, 320k init, 0k highmem)
>> +Memory: 512272k/524200k available (4354k kernel code, 11388k reserved, 1693k data, 316k init, 0k highmem)

David> That's just all due to the text size change because of the
David> different acceleration code.

I left a bit too much unsaid there, but that was the point I was
making.  Ie, nothing of issue.

Incidently, it only took 14 hours of compiling to accomplish the
bisect.  And that was after a s/=m$/=n/. on my .27 .config.

Anyone bisecting should know that the new HID code is not bisect-safe.
The dell, lg, bright and sony hid drivers all are auto Y if hid is Y and
embedded is N and fail to link (when bisecting) due to missing symbols.

-JimC (still waking up)
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
