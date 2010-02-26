From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Fri, 26 Feb 2010 11:09:28 +0000
Subject: Re: [PATCH] Add sysfs support for fbdefio delay
Message-Id: <45a44e481002260309of5b51c9t79302ec5fa132b9e@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201002252215.o1PMFnoP011425@mustang.cs.nmsu.edu>
	 <45a44e481002251830j710e87bah52486a489eef04cb@mail.gmail.com>
	 <20100226115305.3dcc1f5a@neptune.home>
In-Reply-To: <20100226115305.3dcc1f5a@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, linux-kernel@vger.kernel.org, npavel@ituner.com, tomi.valkeinen@nokia.com, tony@atomide.com, FlorianSchandinat@gmx.de, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, jkosina@suse.cz

On Fri, Feb 26, 2010 at 6:53 PM, Bruno Pr=E9mont
<bonbons@linux-vserver.org> wrote:
> For me the driver would start with a default delay that matches the
> full-redraw throughput of the device but userspace could reduce the
> delay when it knows it will mostly just refresh small parts of the
> display (one or two tiles) and would like those done at a higher rate.

Who in userspace will know to reduce the delay? How will it know that
the delay should be reduced?

>
> A sample application would be displaying a media player interface
> like the one of XMMS and clones where Umeter (the part displaying
> volume per frequency range) could be refreshed ten times a second,
> the current position once a second and all the rest only on song
> change.

xmms/umeter will talk to this sysfs entry?

>
> Knowing the size of the display, probability that it's being used
> directly by X server is very small, it would rather be some application
> using it as a sideport display.
>

Yes, I'd like to know which applications these are.

Thanks,
jaya
