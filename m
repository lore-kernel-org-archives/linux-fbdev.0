From: Sasha Levin <sasha.levin@oracle.com>
Date: Mon, 05 Nov 2012 18:00:09 +0000
Subject: Re: tty, vt: lockdep warnings
Message-Id: <5097FEA9.2090603@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <50899507.1040900@oracle.com> <20121026143754.50277bd8@pyramind.ukuu.org.uk> <CA+1xoqdEesjh1EZvR_r7Hn0GUc7741EDWn59qagngcxg4=9bjQ@mail.gmail.com> <20121105175937.26f31d2a@pyramind.ukuu.org.uk>
In-Reply-To: <20121105175937.26f31d2a@pyramind.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sasha Levin <levinsasha928@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>, linux-fbdev@vger.kernel.org, florianSchandinat@gmx.de

On 11/05/2012 12:59 PM, Alan Cox wrote:
> On Mon, 5 Nov 2012 12:26:43 -0500
> Sasha Levin <levinsasha928@gmail.com> wrote:
> 
>> Ping? Should I bisect it?
>>
>> On Fri, Oct 26, 2012 at 9:37 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>> On Thu, 25 Oct 2012 15:37:43 -0400
>>> Sasha Levin <sasha.levin@oracle.com> wrote:
>>>
>>>> Hi all,
>>>>
>>>> While fuzzing with trinity inside a KVM tools (lkvm) guest running latest -next kernel,
>>>> I've stumbled on the following spew:
>>>
>>> Looks real enough but its not a tty/vt layer spew. This is all coming out
>>> of the core framebuffer code which doesn't seem to be able to decide what
>>> the locking rules at the invocation of fb_notifier_call_chain are.
>>>
>>> It might need some console layer tweaking to provide 'register console
>>> and I already hold the locks' or similar but that notifier needs some
>>> kind of sanity applying as well.
>>>
>>> Cc'ing the fbdev folks
> 
> I've cc'd the framebuffer folks. I can see why its occurring but I have
> no idea how they intend to fix it and I've not seen any replies.
> 
> Sorry but I've got enough other things on my plate right now without
> trying to deal with the locking brain damage that the fbdev layer is.
> 
> As far as I can tell the actual bug proper is years old.
> 
> Alan
> 

Ow, I figured it's something new since I've only now started seeing it in fuzz
tests, and it reproduces pretty much every time.


Thanks,
Sasha
