From: David Binderman <linuxdev.baldrick@gmail.com>
Date: Tue, 07 Jun 2016 15:37:56 +0000
Subject: linux-4.7-rc2/drivers/video/fbdev/sis/init.c: 2* bad if tests ?
Message-Id: <CAMzoamYsL-4arwG1xu7=efhvaN9dNXpNXy=duBPHXrGxApfo6w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: thomas@winischhofer.net, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dcb314@hotmail.com

Hello there,

1.

linux-4.7-rc2/drivers/video/fbdev/sis/init.c:358]: (style) Redundant
condition: If 'LCDwidth >= 800', the comparison 'LCDwidth >= 600' is
always true.

Source code is

       if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >= 800) && (LCDwidth >= 600)))

Maybe better code

       if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >= 800) && (LCDheight >= 600)))

2.

linux-4.7-rc2/drivers/video/fbdev/sis/init.c:363]: (style) Redundant
condition: If 'LCDwidth >= 1024', the comparison 'LCDwidth >= 768' is
always true.

Source code is

        if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >= 1024) &&
(LCDwidth >= 768))) {

Duplicate.

Also in the same file:


[drivers/video/fbdev/sis/init.c:2663]: (style) Variable 'resindex' is
assigned a value that is never used.
[drivers/video/fbdev/sis/init.c:3562]: (style) Variable 'HBS' is
assigned a value that is never used.
[drivers/video/fbdev/sis/init.c:3616]: (style) Variable 'VBS' is
assigned a value that is never used.
[drivers/video/fbdev/sis/init.c:3597]: (style) Variable 'A' is
assigned a value that is never used.

Suggest either use these variables in some way, or delete them.

Regards

David Binderman
