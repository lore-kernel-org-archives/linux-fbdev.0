From: Dave Airlie <airlied@gmail.com>
Date: Fri, 26 Feb 2010 08:50:04 +0000
Subject: Re: [PATCH 2/2] vga_switcheroo: initial implementation (v8)
Message-Id: <21d7e9971002260050h37eff655k3b667528b9cca333@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1267074476-28347-1-git-send-email-airlied@gmail.com>
	 <1267074476-28347-2-git-send-email-airlied@gmail.com>
	 <1267074476-28347-3-git-send-email-airlied@gmail.com>
	 <b170af451002250119y52c7097er995e7592248128c0@mail.gmail.com>
In-Reply-To: <b170af451002250119y52c7097er995e7592248128c0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.sf.net

Oh I should probably have dropped all the audio bits, I didn't even
see this reply
before I updated to v11.

The r600 audio code is a bit of disaster area hopefully we can clean it up, like
the timer was firing after the device was suspended.

I'll repost with all that r600 audio ripped out and you can fix the mess.
>
> Don't mess with r600_audio_* there. You call if for all chipsets which
> is not needed and break nice S&R layout, which is chipset specific.
>
> I guess you needed that because you didn't work on branch containing my patch:
> http://git.kernel.org/?p=linux/kernel/git/airlied/drm-2.6.git;a=commitdiff;h8fd2c6ff526e6a59edfa8e08f6f0724646784c4
> (you commited it to drm-linus)

This patch is now based on Linus tree, but yeah the original version
predates your
patches.

>> -int radeon_audio = 1;
>> +int radeon_audio = 0;
>
> Why?! What for we disable this feature by default?! If you see some
> reason for that, explain it to others please. I can change my mind,
> but for now I don't like this. It makes audio an option from just
> working-out-of-box.
>

Oversights, the audio was just broken in the presence of suspend/resume when
I wrote it.

Dave.
