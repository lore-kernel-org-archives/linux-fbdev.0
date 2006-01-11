From: "Antonino A. Daplas" <adaplas@pol.net>
Subject: Bug#347186: linux-image-2.6.14-2-alpha-generic: garbled Matrox framebuffer
Date: Wed, 11 Jan 2006 19:24:04 +0800
Message-ID: <43C4EAD4.2090704@pol.net>
References: <20060109090849.GB3481@tennyson.dodds.net> <20060109093517.GA23253@localhost.localdomain> <20060109105146.GE3481@tennyson.dodds.net> <20060111102827.GF7691@nancy>
Reply-To: "Antonino A. Daplas" <adaplas@pol.net>,
	347186@bugs.debian.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Sender: Antonino Daplas <adaplas@gmail.com>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.347186.B347186.113697865027422@bugs.debian.org>
In-Reply-To: <20060111102827.GF7691@nancy>
Sender: Antonino Daplas <adaplas@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
Content-Type: text/plain; charset="us-ascii"
To: maximilian attems <maks@sternwelten.at>
Cc: Steve Langasek <vorlon@debian.org>, 347186@bugs.debian.org, Sven Luther <sven.luther@wanadoo.fr>, linux-fbdev-devel@lists.sourceforge.net

maximilian attems wrote:
> dear adaplas,
> 
> could you please take a look at this matroxfb debian bug report:
> http://bugs.debian.org/347186
> 
> On Mon, 09 Jan 2006, Steve Langasek wrote:
> 
> <snipp>
>>>> Sigh, can't get a break with alpha kernel support around here.  After
>>>> upgrading to 2.6.14 (from 2.4.27), the Matrox framebuffer no longer works
>>>> correctly on my alpha with a Matrox Millenium II.  The matroxfb_base module
>>>> loads without error, but gives me corrupt video output only.
>>> Try turning off acceleration.
>> Doesn't make a difference.
>>
>> What did make a difference was, after googling, loading fbcon manually
>> before loading matroxfb_base.  Given that I'm loading matroxfb_base by hand
>> (/etc/modules), it's not getting loaded via udev or anything like that, it
>> seems to me that it's my responsibility to load fbcon by hand as well, but
>> it's still something of an unexpected change from 2.4.

You can always compile fbcon statically and the fbdev as modules so you get
the same behavior as 2.4.  (The separation of fbdev from fbcon is advantageous
in embedded systems where the console is not needed).

(There's a new document Documentation/fb/fbcon.txt that explains some of the
changes. It's new in 2.6.15).
 
>>  It might be nice to
>> have these modules all autoloaded by something, but it's not strictly
>> necessary, and some users may not want the framebuffer activated
>> automatically?

As long as fbcon is compiled statically, you'll get the same 2.4 behavior.

>>
>> The other issue (and the first thing I was trying to get work, which led me
>> to believe the fb was completely broken) is that, even though console works
>> on the framebuffer now, X does not.  This breakage corresponds to the kernel
>> upgrade, not to any changes in X, so still looks like a kernel bug to me.
>>
>> If I turn off "UseFBDev" in my xorg.conf, X displays correctly.  I haven't
>> poked yet to see what this does performance-wise.

The "UseFBDev" option was added to X so it can cooperate with fbcon (ie, allows
X to restore the console state by using the fbdev API ).  In 2.6, fbcon has its
own way of restoring its own state so the "UseFBDev" option is not needed, and in
your case, is counterproductive.

(I don't think removing the "UseFBDev" option will affect X performance-wise.)

Tony
