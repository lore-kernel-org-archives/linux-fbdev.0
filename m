From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 25 Sep 2010 21:06:29 +0000
Subject: Re: [PATCH] viafb: don't setup TMDS if it doesn't exist
Message-Id: <4C9E6455.5080607@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100925195242.871699D401B@zog.reactivated.net>
In-Reply-To: <20100925195242.871699D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Daniel Drake schrieb:
> On 25 September 2010 21:20, Florian Tobias Schandinat
> <FlorianSchandinat@gmx.de> wrote:
>> I wonder about that. Current linux-next with an unpatched viafb seems to
>> work well on my XO 1.5. I guess I should notice a missing output?
> 
> Strange. I was testing with linus master. Nothing comes up on the
> screen at all, and the display controller dies a scary death (screen
> fades in and out as if the world is ending). Do you know which version
> of the XO-1.5 you are working with?

It's probably just that you tested
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=summary
while I'm talking about
http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=summary
which is pretty much what linus tree will look like after the next merge window 
and includes
http://github.com/schandinat/linux-2.6/tree/viafb-next

I think the most relevant patch in it concerning the issue you mentioned is
http://github.com/schandinat/linux-2.6/commit/e029ab0d02b94d633d8e82a46dfdb7fd94a62216
at least that was the point in time where I got rid of the old OLPC-specific 
patch which disabled tmds and lvds identification.
(there still is a big diff between linus tree and the XO 1.5 tree I run but at 
least viafb should work well after the next merge window)


Thanks,

Florian Tobias Schandinat

