From: Sasha Levin <levinsasha928@gmail.com>
Date: Mon, 05 Nov 2012 17:26:43 +0000
Subject: Re: tty, vt: lockdep warnings
Message-Id: <CA+1xoqdEesjh1EZvR_r7Hn0GUc7741EDWn59qagngcxg4=9bjQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <50899507.1040900@oracle.com> <20121026143754.50277bd8@pyramind.ukuu.org.uk>
In-Reply-To: <20121026143754.50277bd8@pyramind.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sasha Levin <sasha.levin@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>, linux-fbdev@vger.kernel.org, florianSchandinat@gmx.de

Ping? Should I bisect it?

On Fri, Oct 26, 2012 at 9:37 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Thu, 25 Oct 2012 15:37:43 -0400
> Sasha Levin <sasha.levin@oracle.com> wrote:
>
>> Hi all,
>>
>> While fuzzing with trinity inside a KVM tools (lkvm) guest running latest -next kernel,
>> I've stumbled on the following spew:
>
> Looks real enough but its not a tty/vt layer spew. This is all coming out
> of the core framebuffer code which doesn't seem to be able to decide what
> the locking rules at the invocation of fb_notifier_call_chain are.
>
> It might need some console layer tweaking to provide 'register console
> and I already hold the locks' or similar but that notifier needs some
> kind of sanity applying as well.
>
> Cc'ing the fbdev folks
>
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
