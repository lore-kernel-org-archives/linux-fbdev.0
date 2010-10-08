From: han jonghun <jonghun79.han@gmail.com>
Date: Fri, 08 Oct 2010 08:05:20 +0000
Subject: How to handle FBs for dual monitor
Message-Id: <AANLkTi=Z8i2WPseVMtTh5V7T3kpZ7RJ73VpoD_ivaW-r@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

I have a question how to handle dual display controller which controls
FBs and LCD panel.

Many SoCs have single display controller which supports multiple layers.
For example fb1 is for UI and fb0 is for video playback and so on.
So each layer is registered as framebuffer from /dev/fb0 to /dev/fb4.

   LCD
------------
    fb4
------------
    fb3
------------
    fb2
------------
    fb1
------------
    fb0
------------
lower layer

If there are two display controller to support dual display like as
dual monitor on Desk.
Each display controller handles each LCD. In that case /dev/fb0 ~
/dev/fb5 will be used as below.

  LCD0            LCD1
------------        ------------
    fb2               fb5
------------        ------------
    fb1               fb4
------------        ------------
    fb0               fb3
------------        ------------
lower layer    lower layer

If each FB only sees its own framebuffer, it does not matter.
But sometimes FBs should see the same framebuffer to support dual display.

For example I want to use single 960 x 800 framebuffer to support two
WVGA(480x800) LCDs.
And fb0(layer0@DISP.CON.0) looks at the left side of framebuffer,
fb3(layer0@DISP.CON.1) looks at the right side of framebuffer.
In this case should I handle only single fb(/dev/fb/0) not
two(/dev/fb0, /dev/fb3)?

How can I use dual display like this ? Is there any IOCTL COMMAND to use ?
How can I bind FBs and release the FBs ?
How can desktop support the feature ?

Can anyone help me?

Thanks

Best regards,
Jonhun Han.
