From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: [ PATCH-LINK ] fb accel capabilities - take
 2
Date: Fri, 28 May 2004 13:58:35 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40B7296B.4030804@winischhofer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030402010402050807040805"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTg1a-0002An-Kr
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 May 2004 04:59:46 -0700
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BTg1a-0006fK-1Q
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 May 2004 04:59:46 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030402010402050807040805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------030402010402050807040805
Content-Type: message/rfc822;
 name="Re: [Linux-fbdev-devel] [ PATCH-LINK ] fb accel capabilities - take 2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: [Linux-fbdev-devel] [ PATCH-LINK ] fb accel capabilities - take 2"

Message-ID: <40B72225.4090901@winischhofer.net>
Date: Fri, 28 May 2004 13:27:33 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Eger <eger@theboonies.us>
Subject: Re: [Linux-fbdev-devel] [ PATCH-LINK ] fb accel capabilities - take
 2
References: <40B691DF.4060509@winischhofer.net> <1085715488.40b6b42062e3c@mail.theboonies.us>
In-Reply-To: <1085715488.40b6b42062e3c@mail.theboonies.us>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Eger wrote:
> Thomas Winischhofer eloquently put:
> 
>>David Eger wrote:
>> > If the patch looks good to you (James, Geert, BenH), I'd like to
>> > forward it on to Linus followed by the individual driver updates
>> > (that'll take a little longer -- I need to revise how drivers do
>> > things like remember noaccel, etc. and update them).
>>
>>How about properly documenting what you actually do and let the driver
>>maintainer handle the implementation?
> 
> 
> see the update to skeletonfb.c

I saw that but no explanation on eg. the new PAN flags; what has hw 
accel with panning to do? Or do these just mean that the driver CAN pan?

>>General question (not to you only): How about considering the 2.6 series
>>as "stable" as everybody else does and keep it to fixing bugs instead of
>>change the driver API the Xth time?
> 
> 
> 
> If you want to handle the fix for sisfb, please do, I'll skip over that one ;-)

Yes please. However, you may very well do the changes yourself, but 
please mail them to me as the maintainer and not directly to the kernel 
maintainer.

> It's all part of fixing bugs ;-)  When my "accelerated" fb driver is still
> super-slow, i consider that a bug.  And it's a bug of the framebuffer
> subsystem, not really of the drivers.  Your lovely
> SiS310SubsequentScreenToScreenCopy() and friends (do I smell xfree86 code here?
> ;-) ) 

Yes, you do ;) (I wrote that, too, so it would have been a waste not 
recycling it)

> would probably work great if they were ever called.  Currently, they're
> not :-P

Erm, I wasn't aware of this. Interesting... Personally, since sisfb does 
y-panning I didn't see any speed regressions compared with 2.4 yet.

> The patch (a later version mailed to lkml against mainline) fixes an issue
> discussed in a large thread previously.  The Linux 2.6 fbdriver/kernel
> interface is opaque as to what hardware acceleration a video card *actually*
> provides.  There are a bunch of entry-points, but they're often done by
> software.  This patch fixes the framebuffer interface so that fbcon (currently
> the only app that really lives on top of the fb subsystem) can sanely choose
> its method of rendering.

I thought the acceleration features are all used opaquely (?) through 
the fb_ops structure... what's that one good for if I also need to set a 
flag for each supported function? The NULLs in the structure are to be 
filled out by the layer above using the non-accelerated functions.... Me 
thought.

Allright, keep on doing what you do. But please be more verbose in the 
include files as to what the flags actually mean.

Are these to set/cleared exclusively by the driver or must the driver 
expect them to change? (I mean for example that fbset in 2.4 could be 
used to disable acceleration, which is important to DirectFB)

Is there any driver already finished so that I can look it up somewhere?

Will an old driver (status as of now) work at all with the new flags not 
being touched? Will it compile? (That *should* work IMHO)

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org


--------------030402010402050807040805--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
