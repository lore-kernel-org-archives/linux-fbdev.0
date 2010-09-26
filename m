From: Daniel Drake <dsd@laptop.org>
Date: Sun, 26 Sep 2010 14:51:14 +0000
Subject: Re: [PATCH] viafb: don't setup TMDS if it doesn't exist
Message-Id: <AANLkTim3x=ZAaURDO-F0HLOfzbur6t0eoCKAzK7wWs+a@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100925195242.871699D401B@zog.reactivated.net>
In-Reply-To: <20100925195242.871699D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 25 September 2010 22:06, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
>> Strange. I was testing with linus master. Nothing comes up on the
>> screen at all, and the display controller dies a scary death (screen
>> fades in and out as if the world is ending). Do you know which version
>> of the XO-1.5 you are working with?
>
> It's probably just that you tested
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=summary
> while I'm talking about
> http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=summary
> which is pretty much what linus tree will look like after the next merge

You're right, linux-next works. It looks like you've fixed this
particular problem somehow for 2.6.37. Thanks!

Daniel
