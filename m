From: David Herrmann <dh.herrmann@gmail.com>
Date: Thu, 06 Mar 2014 12:16:34 +0000
Subject: Re: [PATCH 00/11] SimpleDRM & Sysfb
Message-Id: <CANq1E4TmACNwyANaUsWufJL1ne4pk4Gv+g4y7b6xeO=Po-SN9g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390486503-1504-1-git-send-email-dh.herrmann@gmail.com>
	<53145591.4070004@ti.com>
	<CANq1E4QJqB0CSNeSh2jsp90ZtcLwFwfSG=qjodSLdV_aGbL3BQ@mail.gmail.com>
	<53145D42.9080806@ti.com>
	<CANq1E4QYuMsj3W80jiyOfeYr+Xm=J096idyvgCUpFhADWR1ZvA@mail.gmail.com>
	<531465FF.1000201@ti.com>
In-Reply-To: <531465FF.1000201@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Ingo Molnar <mingo@kernel.org>

Hi Tomi

On Mon, Mar 3, 2014 at 12:22 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 03/03/14 13:09, David Herrmann wrote:
>
>>> What do you think, would it be possible to keep the sysfb stuff in
>>> arch/x86, and still be able to do the rest of the stuff here? And then
>>> move the sysfs from arch/x86 to drivers/video later?
>>
>> I don't think there's any need for that. Linus does conflict
>> resolution all day long, so a short hint in Dave's pull-request (plus
>> an example merge) should be enough. Same is true for -next, I think.
>
> True, but, well, the conflict with this one is not a few lines. "git
> diff |wc -l" gives 2494 lines for the conflict. It's not really complex
> to resolve that one, though, as it's really about copying all the stuff
> into its new place.
>
> So I'm not sure if that makes Linus think "this is simple one, 30 secs
> and done" or "who the f*** sends me this crap" ;). Especially for two
> reasons:
>
> - The fb-reogranization is not very critical, and often clean-ups are
> not worth it (although I think this one is good one, of course).
> - Conflicting fbdev changes coming from another tree
>
>> And this is really just a mechanical thing, nothing hard to do. But of
>> course, it's your decision. However, keeping the code in x86 is the
>> wrong thing to do. As discussed with Ingo, the patch that extends
>
> Yes, I didn't mean keeping the code in x86 for good, but just for one
> kernel version to make merging easier.
>
>> x86/sysfb is only provided for easier backporting. The followup patch
>> immediately removes it again and adds proper video/sysfb. I'd dislike
>> splitting these just to avoid merge conflicts. I can also maintain a
>> merge-fixup branch in my tree, if anyone wants that.
>
> You can have a try at merging. If you think it's trivial, maybe it is
> and we can just let Linus handle it:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git
> work/fb-reorder

Ok, I'm fine with delaying this one more merge-window. However, to
make things easier, could you pick up the two fbdev cleanups? These
are:
  fbdev: efifb: add dev->remove() callback
  fbdev: vesafb: add dev->remove() callback

They only add ->remove() callbacks which are never triggered currently
except with my sysfb series. But I'd like to drop both to make the
series smaller.

Thanks
David
