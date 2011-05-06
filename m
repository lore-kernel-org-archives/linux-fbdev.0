From: Daniel J Blueman <daniel.blueman@gmail.com>
Date: Fri, 06 May 2011 02:38:58 +0000
Subject: Re: [2.6.39-rc2, framebuffer] use after free oops
Message-Id: <BANLkTikF5YL8tJ_f5510yy1Ywm69rOUK2A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BANLkTi=8U3=E0=j8MJ-r70O_aO8Pxvv9Nw@mail.gmail.com>
	<BANLkTi=F8u7oZM+=W+5vzmvf1b0YiN0fQg@mail.gmail.com>
	<20110420080535.3edd11ac@pluto.restena.lu>
	<20110420105631.70695dfa@lxorguk.ukuu.org.uk>
In-Reply-To: <20110420105631.70695dfa@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On 20 April 2011 17:56, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Wed, 20 Apr 2011 08:05:35 +0200
> Bruno Pr=E9mont <bonbons@linux-vserver.org> wrote:
>
>> On Wed, 20 Apr 2011 13:50:10 Daniel J Blueman <daniel.blueman@gmail.com>=
 wrote:
>> > Any ideas on how best to address this issue [0], since it causes
>> > silent corruption, or at best crashes?
>>
>> There is probably no easy short-term fix to this...
>
> The short term fix would be to deliberately leak the buffer. That should
> go into 2.6.39-rc right now with a comment explaining the situation.
> Otherwise who knows what corruption may occur to user data if unlucky.
>
> The other 'cheat' might be to tweak the API so the removal API isn't a
> 'destroy' interface but a 'shut down' and has a matching 'restart' one
> for when the intelfb unloads at which point vga16fb can carry on with the
> original fb_info 8)

It looks like Andy Whitcroft addressed this issue some time ago, but
forgot to send the fix upstream:

http://kernel.ubuntu.com/git?p=3Dubuntu/ubuntu-natty.git;a=3Dpatch;h=C5a742=
b5f78e161d6a13853a7e3e6e1dfa429e69;hp&a1443f67eea17d4b78ef75df701782cc8bf35b

Let's hope it can hit -rc7 since it's been in Ubuntu's kernel tree for
considerable time, and fixes a silent corrupter:

http://groups.google.com/group/linux.kernel/browse_thread/thread/fc9083f6f3=
80ed5b/f801112b840785cb?show_docid=F801112b840785cb

Thanks,
  Daniel
--=20
Daniel J Blueman
