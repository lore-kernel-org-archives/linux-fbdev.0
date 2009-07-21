From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 5/5] at91/atmel_lcdfb: add at91sam9g10 support to atmel
 LCD driver
Date: Tue, 21 Jul 2009 11:31:24 +0200
Message-ID: <4A658AEC.3030000@atmel.com>
References: <1245341772-1689-1-git-send-email-nicolas.ferre@atmel.com>	<1245341772-1689-6-git-send-email-nicolas.ferre@atmel.com>	<4A51D2D5.2030707@atmel.com> <20090720152427.b63bb3bd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754161AbZGUJbw@vger.kernel.org>
In-Reply-To: <20090720152427.b63bb3bd.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, avictor.za@gmail.com, patrice.vilchez@atmel.com, linux-kernel@vger.kernel.org, hong.xu@atmel.com

Andrew Morton :
> On Mon, 06 Jul 2009 12:32:53 +0200
> Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> 
>> Hi,
>>
>> Nicolas Ferre :
>>> From: Hong Xu <hong.xu@atmel.com>
>>>
>>> Modify atmel LCD driver: atmel_lcdfb for at91sam9g10.  This add a clock
>>> management equivalent to at91sam9261.
>> Can we consider an inclusion in linux-fbdev ?
> 
> The patch looks OK to me.
> 
>>> Signed-off-by: Hong Xu <hong.xu@atmel.com>
>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Andrew Victor added his:
>> Acked-by: Andrew Victor <linux@maxim.org.za>
>>
>>> ---
>>>  drivers/video/Kconfig           |    4 ++--
>>>  drivers/video/atmel_lcdfb.c     |    6 ++++--
>>>  drivers/video/backlight/Kconfig |    2 +-
>>>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> Please merge it via an ARM tree?

Ok, queued in arm patch tracking system with number: 5614/1
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5614/1

Thanks, Bye,
-- 
Nicolas Ferre
