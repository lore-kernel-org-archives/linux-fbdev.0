From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] video: add sh_mobile_lcdcfb memory resource
Date: Tue, 12 May 2009 20:18:44 +0900
Message-ID: <aec7e5c30905120418l1c7027e2y1ff8ebf3752f682a@mail.gmail.com>
References: <20090512095745.25477.87326.sendpatchset@rx1.opensource.se>
	 <20090512105013.GA20500@linux-sh.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20090512105013.GA20500@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Tue, May 12, 2009 at 7:50 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, May 12, 2009 at 06:57:45PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@igel.co.jp>
>>
>> This patch adds memory resource support to the LCDC driver.
>> With this applied the physical memory range used for framebuffer
>> data will show up in /proc/iomem together with other SuperH
>> Mobile devices.
>>
>> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>
> Drivers have no place doing this on their own, besides, insert_resource()
> is not available to modules. The platform device code already takes care
> of this, so perhaps I am missing what the point of this change is?

Other SuperH Mobile multimedia blocks like the CEU and VEU/VPU/JPU all
get passed a physically contiguous area of memory as platform data. So
for those blocks the memory range show up in /proc/iomem. For the LCDC
this does not happen today.

Thanks for pointing out the module issue. I guess the proper fix would
be to pass a struct resource with memory to the LCDC driver as well
instead of this patch.

Cheeers,

/ magnus
