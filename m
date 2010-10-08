From: han jonghun <jonghun79.han@gmail.com>
Date: Fri, 08 Oct 2010 15:17:50 +0000
Subject: Re: How to handle FBs for dual monitor
Message-Id: <AANLkTinc_zeUjHnFU4yvo2OxhbPjvLKP3xZtr1i1gTsQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTi=Z8i2WPseVMtTh5V7T3kpZ7RJ73VpoD_ivaW-r@mail.gmail.com>
In-Reply-To: <AANLkTi=Z8i2WPseVMtTh5V7T3kpZ7RJ73VpoD_ivaW-r@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi,

Thanks for comment.

Right. Xrandr handles virtual framebuffer.
I implemented that at the booting time FB allocates virtual framebuffer
of which the size was already promised.
After booting Xwindow opens another FB which also was promised.
Second opened FB(/dev/fb3) also  has the same fix.smem_start.
And each FB has different var.xoffset and var.yoffset.
It makes each FB see the different area of the framebuffer.

But in my opinion it is not a sophisticated implementation.
Do you have any idea for that ?
And is there a scenario which needs a mode exchanging
between coupled mode and separated mode on the fly?
Coupled mode means each FB sees the same framebuffer.
Separated mode means each FB sees its own framebuffer.

And the size of virtual framebuffer is usually bigger than 4MB.
When I use dma_alloc_writecombine, I can allocate framebuffer less
than 4MB due to MAX_ORDER(11).
How can I allocate framebuffer bigger than 4MB  with fixed MAX_ORDER ?

BRs,

2010/10/8 Guruswamy, Senthilvadivu <svadivu@ti.com>:
>
>
>> -----Original Message-----
>> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
>> owner@vger.kernel.org] On Behalf Of han jonghun
>> Sent: Friday, October 08, 2010 1:35 PM
>> To: linux-fbdev@vger.kernel.org
>> Subject: How to handle FBs for dual monitor
>>
>> Hi,
>>
>> I have a question how to handle dual display controller which controls
>> FBs and LCD panel.
>>
>> If each FB only sees its own framebuffer, it does not matter.
>> But sometimes FBs should see the same framebuffer to support dual displa=
y.
>>
>> For example I want to use single 960 x 800 framebuffer to support two
>> WVGA(480x800) LCDs.
>> And fb0(layer0@DISP.CON.0) looks at the left side of framebuffer,
>> fb3(layer0@DISP.CON.1) looks at the right side of framebuffer.
>> In this case should I handle only single fb(/dev/fb/0) not
>> two(/dev/fb0, /dev/fb3)?
> [Senthil] I too have a similar scenario like this, and first thing comes =
to my mind is virtual framebuffer, but managing 2 devices memory by one vir=
tual FB is the biggest challenge I am seeing in this.
>
>>
>> How can I use dual display like this ? Is there any IOCTL COMMAND to use=
 ?
>> How can I bind FBs and release the FBs ?
>> How can desktop support the feature ?
>>
>> Can anyone help me?
>>
>> Thanks
>>
>> Best regards,
>> Jonhun Han.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
