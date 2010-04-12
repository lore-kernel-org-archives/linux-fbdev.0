From: Dave Airlie <airlied@gmail.com>
Date: Mon, 12 Apr 2010 22:32:29 +0000
Subject: Re: [PATCH 1/3] fbmem: fix aperture overlapping check
Message-Id: <n2t21d7e9971004121532y394d2f29rf018d8f33769ba57@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1270929334-3742-1-git-send-email-marcin.slusarz@gmail.com>
	 <1271030068.3554.1.camel@localhost> <20100412113438.GB2789@joi.lan>
	 <1271104101.5726.3.camel@t60prh> <20100412213327.GA4463@joi.lan>
In-Reply-To: <20100412213327.GA4463@joi.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, nouveau@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Peter Jones <pjones@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

>
> Ok, thanks for explanation. I'll drop this patch and rebase the others.

Cool,

>> You won't be able to make this work for vga16fb from what I can see
>> since it access 0xa000 directly, not via any of the defined apertures
>> that vesafb/offb use. vga16fb will need a different approach I suspect.
>
> Yeah, there's an idea to claim 0xa0000 as an aperture of vga16fb and then
> do the same in KMS driver but only if it's the primary card.
> (You hinted to use SHADOW resource bit to check whether card is primary)
> I think I'll try this approach soon.

Yeah as long as we kick it off once, certain things like vga switcheroo change
who the primary gpu is at runtime.

but it should be okay if both drivers have the kickoff paths.

Dave.
