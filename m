From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
Date: Wed, 15 Jun 2011 07:04:28 +0000
Subject: Re: Possible deadlock when suspending framebuffer
Message-Id: <BANLkTikRxJHa+kgOSObG4LYf4=zDMEoGyg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308100165.2113.4.camel@Tux>
	<20110615075803.3348b4ec@pluto.restena.lu>
	<BANLkTimiv5T6cgRjkDfPwjh-c5AivYzhmA@mail.gmail.com>
In-Reply-To: <BANLkTimiv5T6cgRjkDfPwjh-c5AivYzhmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: wanlong.gao@gmail.com
Cc: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Francis Moreau <francis.moro@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Jun 15, 2011 at 2:22 PM, Wanlong Gao <wanlong.gao@gmail.com> wrote:
> On Wed, Jun 15, 2011 at 1:58 PM, Bruno Pr=C3=A9mont
> <bonbons@linux-vserver.org> wrote:
>>
>> Hi,
>>
>> On Wed, 15 Jun 2011 09:09:24 Wanlong Gao <wanlong.gao@gmail.com> wrote:
>> > <snip>
>> > Hi Francis:
>> > can you test this patch?
>>
>> Do you have a deadlock trace which you are trying to fix?
> No, I just look at the code and try to fix this but I'm not sure.
> Can you teach me how to have a deadlock trace here?

CONFIG_LOCKDEP=3Dy
