From: Egor Nogdor <denblomstertid@gmail.com>
Date: Mon, 08 Mar 2010 00:16:20 +0000
Subject: Beginner question about fbdev performance
Message-Id: <85f9cb1d1003071616w52392c0dq828f99b20c597ef3@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

Why is it that the unaccelerated framebuffer device is slower than
e.g. an accelerated X session when blitting data from main memory?
Shouldn't both cases involve simply copying data from RAM to VRAM?
What is the bottleneck in the former case?

Thanks,
Anders
