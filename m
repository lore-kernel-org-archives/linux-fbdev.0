From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Date: Fri, 08 Oct 2010 10:47:02 +0000
Subject: RE: How to handle FBs for dual monitor
Message-Id: <FCCFB4CDC6E5564B9182F639FC356087034B94B4B7@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTi=Z8i2WPseVMtTh5V7T3kpZ7RJ73VpoD_ivaW-r@mail.gmail.com>
In-Reply-To: <AANLkTi=Z8i2WPseVMtTh5V7T3kpZ7RJ73VpoD_ivaW-r@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of han jonghun
> Sent: Friday, October 08, 2010 1:35 PM
> To: linux-fbdev@vger.kernel.org
> Subject: How to handle FBs for dual monitor
> 
> Hi,
> 
> I have a question how to handle dual display controller which controls
> FBs and LCD panel.
> 
> If each FB only sees its own framebuffer, it does not matter.
> But sometimes FBs should see the same framebuffer to support dual display.
> 
> For example I want to use single 960 x 800 framebuffer to support two
> WVGA(480x800) LCDs.
> And fb0(layer0@DISP.CON.0) looks at the left side of framebuffer,
> fb3(layer0@DISP.CON.1) looks at the right side of framebuffer.
> In this case should I handle only single fb(/dev/fb/0) not
> two(/dev/fb0, /dev/fb3)?
[Senthil] I too have a similar scenario like this, and first thing comes to my mind is virtual framebuffer, but managing 2 devices memory by one virtual FB is the biggest challenge I am seeing in this.

> 
> How can I use dual display like this ? Is there any IOCTL COMMAND to use ?
> How can I bind FBs and release the FBs ?
> How can desktop support the feature ?
> 
> Can anyone help me?
> 
> Thanks
> 
> Best regards,
> Jonhun Han.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
