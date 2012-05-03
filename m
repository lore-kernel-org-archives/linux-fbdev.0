From: Peter =?iso-8859-15?q?H=FCwe?= <PeterHuewe@gmx.de>
Date: Thu, 03 May 2012 21:40:33 +0000
Subject: Re: [PATCH v2] video/sis: Use SiS_DRAMType from init.h and annotate it __devinitconst
Message-Id: <201205032340.34483.PeterHuewe@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FA1BF76.8080109@gmx.de>
In-Reply-To: <4FA1BF76.8080109@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Florian,

> As far as I can see it should be possible to keep the array in
> sis_main.c and just delete it in the header files, shouldn't it? I'd
> prefer to do it this way.

Yes it is absolutely possible to leave it in sis_main.c and remove it from the 
header files. I already thought about this when creating the patch, but 
decided against it, as the 17*5 = 85 bytes are allocated on the stack, while 
they nicely can be put in the .devinit.rodata section ;)

With the patch:
344072  sis_main.o
1200950 sisfb.o
1217491 sisfb.ko

vs without the patch and removing it only from the header:
 344176  sis_main.o
1201056  sisfb.o
1217597  sisfb.ko -> ~100bytes more in the final module.

However I'm fine with this  and will remove it from the header and squash this 
together with the 
"video/sis: Remove unused structs SiS_SDRDRAM_TYPE/SiS_DDRDRAM_TYPE"
I also sent to you.


Thanks,
Peterq
