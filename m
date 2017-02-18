From: Shaobo <shaobo@cs.utah.edu>
Date: Sat, 18 Feb 2017 07:26:18 +0000
Subject: Potential NULL pointer dereference in drivers/video/fbdev/sis/init.c
Message-Id: <22ff6151c00b3abef040afcd601c6b76@cs.utah.edu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Dear developers,

My name is Shaobo He and I am a graduate student at University of Utah. 
I am applying a static analysis tool to the Linux device drivers and got 
an error trace of null pointer dereference in 
drivers/video/fbdev/sis/init.c starting from function 
SiS_SetCRT1FIFO_630: pointer `queuedata` is initialized to NULL at line 
2409 and could get dereferenced at line 2501 if ModeNo <= 0x13 and 
SiS_Pr->ChipType = SIS_730. To be more specific, if ModeNo <= 0x13 then 
the locations (line 2449 or line 2451)where `queuedata` gets updated to 
a non null value is skipped. And if `SiS_Pr->ChipType = SIS_730`, then 
`queuedata` is dereferenced. As you can see, the error trace is only 
plausible since it depends on certain conditions. Therefore, I was 
wondering if you could confirm it.

Thanks for your time. I am looking forward to your reply.

Best,
Shaobo
