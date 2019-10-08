From: Yizhuo Zhai <yzhai003@ucr.edu>
Date: Tue, 08 Oct 2019 20:32:45 +0000
Subject: Uninitialized Variable Use in video: fbdev: pm3fb
Message-Id: <CABvMjLRE_Nxa1jC1o9uw_jsuAABdm+nE0ZNu-yh0hMzmfqEr_g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi All:

drivers/video/fbdev/pm3fb.c:

Inside function pm3fb_write_mode(),  variable "m" "n" "p" could leave
uninitialized after pm3fb_calculate_clock(), however, they are used
later in PM3_WRITE_DAC_REG, which is potentially unsafe.


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
