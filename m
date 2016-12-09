From: Dave Airlie <airlied@gmail.com>
Date: Fri, 09 Dec 2016 00:08:18 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <CAPM=9twUSRvfmh2ENMXTwCx-ULGzmPpyHs_wMM0XGDeWHMhnXw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <1481158879.26959.41.camel@kernel.crashing.org>
 <20161208101005.6ufl3d4qvwprosju@phenom.ffwll.local>
 <1481232519.26959.49.camel@kernel.crashing.org>
In-Reply-To: <1481232519.26959.49.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

On 9 December 2016 at 07:28, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2016-12-08 at 11:10 +0100, Daniel Vetter wrote:
>> > With drmfb you basically have to shadow everything into memory & copy
>> > over everything, and locks you out of simple 2D accel. For a simple text
>> > console the result is orders of magnitude slower and memory hungry than
>> > a simple fbdev.
>>
>> Not true, we have full fbdev emulation, and drivers can implement the 2d
>> accel in there. And a bunch of them do. It's just that most teams decided
>> that this is pointless waste of their time.j
>
> Ok so my knowledge might be outdated here. I was complaining to Dave about
> how cirrusdrmfb didn't even use blits for fbcon scrolling and always double
> buffered everything, and Dave made the point that you basically had to do
> that for security reasons that I mostly forgot the details of.
>
> It looks like bochsdrmfb and astdrmfb are the same. If things have changed,
> then cool. Can you point me to a drmfb driver that is a good (and not too
> complex) example with simple 2d accel ? I'm thinking mostly of color
> expansion, bitblt and solid fill for fbcon, the way I used to do it in
> radeonfb for example.

What are people using fbcon for that needs acceleration, this is where I get
a bit lost.

It's a console, if you aren't sshing into the machine.

It's main purpose should just be for gathering oopses and you've a lot better
chance of getting an oops if you don't have some sketchy gpu accel in the way.

The acceleration that most of the 2D things provide isn't ever that
great, and shadowing is a lot more effective if done properly. It's a feature
that kernel ppl obsess over but I don't get a lot of real world feedback,
(booting 9000 scsi nodes with debug on takes a long time was possibly
something I heard once, and I think we resolved).

Dave.
