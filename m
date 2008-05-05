From: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: intelfb and G33 / Q33 / Q35 chipsets
	support ?
Date: Mon, 05 May 2008 22:59:31 +0200
Message-ID: <481F7533.6070503@googlemail.com>
References: <4815EEB4.2060509@frugalware.org> <4817A9D3.1030309@googlemail.com>
	<4817D687.8080201@googlemail.com>
	<200805050938.54453.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jt7mq-0007kb-Mx for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 13:59:52 -0700
Received: from smtp-out03.alice-dsl.net ([88.44.63.5])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jt7mp-0000Pm-Bt
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 13:59:52 -0700
In-Reply-To: <200805050938.54453.jbarnes@virtuousgeek.org>
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
> On Tuesday, April 29, 2008 7:16 pm Gabriel C wrote:
>>>> See the modesetting-101 branch of
>>>> git://git.freedesktop.org/git/mesa/drm. It's a bit rough in spots but
>>>> the i915 driver should be pretty close to feature parity with the Intel
>>>> X driver at this point.
>>> Thx , I will try out the tree.
>> modesetting-101 does not compile on current git , NOPAGE_SIGBUS , nopage
>> and friends gone.
> 
> Yeah the DRM tree doesn't have a full kernel included, so it'll occasionally 
> be out-of-sync.  You could try a different kernel version (it almost always 
> works with the last stable release of Linux) or merging DRM master into 
> modesetting-101.  Assuming there are no conflicts that might also fix 
> things. :)

Hehe yes , I noticed :)

I've fixed myself local but it died later with:

WARNING: "i2c_bit_add_bus" [/work/git/drm/linux-core/i915.ko] undefined!

I didn't got time to investigate this one.

> 
> Jesse
> 

Gabriel

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
