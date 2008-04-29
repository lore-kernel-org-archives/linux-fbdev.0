From: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: intelfb and G33 / Q33 / Q35 chipsets
	support ?
Date: Wed, 30 Apr 2008 01:05:55 +0200
Message-ID: <4817A9D3.1030309@googlemail.com>
References: <4815EEB4.2060509@frugalware.org>
	<alpine.DEB.0.82.0804282016440.5277@skynet.skynet.ie>
	<481678C6.7050400@googlemail.com>
	<200804291104.47687.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jqytm-0005va-0V for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 16:06:10 -0700
Received: from fg-out-1718.google.com ([72.14.220.153])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jqytl-00021o-Gu
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 16:06:09 -0700
Received: by fg-out-1718.google.com with SMTP id d23so165352fga.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 29 Apr 2008 16:06:07 -0700 (PDT)
In-Reply-To: <200804291104.47687.jbarnes@virtuousgeek.org>
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
> On Monday, April 28, 2008 6:24 pm Gabriel C wrote:
>> Dave Airlie wrote:
>>> On Mon, 28 Apr 2008, Gabriel C wrote:
>>>> Hello ,
>>>>
>>>> are there any plans to add G33 / Q33 / Q35 chipsets support for the
>>>> intelfb driver ? Is this driver still maintained ?
>>>>
>>>> ( I'm not really sure who maintains this driver so I've add peoples to
>>>> CC I saw worked on it , I've also added Wang Zhenyu to CC while he added
>>>> this support for AGP )
>>> Intel fb is unmaintained (well I've done trivial fixes in the past), and
>>> I'd rather not add new chipset support to it.
>>>
>>> We are working (RH and Intel) on a new kernel modesetting layer which
>>> will allow fbs integrated with proper memory management and support all
>>> intel hw,
>> Good news :)
>>
>> Are there any patch(es) / git tree one could try out ?
> 
> See the modesetting-101 branch of git://git.freedesktop.org/git/mesa/drm.  
> It's a bit rough in spots but the i915 driver should be pretty close to 
> feature parity with the Intel X driver at this point.

Thx , I will try out the tree.

> 
>>> The main problem with intelfb is it trips up the userspace X drivers a
>>> lot and generally break things..
>> Really ? I didn't knew that.
> 
> Yeah it's been an ongoing source of problems...
> 
> Jesse
> 

Gabriel

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
