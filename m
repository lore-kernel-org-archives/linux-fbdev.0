From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 31 Jan 2013 10:12:05 +0000
Subject: Re: BUG: circular locking dependency detected
Message-Id: <CA+icZUVHrGcGnRcBQF1HLsR4HKOjLsOi6MppPnZCuh8K=wMHmA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130130200400.GB31748@flint.arm.linux.org.uk>
In-Reply-To: <20130130200400.GB31748@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@suse.de>, DRI <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, linux-next <linux-next@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, Takashi Iwai <tiwai@suse.de>

[ CCing Linux-Next and MMOTM folks ]

Original posting from Daniel see [0]

[ QUOTE ]
On Thu, Jan 31, 2013 at 6:40 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Jan 31, 2013 at 11:26:53AM +1100, Linus Torvalds wrote:
>> On Thu, Jan 31, 2013 at 11:13 AM, Russell King <rmk@arm.linux.org.uk> wr=
ote:
>> >
>> > Which may or may not be a good thing depending how you look at it; it
>> > means that once your kernel blanks, you get a lockdep dump.  At that
>> > point you lose lockdep checking for everything else because lockdep
>> > disables itself after the first dump.
>>
>> Fair enough, we may want to revert the lockdep checking for
>> console_lock, and make re-enabling it part of the patch-series that
>> fixes the locking.
>>
>> Daniel/Dave? Does that sound reasonable?

Yeah, sounds good.

> Reverting the patch is fine with me.  Just let me know so I can queue it
> up again for 3.9.

Can you please also pick up the (currently) three locking fixups
around fbcon? Just so that we don't repeat the same fun where people
complain about lockdep splats, but the fixes are stuck somewhere. And
I guess Dave would be happy to not end up as fbcon maintainer ;-) He
has a git branch with them at
http://cgit.freedesktop.org/~airlied/linux/log/?h=FBcon-locking-fixes
though I have a small bikeshed on his last patch pending.
-Daniel
[ /QUOTE ]

Did the 3rd patch go also to mmotm tree and got marked for Linux-Next inclu=
sion?
Best would be to have it in mainline, finally.
Please, fix that for-3.8!

Thanks to all volunteers (Alan, Andrew, Takashi Iwai (Sorry, dunno
which is 1st and last name), Daniel and finally Dave) trying to get
this incredible pain-in-the-a** upstream :-).

- Sedat -

[0] http://marc.info/?l=3Ddri-devel&m=135962051326601&w=3D2
[1] http://cgit.freedesktop.org/~airlied/linux/log/?h=FBcon-locking-fixes
[2] http://cgit.freedesktop.org/~airlied/linux/commit/?h=FBcon-locking-fixe=
s&id=98dfe36b5532576dedf41408d5bbd45fa31ec62d
