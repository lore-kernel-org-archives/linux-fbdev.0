From: Heiko Schocher <hs@denx.de>
Date: Tue, 22 Mar 2011 08:25:03 +0000
Subject: Re: [PATCH 3/4 v5] video, sm501: add OF binding to support SM501
Message-Id: <4D885CDF.3010206@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1296026490-14665-1-git-send-email-hs@denx.de>
	<4D7F14B0.1030008@denx.de>
	<20110316153601.GA13315@linux-sh.org> <4D81A668.8060500@denx.de>
	<20110322082047.GG25925@linux-sh.org>
In-Reply-To: <20110322082047.GG25925-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Vincent Sanders <vince-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>

Hello Paul,

Paul Mundt wrote:
> On Thu, Mar 17, 2011 at 07:12:56AM +0100, Heiko Schocher wrote:
>> Paul Mundt schrieb:
>>> On Tue, Mar 15, 2011 at 08:26:40AM +0100, Heiko Schocher wrote:
>>>>> 0003-video-sm501-add-OF-binding-to-support-SM501.patch has no obvious style problems and is ready for submission.
>>>>>
>>>>>  Documentation/powerpc/dts-bindings/sm501.txt |   34 +++++++++++++++++++++
>>>>>  drivers/mfd/sm501.c                          |    9 +++++-
>>>>>  drivers/video/sm501fb.c                      |   42 ++++++++++++++++++++++++--
>>>>>  3 files changed, 81 insertions(+), 4 deletions(-)
>>>>>  create mode 100644 Documentation/powerpc/dts-bindings/sm501.txt
>>>> This patchset is pending know for a while. I got Acked by from
>>>>
>>>> Samuel Ortiz for the mfd part, see here:
>>>>
>>>> http://www.spinics.net/lists/linux-fbdev/msg02550.html
>>>> http://linux.derkeiler.com/Mailing-Lists/Kernel/2011-01/msg11798.html
>>>>
>>>> and for the DTS part from Benjamin Herrenschmidt:
>>>>
>>>> http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-February/088279.html
>>>>
>>>> Are there some more issues?
>>>>
>>> Not that I remember off the top of my head, but I think they've been lost
>>> in my backlog. Could you re-send the current series with the appropriate
>>> acked-bys? If there's nothing else obvious outstanding I'll roll them in.
>> Ok, I resend them (I also rebase them to current tree, ok?)
>>
> Ok, I've dug them up on l-k in the meantime and applied 1-3. 4/4 doesn't
> apply due to a missing dts file, but I assume you're aware of that and
> will take care of it separately. Let me know if I've overlooked anything,
> and sorry for the delay!

No problem!

Just working on this patchset (rebase and check if it boots/works) ... will
post the update (with all patches again) in some minutes, so please wait
for it.

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
