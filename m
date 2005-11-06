From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [2.6 patch] drivers/video/: possible cleanups
Date: Sun, 06 Nov 2005 20:44:03 +0800
Message-ID: <436DFA93.8070002@gmail.com>
References: <20051106005026.GE3668@stusta.de> <436D9AF3.8040008@pol.net> <20051106111743.GA3847@stusta.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750744AbVKFMoU@vger.kernel.org>
In-Reply-To: <20051106111743.GA3847@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Nov 06, 2005 at 01:56:03PM +0800, Antonino A. Daplas wrote:
>> Adrian Bunk wrote:
>>>
>>> --- linux-2.6.14-rc5-mm1-full/drivers/video/console/softcursor.c.old	2005-11-06 00:31:15.000000000 +0100
>>> +++ linux-2.6.14-rc5-mm1-full/drivers/video/console/softcursor.c	2005-11-06 00:31:30.000000000 +0100
>>> @@ -17,6 +17,8 @@
>>>  #include <asm/uaccess.h>
>>>  #include <asm/io.h>
>>>  
>>> +#include "fbcon.h"
>> I don't think softcursor needs anything in fbcon.h. The rest looks okay.
> 
> fbcon.h contains the function prototype for soft_cursor().

Ahh, you're right.  I forgot that I moved it to the console directory.

Tony
