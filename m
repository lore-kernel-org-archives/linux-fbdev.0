From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [RFC] Initial OLPC Viafb merge
Date: Tue, 13 Apr 2010 05:03:33 +0200
Message-ID: <4BC3DF05.9060400@gmx.de>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>	<4BBEBE87.4000809@gmx.de>	<20100409124626.0b150104@bike.lwn.net>	<4BBFB914.1020600@gmx.de>	<20100409182722.3080bb2d@bike.lwn.net>	<4BBFCE24.2070207@gmx.de> <20100410105241.5df22845@neptune.home>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100410105241.5df22845@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

Bruno Pr=E9mont schrieb:
> On Sat, 10 April 2010 Florian Tobias Schandinat <FlorianSchandinat@gm=
x.de> wrote:
>> Jonathan Corbet schrieb:
>>> Well, if we want to keep s/r out of tree, we can do that.  It will
>>> complicate the merge of the other stuff, since it's got hooks into =
the
>>> GPIO and camera code too.  But, like everything else I've posted so
>>> far, it's not the work that I personally set out to do.  I can push
>>> that work on others :)

Good news! After some hours of hacking, damaging a filesystem and nearl=
y=20
smashing my SD card I've found a promising way to implement suspend and=
=20
resume in viafb based on the first patch of this series. I think this i=
s=20
something that can be done for the next merge window. I'll start a clea=
n=20
implementation after Jon sent an updated patch series (including the=20
initial s&r implementation)

>> At least I'd like some more time (multiple weeks) to have a look at =
this=20
>> issue & patches and try to come up with improvements that make it li=
kely=20
>> work on other IGPs and eventually not needing any BIOS/OFW. I agree =
its=20
>> already an improvement but certainly one of the kind I like less as =
VIA=20
>> could come up with such "improvements" too. IMHO it's a bad thing to=
=20
>> push one chipset first if the target is to support all equally well =
(as=20
>> long as the hardware permits).

Goal basically reached:
- likely to work on all IGPs as nothing directly IGP dependent is there
- works without OFW/BIOS

However:
- suspending is very slow, looks like it takes double the time compared=
=20
to before s&r support was added to viafb (this is also with only the=20
original patch)
- output device setting is messed up (example: before suspend the outpu=
t=20
was on DVI, after resume on CRT)
- does not restore some values in the mmio but reinitializes it instead=
=2E=20
Do you need any special values restored, Jon?

> In my case (Commell LE 365) the BIOS offers an option to restore grap=
hics
> to text mode on resume so the manual call of 'fbset -a $MODE' works
> pretty well, only the acceleration has issues.
> I don't remember if accel can get revived with vanilla 2.6.34-rc2 if =
it
> was disabled before suspend.

Acceleration doesn't work in 2.6.34-rc2 or later after resume (limited=20
only to the cursor, the rest works for me). It will work after the=20
patches I am going to do are applied.

> When I get time to, I will give these patches a try. A central GIT tr=
ee
> where all viafb patches get collected would definitely be nice (even =
with
> multiple semi-throw-away "topic" branches).

Yes, I guess that would be a good idea at least now where 2 people are=20
actively working on viafb. I have also a few minor patches ready I'll=20
send in a few days (after having repaired my development environment).


Best regards,

=46lorian Tobias Schandinat
