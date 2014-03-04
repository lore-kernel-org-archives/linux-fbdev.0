From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 04 Mar 2014 19:21:58 +0000
Subject: Re: [PATCH 0/3] Reorder drivers/video directory
Message-Id: <531627D6.6060007@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393502086-9433-1-git-send-email-tomi.valkeinen@ti.com> <5314412B.6060502@ti.com>
In-Reply-To: <5314412B.6060502@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 03/03/2014 12:45 AM, Tomi Valkeinen wrote:
> On 27/02/14 13:54, Tomi Valkeinen wrote:
>> Hi,
>>
>> This is a re-send of the series, with RFC removed from the subject, and a bunch
>> of acks added.
>>
>> I'm cc'ing more people, to make sure this doesn't come as a surprise, and to
>> make sure this is not a bad idea, doomed to fail horribly.
>>
>> So this series creates a new directory, drivers/video/fbdev/, to which all
>> fbdev related files are moved. Also, a new directory, drivers/video/fbdev/core/
>> is created, to which the core fbdev framework files are moved. This makes the
>> drivers/video hierarchy much more clear.
>>
>> Presuming no one has objections to this as such, I wonder what's the least
>> painful way to merge this? Normally, like any other fbdev change? As a separate
>> pull request, maybe at -rc2 time frame, based on -rc1? Something else?
>>
>>  Tomi
>>
>> Tomi Valkeinen (3):
>>   video: move fbdev to drivers/video/fbdev
>>   fbdev: move fbdev core files to separate directory
>>   video: Kconfig: move drm and fb into separate menus
> 
> I have pushed this to my for-next branch. Let's see what happens... At
> least I'm able to merge the current linux-next without any conflicts.

Thanks, I'm looking at this change in linux-next now.

EXYNOS_VIDEO seems to be a little bit odd.  Can you clarify that for me?
(This is not a change that you introduced.)


In particular, under Graphics support, select Framebuffer Devices.
This lists:
  Support for frame buffer devices -->
  Exynos Video driver support

It appears to me that Exynos either is a Framebuffer Device and should depend
on FB like the other drivers here do OR (actually XOR) it is not a frame buffer
device and it should not be listed here.

Then once that is cleared up :), we don't need 2 levels of menu to get to the
list of FB drivers -- i.e., one of those levels can be removed.

Oh, and if you keep the new menu item "Framebuffer Devices", please spell it
like the other entry (Frame Buffer).


Other than those nits, I like this change very much.  Thanks.

-- 
~Randy
