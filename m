From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH 0/2] fbdev: add fillrect and copyarea ioctls
Date: Tue, 14 Jul 2009 10:46:12 +1000
Message-ID: <21d7e9970907131746q4f1a34efw9d3e6efaa78aea34@mail.gmail.com>
References: <20090713151709.GA1297@lilem.mirepesht>
	 <20090713084058.547e88f0@infradead.org>
	 <20090713162559.GA1279@lilem.mirepesht>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752086AbZGNAqP@vger.kernel.org>
In-Reply-To: <20090713162559.GA1279@lilem.mirepesht>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Ali Gholami Rudi <ali@rudi.ir>
Cc: Arjan van de Ven <arjan@infradead.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Andrea Righi <righi.andrea@gmail.com>, Krzysztof Helt <krzysztof.h1@wp.pl>, Greg Kroah-Hartman <gregkh@suse.de>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Philippe De Muyter <phdm@macqel.be>, linux-kernel@vger.kernel.org

On Tue, Jul 14, 2009 at 2:25 AM, Ali Gholami Rudi<ali@rudi.ir> wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
>> On Mon, 13 Jul 2009 19:47:09 +0430
>> Ali Gholami Rudi <ali@rudi.ir> wrote:
>> > Is there any reason for not adding these ioctls to fbdev? =A0I sea=
rched
>> > the net and couldn't any. =A0Anyway, these patches simply implemen=
t
>> > those ioctls.
>> >
>>
>> can we turn this around, is there a reason to add them?
>> or in other words, how / where would these be used ?
>
> User-space programs that use framebuffer directly can use them. =A0I =
was
> writing a simple framebuffer virtual terminal (using libfreetype for
> fonts; like fbterm); scrolling and painting boxes would be faster if
> there was someway of using hardware accelerated operations. =A0I thin=
k
> other similar programs can benefit, too.

The general opinion is we should keep acceleration in userspace if at
all possible.

Not all hw can implement these usefully in the kernel, directfb
already does some
things for this.

Dave.
