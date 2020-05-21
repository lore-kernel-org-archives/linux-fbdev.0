From: Changming Liu <liu.changm@northeastern.edu>
Date: Thu, 21 May 2020 01:15:00 +0000
Subject: [Bug Report] drivers/video/fbdev/kyro/fbdev.c: unsigned integer wrap-around might cause unexpected b
Message-Id: <BL0PR06MB45489A53C61DF15BF2F95B9CE5B70@BL0PR06MB4548.namprd06.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "Lu,
 Long" <l.lu@northeastern.edu>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "yaohway@gmail.com" <yaohway@gmail.com>

Hi Bartlomiej,
Greetings, I'm a first-year PhD student who is interested in the usage of UBSan for linux. 
And after some experiments, I found that in drivers/video/fbdev/kyro/fbdev.c
function kyro_dev_overlay_viewport_set, there is an unsigned integer overflow that might cause unexpected behavior.

More specifically, first at its caller, kyrofb_ioctl, after execution of copy_from_user at line 599, struct ol_viewport_set is filled with data from user space. 
And the 4 32bit unsigned integers from it are passed into kyro_dev_overlay_viewport_set. In function kyro_dev_overlay_viewport_set, 
x is added with ulWidth, y is added with ulHeight to transfer the length to the coordinate. 
And the result coordinate might overflow and wrap around. And it is passed into function SetOverlayViewPort.

It appears that in function SetOverlayViewPort, these values are treated as the coordinate of the bottom-right point and the wrap-around is not checked.(I might miss something).

Due to the lack of knowledge of the interaction between this module and the user space, I'm not able to assess if this is a benign wrap-around or whether the wrap-around could happen at all. 
I'd appreciate for you comment on this issue, this could help me understand linux and unsigned wrap around a lot.

Looking forward to your valuable response!

Best,
Changming Liu
