From: suman <vijayendra.suman@gmail.com>
Date: Tue, 03 May 2011 11:48:58 +0000
Subject: Multiple Frame buffer /dev/fb1
Message-Id: <BANLkTi=ukcOQEUJnUzs3F0vmyriwN4PeXg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Dear Gorup,

I want to inquire about the vesafb driver, which provides only one
device node that is /dev/fb0.
I am trying to develop a qt UI for this i need to have another
framebuffer /dev/fb1, how can i add one more fb, should i use
framebuffer_alloc function to allocate a new frame buffer. Do you have
any patch for providing two frame buffers in case of vesafb driver. I
have tried on net and i failed to find any suitable patch for the
same.

-- 
Rgds
Vijayendra Suman
