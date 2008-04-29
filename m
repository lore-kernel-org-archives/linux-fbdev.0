From: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: intelfb and G33 / Q33 / Q35 chipsets support ?
Date: Tue, 29 Apr 2008 03:24:22 +0200
Message-ID: <481678C6.7050400@googlemail.com>
References: <4815EEB4.2060509@frugalware.org> <alpine.DEB.0.82.0804282016440.5277@skynet.skynet.ie>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756569AbYD2BYp@vger.kernel.org>
In-Reply-To: <alpine.DEB.0.82.0804282016440.5277@skynet.skynet.ie>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Dave Airlie <airlied@linux.ie>
Cc: Gabriel C <crazy@frugalware.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, Wang Zhenyu <zhenyu.z.wang@intel.com>

Dave Airlie wrote:
> On Mon, 28 Apr 2008, Gabriel C wrote:
> 
>> Hello ,
>>
>> are there any plans to add G33 / Q33 / Q35 chipsets support for the intelfb driver ?
>> Is this driver still maintained ?
>>
>> ( I'm not really sure who maintains this driver so I've add peoples to CC I saw worked on it ,
>> I've also added Wang Zhenyu to CC while he added this support for AGP )
>>
> 
> Intel fb is unmaintained (well I've done trivial fixes in the past), and 
> I'd rather not add new chipset support to it.
> 
> We are working (RH and Intel) on a new kernel modesetting layer which will 
> allow fbs integrated with proper memory management and support all intel 
> hw, 

Good news :)

Are there any patch(es) / git tree one could try out ?

> 
> The main problem with intelfb is it trips up the userspace X drivers a lot 
> and generally break things..

Really ? I didn't knew that. 

> 
> Dave.


Gabriel
