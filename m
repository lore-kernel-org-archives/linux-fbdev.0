From: Changming Liu <liu.changm@northeastern.edu>
Date: Fri, 22 May 2020 03:01:25 +0000
Subject: [Bug Report] drivers/video/fbdev/da8xx-fb.c: undefined behavior when left shifting
Message-Id: <BL0PR06MB45486287654FC3C2045A5655E5B40@BL0PR06MB4548.namprd06.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "Lu,
 Long" <l.lu@northeastern.edu>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "yaohway@gmail.com" <yaohway@gmail.com>

Hi Bartlomiej,
Greetings, it's me again, I sent you a bug report yesterday, I hope that find you well.

This time I found that in /drivers/video/fbdev/da8xx-fb.c
function lcd_cfg_vertical_sync, there might be an undefined result by left shifting.

More specifically, in function lcd_cfg_vertical_sync, line 437. back_porch is a signed integer 
which might come from user space. And it's logic AND with string literal 0xff. The result is then left shifted by 24 bits.

The problem is, since the logic AND produce a signed integer and the result of left shifting this signed integer
(whose lowest 8 bits not cleared) by 24 bits is undefined when its 8th bit is 1. Similar patterns can be found in line 410 as well.

I wonder if this bug is worth fixing? This can help me understand linux and UB a lot.

Looking forward to you valuable response.

Best regards,
Changming Liu
