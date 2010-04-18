From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH 07/16] viafb: Add 1200x900 DCON/LCD panel modes for OLPC
 XO-1.5
Date: Sun, 18 Apr 2010 20:24:36 +0200
Message-ID: <4BCB4E64.4000407@gmx.de>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>	<1270746946-12467-8-git-send-email-corbet@lwn.net>	<4BBF9BC2.9070502@gmx.de> <20100418113930.1ba08ee3@bike.lwn.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100418113930.1ba08ee3@bike.lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

Jonathan Corbet schrieb:
> On Fri, 09 Apr 2010 23:27:30 +0200
> Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> 
>> What will happen if someone with no VX855 will try to enter 1200x900 
>> mode? Probably the world won't be destroyed but I have a really ugly 
>> feeling that the driver is not well prepared for this situation. 
> 
> OK, I'm certainly exposing my relative lack of understanding of
> framebuffer issues (I'm here to add a camera driver, remember? :),

Well I wasn't a graphics guy and just wanted a working display driver.

> but...is this really something that older chipsets can't handle?  Or is
> it just that nobody has had that size of panel before?

It's not the chipsets that are incapable (AFAIK) it's just that the 
patch is only adding the right PLL values for frequency generation for 
VX855 and set the values for all other chipsets to 0. Yeah that means 
this panel size wasn't supported before (by the driver). 0 is certainly 
not what we want and I think about replacing this whole fixed table with 
the formulas used in VIAs OpenSource X driver (although those are a bit 
more complicated I expected when I looked at unichrome). However this 
will certainly be a big change that needs a lot of thought and testing 
so nothing that will happen very soon.
I am just worried what will happen if one tries to set this mode with an 
older chipset. I'm pretty sure that it won't work and won't fail gracefully.

>> Haven't 
>> tested yet as I'm waiting for the official forward port but I think it 
>> might be better to reschedule this patch for later or add some PLL 
>> values that are supposed to work (using/executing the formulas in the 
>> VIA open source X driver)
> 
> If it's really not acceptable, then it will stay out, but I would
> rather get it merged.  I will leave it in the series for now; it can
> come out later if need be.

Yeah please leave it in the series for now. I'd just appreciate it very 
much if one were to generate the missing values before this gets into 
mainline....or replacing this hardcoded values.


Thanks,

Florian Tobias Schandinat
