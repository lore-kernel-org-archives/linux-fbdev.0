From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH 0/2] fbdev: add fillrect and copyarea ioctls
Date: Tue, 14 Jul 2009 13:56:55 +1000
Message-ID: <21d7e9970907132056i1dd2eefbn290cb9ad8d318706@mail.gmail.com>
References: <20090713151709.GA1297@lilem.mirepesht>
	 <20090713084058.547e88f0@infradead.org>
	 <20090713162559.GA1279@lilem.mirepesht>
	 <21d7e9970907131746q4f1a34efw9d3e6efaa78aea34@mail.gmail.com>
	 <20090714034353.GA1280@lilem.mirepesht>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753459AbZGND45@vger.kernel.org>
In-Reply-To: <20090714034353.GA1280@lilem.mirepesht>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Ali Gholami Rudi <ali@rudi.ir>
Cc: Arjan van de Ven <arjan@infradead.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Andrea Righi <righi.andrea@gmail.com>, Krzysztof Helt <krzysztof.h1@wp.pl>, Greg Kroah-Hartman <gregkh@suse.de>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Philippe De Muyter <phdm@macqel.be>, linux-kernel@vger.kernel.org

On Tue, Jul 14, 2009 at 1:43 PM, Ali Gholami Rudi<ali@rudi.ir> wrote:
> Dave Airlie <airlied@gmail.com> wrote:
>> On Tue, Jul 14, 2009 at 2:25 AM, Ali Gholami Rudi<ali@rudi.ir> wrote=
:
>> > Arjan van de Ven <arjan@infradead.org> wrote:
>> >> can we turn this around, is there a reason to add them?
>> >> or in other words, how / where would these be used ?
>> >
>> > User-space programs that use framebuffer directly can use them. =A0=
I was
>> > writing a simple framebuffer virtual terminal (using libfreetype f=
or
>> > fonts; like fbterm); scrolling and painting boxes would be faster =
if
>> > there was someway of using hardware accelerated operations. =A0I t=
hink
>> > other similar programs can benefit, too.
>>
>> The general opinion is we should keep acceleration in userspace if a=
t
>> all possible.
>
> I see. =A0The line between user- and kernel-space for graphic applica=
tions
> is very blurred to me :-)
>
>> Not all hw can implement these usefully in the kernel, directfb
>
> AFAICT, many major ones like intelfb, radeonfb and nv implement them =
and
> those that can't, use a software implementation. =A0You mean they are
> unreliable or that there is little performance improvement because of
> the way those operations are implemented in the kernel?

Generally newer consumer HW can't implement a simple blit without using=
 the
3D engine which requires a large amount of state to be sent to the devi=
ce.
Keeping the state encoding and stuff out of the kernel and in userspace=
 is
generally seen as the right thing to do.

>> already does some
>> things for this.
>
> Sometime ago I did try running directfb on a radeon r300 and it faile=
d.
> I didn't try hard to see what's wrong but I got the impression that
> userspace apps are not good at using the hardware directly.

directfb has hw accel for different cards, really porting the code out =
of
the kernel for the cards you are interested in would probably benefit
more.

Dave.
