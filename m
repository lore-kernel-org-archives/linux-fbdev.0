From: Archit Taneja <architt@codeaurora.org>
Date: Fri, 11 Dec 2015 11:44:37 +0000
Subject: Re: [PATCH RFC 0/9] omapdrm/omapfb/omapdss split
Message-Id: <566AB455.6070301@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
 <566A69D8.2060607@codeaurora.org> <566A81EC.1090209@ti.com>
In-Reply-To: <566A81EC.1090209@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>



On 12/11/2015 01:27 PM, Tomi Valkeinen wrote:
>
> On 11/12/15 08:14, Archit Taneja wrote:
>
>> Is it possible to make omapfb get some of the old files (apply.c,
>> overlay.c, manager.c, sysfs files etc)? It might be helpful to have git
>> associate these files with omapfb/omap_vout since they have been the
>> only users of it. After cleanups, these files would eventually be
>> removed in the omapdrm copy, and it would be hard to track their history
>> using the omapfb copy.
>
> Good point. Unfortunately I don't know how I could do that...
>
> I need to keep all the files for a copy of omapdss intact, otherwise
> that copy won't work. So I need all the files for omapfb's copy, but I
> can't remove (i.e. move) any from the remaining copy...
>
> However, in the commit where I create the omapfb copy, I can add the
> original path in the commit description.

That should be good enough I guess.

Archit

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum, hosted by The Linux Foundation
