From: fuhz@free.fr
Date: Tue, 09 Mar 2010 09:50:32 +0000
Subject: How to know that a refresh is required ?
Message-Id: <1268128232.4b9619e871ed7@imp.free.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi !

I am currently writing a FrameBuffer driver for a custom embedded board.
I already read some documentation, including skeletonfb.c and vfb.c.

There are still some details that I don't really understand.

My board has a LCD controller which has its own internal buffer.
I am using DMA transfer to modify this buffer when I need to update the screen.

Programs using the framebuffer drivers (ie. gui apis) can write anytime to the
framebuffer internal buffer trough nmap.

My question : how do I know when to refresh my screen ?


Currently, I am thinking about these solutions :
- endless DMA transfer : the screen is always refresh (consumes power)
- timer based solution : refresh the screen every n milliseconds (latency)

I am waiting for your advices ! Are there other solutions ?

Thanks for all.


Best regards.

fuhz


PS:
I need to run GTK on an embedded board. So I guess writing a FrameBuffer driver
is not a bad choice.
