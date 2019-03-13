From: Alexander Pateenok <pateenoc@gmail.com>
Date: Wed, 13 Mar 2019 14:54:18 +0000
Subject: Indirect call in vesafb driver
Message-Id: <20190313145418.bwta37cogo7a4qtt@K55DR>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

There're several indirect calls in inline assembly in vesafb driver
(drivers/video/fbdev/vesafb.c), and these calls cannot be automatically
changed to retpolines. It's in vesafb_pan_display():

   73        __asm__ __volatile__(
   74                "call *(%%edi)"

and in vesa_setpalette():

  113        __asm__ __volatile__(
  114         "call *(%%esi)"

Is there need to use CALL_NOSPEC ?

Thanks, Alex
