From: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: intelfb and G33 / Q33 / Q35 chipsets
	support ?
Date: Tue, 06 May 2008 00:55:32 +0200
Message-ID: <481F9064.4080900@googlemail.com>
References: <4815EEB4.2060509@frugalware.org>
	<200805050938.54453.jbarnes@virtuousgeek.org>
	<481F7533.6070503@googlemail.com>
	<200805051411.03047.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jt9du-0002Tm-9e for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 15:58:46 -0700
Received: from smtp-out01.alice-dsl.net ([88.44.60.11])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jt9ds-0002Ee-Sl
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 15:58:46 -0700
In-Reply-To: <200805051411.03047.jbarnes@virtuousgeek.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Gabriel C <crazy@frugalware.org>, linux-fbdev-devel@lists.sourceforge.net, Wang Zhenyu <zhenyu.z.wang@intel.com>, "Antonino A. Daplas" <adaplas@gmail.com>, Dave Airlie <airlied@linux.ie>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Jesse Barnes wrote:
> On Monday, May 05, 2008 1:59 pm Gabriel C wrote:
>> Jesse Barnes wrote:
>>> On Tuesday, April 29, 2008 7:16 pm Gabriel C wrote:
>>>>>> See the modesetting-101 branch of
>>>>>> git://git.freedesktop.org/git/mesa/drm. It's a bit rough in spots but
>>>>>> the i915 driver should be pretty close to feature parity with the
>>>>>> Intel X driver at this point.
>>>>> Thx , I will try out the tree.
>>>> modesetting-101 does not compile on current git , NOPAGE_SIGBUS , nopage
>>>> and friends gone.
>>> Yeah the DRM tree doesn't have a full kernel included, so it'll
>>> occasionally be out-of-sync.  You could try a different kernel version
>>> (it almost always works with the last stable release of Linux) or merging
>>> DRM master into modesetting-101.  Assuming there are no conflicts that
>>> might also fix things. :)
>> Hehe yes , I noticed :)
>>
>> I've fixed myself local but it died later with:
>>
>> WARNING: "i2c_bit_add_bus" [/work/git/drm/linux-core/i915.ko] undefined!
>>
>> I didn't got time to investigate this one.
> 
> That can happen if the i2c stuff isn't loaded before the DRM module.  Usually 
> depmod picks this up, but if you have multiple versions lying around it may 
> pick the wrong one.  You can still load i2c-core etc. by hand though, and 
> then 'insmod i915 modeset=1'.

Right , got it to load at least that way.

It does not work here , with modeset=1 box hangs when staring X , without box magically reboots :-)

I guess I need to test it on 2.6.25 sometimes this week.

> 
> Jesse
> 
> 

Gabriel

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
